
def __lo(x):
    return x & 0xff

def __hi(x):
    return (x >> 8) & 0xff

__allowedBuiltins = {"abs": abs, "ord": ord, "len": len, "max": max, "min": min, "round": round, "lo": __lo, "hi": __hi, "int": int, "bool": bool}

def evaluate(e, gl=None, loc=None):
    gls = {"__builtins__": __allowedBuiltins}
    if gl is not None:
        gls.update(gl)
    return eval(e, gls, loc)

class NameExtractor:
    def __init__(self, builtins):
        self._builtins = builtins
        self.syms = set()

    def __getitem__(self, name):
        if name in self._builtins:
            raise KeyError()
        else:
            self.syms.add(name)
            return 0

def extractVarNames(e):
    gls = {"__builtins__": __allowedBuiltins}
    ne = NameExtractor(__allowedBuiltins)
    eval(e, gls, ne)
    return list(ne.syms)
