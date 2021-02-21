#!/usr/bin/env python3
import importlib
import argparse
import json
import re
import sys
from object import Object
from expression import evaluate

class LinkerError(Exception):
    def __init__(self, message, obj=None, section=None):
        self.obj = obj
        self.section = section
        self.message = message

    def __str__(self):
        if self.obj is not None:
            return "Error in object {}: {}".format(self.obj.name, self.message)
        else:
            return "Link error: {}".format(self.message)

def align(ip, alignment):
    if alignment == 0:
        return ip
    d,m = divmod(ip, alignment)
    if m > 0:
        return (d + 1) * alignment
    else:
        return ip

def fitSectionsSimple(begin, sections):
    ip = begin
    for s in sections:
        s.offset = align(ip, s.align)
        ip = s.offset + len(s.text)
        if ip > 0xffff:
            raise LinkerError("64k overflow", o, s)
    return ip

def fitSectionsFill(begin, sections):
    sections = sorted(sections, key=lambda s: s.align, reverse=True)
    ip = begin
    holes = [] # start, length
    for s in sections:
        l = len(s.text)
        foundHole = False
        for i in range(len(holes)):
            holeStart,holeSize = holes[i]
            alignment = align(holeStart, s.align) - holeStart
            if holeSize >= l + alignment:
                foundHole = True
                s.offset = holeStart + alignment
                holes.pop(i)
                if alignment > 0:
                    holes.append((holeStart, alignment))
                holeTail = holeSize - alignment - l
                if holeTail > 0:
                    holes.append((holeStart + alignment + l, holeTail))
                break
        if not foundHole:
            alignment = align(ip, s.align) - ip
            if alignment > 0:
                holes.append((ip, alignment))
            s.offset = ip + alignment
            ip = s.offset + len(s.text)
            if ip > 0xffff:
                raise LinkerError("64k overflow", o, s)
    return ip

def link(objects, layout, fit):
    ip = 0
    globalSymbols = set()
    exportedSymbolValues = {}
    segments = {}
    # place sections into segments and keep track of globals
    for segment in layout.layout:
        if segment["begin"] is not None:
            if ip > segment["begin"]:
                raise LinkerError("segment overflow: IP is beyond segment `{}' begin".format(segment["name"]))
            ip = segment["begin"]
        segBegin = ip
        sectionList = []
        for o in objects:
            globalSymbols.update(o.globalSymbols)
            for s in o.sections:
                if s.name == segment["name"]:
                    sectionList.append(s)
        ip = fit(ip, sectionList)
        if segment["end"] is not None:
            end = segment["end"]
            if end < ip:
                raise LinkerError("Segment overflow: IP is beyond segment `{}' end".format(segment["name"]), o, s)
            ip = segment["end"]
        segments[segment["name"]] = segBegin, ip
    # update origin segments sizes
    ip = 0
    for i, segment in enumerate(layout.layout):
        segName = segment["name"]
        target = segment["target"]
        begin, end = segments[segName]
        if begin < ip:
            raise LinkerError("Segment `{}' is overlapped".format(segName))
        if target is not None:
            if begin != end:
                raise LinkerError("Non-empty origin segment `{}'".format(segment["name"]))
            targetBegin, targetEnd = segments[target]
            targetSize = targetEnd - targetBegin
            end = begin + targetSize
            segments[segName] = begin, end
    # report segment sizes
    for name in segments:
        begin, end = segments[name]
        if begin != end:
            print("Segment {}: {} bytes (0x{:04X}-0x{:04X})".format(name, end - begin, begin, end))
        exportedSymbolValues["__seg_{}_begin".format(name)] = begin
        exportedSymbolValues["__seg_{}_end".format(name)] = end
    # assign global symbol values
    for o in objects:
        for label in o.exportSymbols:
            found = False
            for s in o.sections:
                if label in s.labels:
                    if label in exportedSymbolValues:
                        raise LinkerError("global symbol `{}' redifinition".format(label), o, s)
                    exportedSymbolValues[label] = s.offset + s.labels[label]
                    found = True
            if label in o.consts:
                if label in exportedSymbolValues:
                    raise LinkerError("global symbol `{}' redifinition".format(label), o)
                exportedSymbolValues[label] = o.consts[label]
                found = True
            if not found:
                raise LinkerError("symbol `{}' is exported, but not defined".format(label), o)
    # assign local symbol values and evaluate references
    symbolMap = exportedSymbolValues.copy()
    for o in objects:
        for sym in o.globalSymbols:
            if sym not in exportedSymbolValues:
                raise LinkerError("unresolved external symbol `{}'".format(sym), o)
        localSymbolValues = {}
        for s in o.sections:
            for label in s.labels:
                value = s.offset + s.labels[label]
                localSymbolValues[label] = value
                if label not in o.exportSymbols:
                    symbolMap["{}_{}".format(o.name, label)] = value
        localSymbolValues.update(o.consts)
        for s in o.sections:
            for offs,expr in s.refs:
                try:
                    value = evaluate(expr, exportedSymbolValues, localSymbolValues)
                    s.text[offs] = value & 255
                except BaseException as e:
                    raise LinkerError("error evaluating {}: {}".format(expr, e))
    return symbolMap, segments

def createRom(objects, segments):
    rom = [None] * 65536
    for o in objects:
        for s in o.sections:
            if s.offset is None:
                raise LinkerError("section wasn't laid out", o, s)
            seg = layout.findSegment(s.name)
            segBegin = segments[s.name][0]
            for i,v in enumerate(s.text):
                rom[s.offset + i] = v
                if seg["shadow"] is not None:
                    offsetInsideSegment = s.offset + i - segBegin
                    shadowBegin = segments[seg["shadow"]][0]
                    rom[shadowBegin + offsetInsideSegment] = v
    return rom

def load(filename):
    with open(filename, "r") as f:
        objectName = "_" + re.sub(r"\W", "_", filename)
        return Object.fromDict(objectName, json.load(f))

def save(data, filename, type, full, filler):
    mode = "wb" if type == "bin" else "w"
    with open(filename, mode) as file:
        if type == "hex":
            for i,x in enumerate(data[0:65536 if full else 32768]):
                if x is None:
                    file.write("xx")
                else:
                    file.write("{:02X}".format(x))
                if i % 16 == 15:
                    file.write("\n")
                else:
                    file.write(" ")
        elif type == "bin":
            ba = bytearray(filler if x is None else x for x in data[0:65536 if full else 32768])
            file.write(ba)

def saveLabels(file, labels):
    if file is not None:
        for label in labels:
            file.write("{} = 0x{:04x}\n".format(label, labels[label]))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Linker')
    parser.add_argument('-o', metavar="RESULT", required=True, help='output file name')
    parser.add_argument('--type', choices=["hex", "bin"], default="bin", help='output file type (default: bin)')
    parser.add_argument('--filler', type=int, default=0xff, help="value to fill uninitialized memory (bin output type only)")
    parser.add_argument('--full', required=False, default=False, action='store_true', help='generate full 64k or memory, otherwise just 32k for the ROM')
    parser.add_argument('--layout', choices=["default", "sim"], default="default", help='memory layout')
    parser.add_argument('--fit-strategy', choices=["fill", "simple"], default="fill", help='fit strategy')
    parser.add_argument('-m', metavar="MAPFILE", required=False, type=argparse.FileType("w"), help='map file name')
    parser.add_argument('file', nargs="+", help='input files')
    args = parser.parse_args()
    layout = importlib.import_module("." + args.layout, "layouts")
    try:
        objects = [load(filename) for filename in args.file]
        fitters = {"fill": fitSectionsFill, "simple": fitSectionsSimple}
        symbolMap, segments = link(objects, layout, fitters[args.fit_strategy])
        rom = createRom(objects, segments)
        save(rom, args.o, args.type, args.full, args.filler)
        saveLabels(args.m, symbolMap)
    except LinkerError as e:
        sys.stderr.write(str(e) + "\n")
        sys.exit(1)
