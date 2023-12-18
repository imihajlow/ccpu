#!/usr/bin/env python3
import argparse
import json
import re
import sys
import yaml
import os
import unix_ar
import pathlib
from layout import Layout
from object import Object
from expression import evaluate, extractVarNames

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


class SectionsFilter:
    def __init__(self, objects, layout, gcSections, api):
        self.gcSections = gcSections
        # Build refs anyway, because this way the external refs are checked
        globalSymbols = dict() # symbol name -> section name
        refs = dict() # section name -> set(section name)
        rootSections = set()
        for segment in layout:
            name = segment["name"]
            globalSymbols[f"__seg_{name}_begin"] = name
            globalSymbols[f"__seg_{name}_end"] = name
        for o in objects:
            for s in o.sections:
                if s.name == s.segment:
                    rootSections.add(s.name)
                refs[s.name] = set()
                for l in s.labels:
                    if l in o.exportSymbols:
                        if l in globalSymbols:
                            raise LinkerError(f"global symbol `{l}` redifinition", o)
                        else:
                            globalSymbols[l] = s.name
            for l in o.consts:
                if l in o.exportSymbols:
                    if l in globalSymbols:
                        raise LinkerError(f"global symbol `{l}` redifinition", o)
                    else:
                        globalSymbols[l] = None
        for o in objects:
            localSymbols = dict()
            for s in o.sections:
                for l in s.labels:
                    localSymbols[l] = s.name
            for l in o.consts:
                localSymbols[l] = None
            for s in o.sections:
                for _, l in s.refs:
                    names = extractVarNames(l)
                    for n in names:
                        if n in o.globalSymbols:
                            if n in api:
                                pass
                            elif n in globalSymbols:
                                refs[s.name].add(globalSymbols[n])
                            else:
                                raise LinkerError(f"unresolved external symbol `{n}`", o)
                        elif n in localSymbols:
                            refs[s.name].add(localSymbols[n])
                        else:
                            raise LinkerError(f"unresolved symbol `{n}`", o)
        self.reachable = set()
        toVisit = list(rootSections)
        while len(toVisit) > 0:
            s = toVisit.pop(0)
            if s not in self.reachable:
                self.reachable.add(s)
                if s in refs:
                    for name in refs[s]:
                        if name is not None:
                            toVisit.append(name)

    def filter(self, sections):
        if not self.gcSections:
            return sections
        else:
            return (s for s in sections if s.name in self.reachable)

    def isReachable(self, section):
        if not self.gcSections:
            return True
        else:
            return section.name in self.reachable

class SymbolMap:
    def __init__(self, globalSymbols):
        self._labels = { None: globalSymbols.copy() } # objectName -> {label -> ip}
        self._lines = {} # filename -> {line -> ip}

    def addLabel(self, objName, label, ip):
        if objName not in self._labels:
            self._labels[objName] = {}
        self._labels[objName][label] = ip

    def addLineInfo(self, offset, mapping):
        for filename in mapping:
            if filename not in self._lines:
                self._lines[filename] = {}
            d = self._lines[filename]
            m = mapping[filename]
            for line in m:
                d[int(line)] = offset + m[line]

    def save(self, f):
        if f is not None:
            yaml.dump({"labels": self._labels, "lines": self._lines}, f)

def tryFitSections(objects, layout, fit, sectionsFilter, bloatSize):
    segments = {}
    ip = 0
    for segmentIdx in range(len(layout.layout)):
        segment = layout.layout[segmentIdx]
        if segment["begin"] is not None:
            if ip > segment["begin"]:
                raise LinkerError("segment overflow: IP is beyond segment `{}' begin".format(segment["name"]))
            ip = segment["begin"]
        if segment["min-begin"] is not None:
            ip = max(ip, segment["min-begin"])
        segBegin = ip
        sectionList = []
        for o in objects:
            for s in sectionsFilter.filter(o.sections):
                if s.segment == segment["name"]:
                    sectionList.append(s)
        ip = fit(ip, sectionList)
        if segment["end"] is not None:
            end = segment["end"]
            if end == "bloat":
                ip += bloatSize
            else:
                if end < ip:
                    raise LinkerError("Segment overflow: IP is beyond segment `{}' end".format(segment["name"]), o, s)
                ip = segment["end"]
        segments[segment["name"]] = segBegin, ip
    return segments

def fitSections(objects, layout, fit, sectionsFilter):
    hasBloatSegment = any(seg["end"] == "bloat" for seg in layout.layout)
    if hasBloatSegment:
        lowerLimit = 0
        upperLimit = 65536
        bloatSize = (upperLimit + lowerLimit) // 2
        bestLayout = None
        while bloatSize != lowerLimit and bloatSize != upperLimit:
            try:
               bestLayout = tryFitSections(objects, layout, fit, sectionsFilter, bloatSize)
               lowerLimit = bloatSize
               bloatSize = (bloatSize + upperLimit) // 2
            except LinkerError:
                upperLimit = bloatSize
                bloatSize = (bloatSize + lowerLimit) // 2
        if bestLayout is None:
            raise LinkerError("No size of the bloat segment produced suitable output")
        return bestLayout
    else:
        return tryFitSections(objects, layout, fit, sectionsFilter, None)

def link(objects, layout, fit, sectionsFilter, api):
    ip = 0
    exportedSymbolValues = dict()
    # place sections into segments
    segments = fitSections(objects, layout, fit, sectionsFilter)

    # update origin segments sizes
    ip = 0
    for segment in layout.layout:
        segName = segment["name"]
        target = segment["target"]
        begin, end = segments[segName]
        if target is not None:
            if begin != end:
                raise LinkerError("Non-empty origin segment `{}'".format(segment["name"]))
            begin = ip
        if begin < ip:
            raise LinkerError("Segment `{}' is overlapped".format(segName))
        if target is not None:
            targetBegin, targetEnd = segments[target]
            targetSize = targetEnd - targetBegin
            end = begin + targetSize
            segments[segName] = begin, end
        ip = end
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
                    if label in api:
                        if sectionsFilter.isReachable(s):
                            raise LinkerError(f"conflicting definitions of global symbol `{label}' in api and in object", o, s)
                        exportedSymbolValues[label] = api[label]
                    elif label in exportedSymbolValues:
                        raise LinkerError("global symbol `{}' redifinition".format(label), o, s)
                    elif sectionsFilter.isReachable(s):
                        exportedSymbolValues[label] = s.offset + s.labels[label]
                    found = True
            if label in o.consts:
                if label in api:
                        exportedSymbolValues[label] = api[label]
                elif label in exportedSymbolValues:
                    raise LinkerError("global symbol `{}' redifinition".format(label), o)
                else:
                    exportedSymbolValues[label] = o.consts[label]
                found = True
            if not found:
                raise LinkerError("symbol `{}' is exported, but not defined".format(label), o)
    # assign local symbol values and evaluate references
    symbolMap = SymbolMap(exportedSymbolValues)
    apiOut = dict()
    for o in objects:
        localSymbolValues = {}
        for s in sectionsFilter.filter(o.sections):
            for label in s.labels:
                value = s.offset + s.labels[label]
                localSymbolValues[label] = value
                if label not in o.exportSymbols:
                    symbolMap.addLabel(o.name, label, value)
                else:
                    apiOut[label] = value
            symbolMap.addLineInfo(s.offset, s.lineInfo)
        localSymbolValues.update(o.consts)
        for label in o.consts:
            if label in o.exportSymbols:
                apiOut[label] = o.consts[label]
        exportedSymbolValues.update(api)
        for s in sectionsFilter.filter(o.sections):
            for offs,expr in s.refs:
                try:
                    value = evaluate(expr, exportedSymbolValues, localSymbolValues)
                    s.text[offs] = value & 255
                except BaseException as e:
                    raise LinkerError("error evaluating {}: {}".format(expr, e))
    return symbolMap, apiOut, segments

def createRom(objects, segments, sectionsFilter, layout):
    rom = [None] * 65536
    for o in objects:
        for s in sectionsFilter.filter(o.sections):
            if s.offset is None:
                raise LinkerError("section wasn't laid out", o, s)
            seg = layout.findSegment(s.segment)
            segBegin = segments[s.segment][0]
            for i,v in enumerate(s.text):
                if seg["init"]:
                    rom[s.offset + i] = v
                if seg["shadow"] is not None:
                    offsetInsideSegment = s.offset + i - segBegin
                    shadowBegin = segments[seg["shadow"]][0]
                    rom[shadowBegin + offsetInsideSegment] = v
    return rom

def loadObj(filename):
    with open(filename, "r") as f:
        return Object.fromDict(filename, json.load(f))

def loadLib(libname):
    r = []
    ar = unix_ar.open(libname, "r")
    for obj in ar.infolist():
        filename = obj.name.decode()
        if filename.endswith(".o"):
            file = ar.open(filename)
            data = file.read().decode()
            r += [Object.fromDict(filename, json.loads(data))]
        else:
            print(f"Library {libname}: unknown file format: {filename}")
    ar.close()
    return r

def findLib(libpath, libname):
    for p in libpath:
        path = f"{p}/lib{libname}.a"
        if os.path.isfile(path):
            return path
    raise LinkerError(f"Library -l{libname} cannot be found")

def load(filenames, libpath, libs):
    r = []
    for filename in filenames:
        if filename.endswith(".o"):
            r += [loadObj(filename)]
        elif filename.endswith(".a"):
            r += loadLib(filename)
        else:
            raise LinkerError(f"Unknown file format: {filename}")
    if libs is not None:
        for lib in libs:
            filename = findLib(libpath, lib)
            r += loadLib(filename)
    return r


def save(data, filename, type, full, filler, slim):
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
            if slim:
                n = 0
                for i,x in enumerate(data):
                    if x is not None:
                        n = i + 1
                ba = bytearray(filler if x is None else x for x in data[0:n])
            else:
                ba = bytearray(filler if x is None else x for x in data[0:65536 if full else 32768])
            file.write(ba)

def saveLabels(file, labels):
    if file is not None:
        for label in labels:
            file.write("{} = 0x{:04x}\n".format(label, labels[label]))

def loadApi(file):
    if file is None:
        return dict()
    g = dict()
    r = re.compile(r"^(\w+)\s*=\s*(0x[0-9a-f]+)$", re.I)
    for line in file.readlines():
        m = re.match(r, line.strip())
        if m is not None:
            g[m.group(1)] = int(m.group(2), 0)
        else:
            print(f"Unmatched: {line.strip()}")
    return g

def findLayouts():
    r = re.compile(r"^([a-z].*)\.yaml$")
    for file in os.listdir(os.path.join(os.path.dirname(os.path.realpath(__file__)), "layouts")):
        m = re.match(r, file)
        if m is not None:
            yield m.group(1)

def loadLayout(name):
    if name is None:
        name = "default"
    if '.' in name:
        return Layout(name)
    else:
        return Layout(os.path.join(os.path.dirname(os.path.realpath(__file__)), "layouts", f"{name}.yaml"))

def checkFlagsCompatibility(objects):
    flags = None
    root = None
    for o in objects:
        if flags is None:
            if not o.flags.isDefault():
                flags = o.flags
                root = o
        else:
            if not flags.isCompatible(o.flags):
                raise LinkerError(f"Flags are incompatible with {root.name}", o)

if __name__ == '__main__':
    layouts = list(findLayouts())
    parser = argparse.ArgumentParser(description='Linker')
    parser.add_argument('-o', metavar="RESULT", required=True, help='output file name')
    parser.add_argument('--type', choices=["hex", "bin"], default="bin", help='output file type (default: bin)')
    parser.add_argument('--filler', type=int, default=0xff, help="value to fill uninitialized memory (bin output type only)")
    parser.add_argument('--full', required=False, default=False, action='store_true', help='generate full 64k or memory, otherwise just 32k for the ROM')
    parser.add_argument('--slim', required=False, default=False, action='store_true', help='do not fill the file up to 32k/64k')
    parser.add_argument('--layout', default=None, help=f'memory layout: yaml file or one of built-in layouts ({", ".join(layouts)})')
    parser.add_argument('--fit-strategy', choices=["fill", "simple"], default="fill", help='fit strategy')
    parser.add_argument('--no-gc-sections', action='store_true', default=False, help='drop unreachable sections')
    parser.add_argument('--api-in', metavar="MAPFILE", required=False, type=argparse.FileType("r"), help='external global symbols list')
    parser.add_argument('--api-out', metavar="MAPFILE", required=False, type=argparse.FileType("w"), help='generate external global symbols list')
    parser.add_argument('-m', metavar="MAPFILE", required=False, help='map file name')
    parser.add_argument('-l', metavar="LIBRARY", required=False, action="append", help='static library')
    parser.add_argument('-L', metavar="LIBPATH", required=False, action="append", help='static library path')
    parser.add_argument('file', nargs="+", help='input files')
    args = parser.parse_args()
    layout = loadLayout(args.layout)
    try:
        apiIn = loadApi(args.api_in)
        objects = load(args.file, args.L, args.l)
        checkFlagsCompatibility(objects)
        for o in objects:
            if len(o.weakSymbols) != 0:
                raise LinkerError("TODO: weak symbols are not supported yet", o)
        fitters = {"fill": fitSectionsFill, "simple": fitSectionsSimple}
        sectionsFilter = SectionsFilter(objects, layout.layout, not args.no_gc_sections, apiIn)
        symbolMap, apiOut, segments = link(objects, layout, fitters[args.fit_strategy], sectionsFilter, apiIn)
        rom = createRom(objects, segments, sectionsFilter, layout)
        save(rom, args.o, args.type, args.full, args.filler, args.slim)
        map_file_name = args.m
        if map_file_name is None:
            map_file_name = pathlib.Path(args.o).with_suffix(".map")
        with open(map_file_name, "w") as f:
            symbolMap.save(f)
        saveLabels(args.api_out, apiOut)
    except LinkerError as e:
        sys.stderr.write(str(e) + "\n")
        sys.exit(1)
