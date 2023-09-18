
class Section:
    def __init__(self, name, align):
        self.segment = name.split('.', 1)[0]
        self.name = name
        self.text = []
        self.labels = {}
        self.refs = []
        self.align = align
        self.offset = None
        self.lineInfo = {} # filename -> (line -> ip)
        self.__ip = 0

    def toDict(self):
        return {"segment": self.segment, "name": self.name, "align": self.align, "text": self.text, "labels": self.labels, "refs": self.refs, "lines": self.lineInfo}

    @staticmethod
    def fromDict(d):
        o = Section(d["name"], d["align"])
        o.text = d["text"]
        o.labels = d["labels"]
        o.refs = d["refs"]
        o.lineInfo = d["lines"]
        return o

    def advance(self, n):
        self.__ip += n

    def allocate(self):
        self.text = [0] * self.__ip
        self.__ip = 0

    def defineLabel(self, name):
        self.labels[name] = self.__ip

    def placeValue(self, v):
        for i,x in enumerate(v):
            self.text[self.__ip + i] = x

    def placeExpression(self, offset, x):
        self.refs += [(self.__ip + offset, x)]

    def setLineNumber(self, f, n):
        if f not in self.lineInfo:
            self.lineInfo[f] = {}
        if n not in self.lineInfo[f]:
            self.lineInfo[f][n] = self.__ip

class Flags:
    NO_STACK = 1
    HW_STACK = 2

    def __init__(self, f):
        self._f = f

    def __eq__(self, other):
        return self._f == other._f

    def __str__(self):
        result = []
        if bool(self._f & Flags.NO_STACK):
            result += ["NO_STACK"]
        if bool(self._f & Flags.HW_STACK):
            result += ["HW_STACK"]
        return ",".join(result)

    def isDefault(self):
        return self._f == 0

    def isCompatible(self, other):
        return bool(self._f & other._f) or self.isDefault() or other.isDefault()

    @staticmethod
    def fromString(s):
        fls = s.split(',')
        result = 0
        for f in fls:
            if f == "NO_STACK":
                result |= Flags.NO_STACK
            elif f == "HW_STACK":
                result |= Flags.HW_STACK
            elif len(f) > 0:
                raise ValueError(f"Unrecognized object flag: {f}")
        return Flags(result)

class Object:
    def __init__(self):
        self.name = ""
        self.flags = Flags(0)
        self.globalSymbols = []
        self.exportSymbols = []
        self.weakSymbols = []
        self.sections = []
        self.consts = {}
        self.__allocated = False
        self.__curSectionIndex = -1
        self.__sourceFilename = None

    def toDict(self):
        return {
            "globalSymbols": self.globalSymbols,
            "exportSymbols": self.exportSymbols,
            "weakSymbols": self.weakSymbols,
            "sections": [s.toDict() for s in self.sections],
            "consts": self.consts,
            "flags": str(self.flags),
        }

    @staticmethod
    def fromDict(name, d):
        o = Object()
        o.name = name
        o.globalSymbols = d["globalSymbols"]
        o.exportSymbols = d["exportSymbols"]
        o.weakSymbols = d["weakSymbols"]
        o.sections = [Section.fromDict(s) for s in d["sections"]]
        o.consts = d["consts"]
        o.flags = Flags.fromString(d["flags"])
        return o

    def beginSection(self, name, alignment):
        if not self.__allocated:
            self.sections += [Section(name, alignment)]
        self.__curSectionIndex += 1

    def advance(self, n):
        if n > 0:
            if self.__curSectionIndex == -1:
                raise ValueError("No section")
            self.sections[self.__curSectionIndex].advance(n)

    def align(self, n):
        if not self.__allocated:
            self.sections += [Section(self.sections[-1].name, n)]
        self.__curSectionIndex += 1

    def defineLabel(self, name):
        self.__checkRedefinition(name, False)
        self.sections[self.__curSectionIndex].defineLabel(name)

    def defineConstant(self, name, value):
        self.consts[name] = value

    def declareGlobal(self, name):
        self.__checkRedefinition(name, True)
        self.globalSymbols += [name]

    def declareExport(self, name):
        self.__checkDefined(name)
        self.exportSymbols += [name]

    def declareWeakExport(self, name):
        self.__checkDefined(name)
        self.weakSymbols += [name]

    def allocate(self):
        for s in self.sections:
            s.allocate()
        self.__allocated = True
        self.__curSectionIndex = -1

    def placeValue(self, v):
        self.sections[self.__curSectionIndex].placeValue(v)

    def placeExpression(self, offset, x):
        self.sections[self.__curSectionIndex].placeExpression(offset, x)

    def getMockGlobals(self):
        return {l: 0 for l in self.globalSymbols}

    def getMockLocals(self):
        result = dict()
        for s in self.sections:
            result.update((l, 0) for l in s.labels)
        result.update(self.consts)
        return result

    def setSource(self, n):
        self.__sourceFilename = n

    def setLineNumber(self, n):
        if self.__sourceFilename is not None:
            self.sections[self.__curSectionIndex].setLineNumber(self.__sourceFilename, n)

    def __checkRedefinition(self, name, isGlobal):
        for s in self.sections:
            if name in s.labels:
                raise ValueError("Label redifinition: {}".format(name))
        if not isGlobal and name in self.globalSymbols:
            raise ValueError("Label redifinition: {}".format(name))

    def __checkDefined(self, name):
        for s in self.sections:
            if name in s.labels:
                return
        if name in self.consts:
            return
        raise ValueError("Label is not defined: {}".format(name))
