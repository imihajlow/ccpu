
def __lo(x):
    return x & 0xff

def __hi(x):
    return (x >> 8) & 0xff

__allowedBuiltins = {"abs": abs, "ord": ord, "len": len, "max": max, "min": min, "round": round, "lo": __lo, "hi": __hi}

def evaluate(e, gl=None, loc=None):
    gls = {"__builtins__": __allowedBuiltins}
    if gl is not None:
        gls.update(gl)
    return eval(e, gls, loc)
