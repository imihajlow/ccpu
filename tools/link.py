#!/usr/bin/env python3
import argparse
import json
import re
from object import Object
from expression import evaluate
import layout

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

def link(objects):
    ip = 0
    globalSymbols = set()
    # place sections into segments and keep track of globals
    for segment in layout.layout:
        if segment["begin"] is not None:
            if ip > segment["begin"]:
                raise LinkerError("segment overflow: IP is beyond segment `{}' begin".format(segment["name"]))
            ip = segment["begin"]
        segBegin = ip
        for o in objects:
            globalSymbols.update(o.globalSymbols)
            for s in o.sections:
                if s.name == segment["name"]:
                    s.offset = align(ip, s.align)
                    ip = s.offset + len(s.text)
                    if segment["end"] is not None and ip > segment["end"]:
                        raise LinkerError("segment overflow: IP is beyond segment `{}' end".format(segment["name"]), o, s)
                    if ip > 0xffff:
                        raise LinkerError("64k overflow", o, s)
        print("Segment {}: {} bytes (0x{:04X}-0x{:04X})".format(segment["name"], ip - segBegin, segBegin, ip))
    # assign global symbol values
    globalSymbolValues = {}
    for o in objects:
        for s in o.sections:
            for label in s.labels:
                if label in globalSymbols:
                    if label in globalSymbolValues:
                        raise LinkerError("global symbol `{}' redifinition".format(label), o, s)
                    globalSymbolValues[label] = s.offset + s.labels[label]
        for label in o.consts:
            if label in globalSymbols:
                if label in globalSymbolValues:
                    raise LinkerError("global symbol `{}' redifinition".format(label), o)
                globalSymbolValues[label] = o.consts[label]
    # assign local symbol values and evaluate references
    symbolMap = globalSymbolValues.copy()
    for o in objects:
        localSymbolValues = {}
        for s in o.sections:
            for label in s.labels:
                value = s.offset + s.labels[label]
                localSymbolValues[label] = value
                if label not in globalSymbols:
                    symbolMap["{}_{}".format(o.name, label)] = value
        localSymbolValues.update(o.consts)
        for s in o.sections:
            for offs,expr in s.refs:
                try:
                    value = evaluate(expr, globalSymbolValues, localSymbolValues)
                    s.text[offs] = value & 255
                except BaseException as e:
                    raise LinkerError("error evaluating {}: {}".format(expr, e))
    return symbolMap

def createRom(objects):
    rom = [None] * 65536
    for o in objects:
        for s in o.sections:
            if s.offset is None:
                raise LinkerError("section wasn't laid out", o, s)
            for i,v in enumerate(s.text):
                rom[s.offset + i] = v
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
    parser.add_argument('-m', metavar="MAPFILE", required=False, type=argparse.FileType("w"), help='map file name')
    parser.add_argument('file', nargs="+", help='input files')
    args = parser.parse_args()
    objects = [load(filename) for filename in args.file]
    symbolMap = link(objects)
    rom = createRom(objects)
    save(rom, args.o, args.type, args.full, args.filler)
    saveLabels(args.m, symbolMap)
