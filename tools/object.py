
class Section:
    def __init__(self, name, align):
        self.name = name
        self.text = []
        self.labels = {}
        self.refs = []
        self.align = align
        self.offset = None
        self.__ip = 0

    def toDict(self):
        return {"name": self.name, "align": self.align, "text": self.text, "labels": self.labels, "refs": self.refs}

    @staticmethod
    def fromDict(d):
        o = Section(d["name"], d["align"])
        o.text = d["text"]
        o.labels = d["labels"]
        o.refs = d["refs"]
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

class Object:
    def __init__(self):
        self.name = ""
        self.globalSymbols = []
        self.exportSymbols = []
        self.sections = []
        self.consts = {}
        self.__allocated = False
        self.__curSectionIndex = -1

    def toDict(self):
        return {
            "globalSymbols": self.globalSymbols,
            "exportSymbols": self.exportSymbols,
            "sections": [s.toDict() for s in self.sections],
            "consts": self.consts
        }

    @staticmethod
    def fromDict(name, d):
        o = Object()
        o.name = name
        o.globalSymbols = d["globalSymbols"]
        o.exportSymbols = d["exportSymbols"]
        o.sections = [Section.fromDict(s) for s in d["sections"]]
        o.consts = d["consts"]
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
        self.__checkRedefinition(name)
        self.sections[self.__curSectionIndex].defineLabel(name)

    def defineConstant(self, name, value):
        self.consts[name] = value

    def declareGlobal(self, name):
        self.__checkRedefinition(name)
        self.globalSymbols += [name]

    def declareExport(self, name):
        for s in self.sections:
            if name in s.labels:
                self.exportSymbols += [name]
                return
        if name in self.consts:
            self.exportSymbols += [name]
            return
        raise ValueError("Label is not defined: {}".format(name))

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

    def __checkRedefinition(self, name):
        for s in self.sections:
            if name in s.labels:
                raise ValueError("Label redifinition: {}".format(name))
        if name in self.globalSymbols:
            raise ValueError("Label redifinition: {}".format(name))
