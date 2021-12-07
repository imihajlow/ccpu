def getTempName(n, fn):
    return f"__cc_{fn}_tmp_{n}"

def getLocalName(fn, name):
    return "__cc_loc_{}_{}".format(fn, name)

def getArgumentName(fn, index, outside):
    return "{}_arg{}{}".format(fn, index, "" if outside else "_local")

def getReturnName(fn, outside):
    return "{}_ret{}".format(fn, "" if outside else "_local")

def getReserveBeginLabel(fn):
    return "__cc_{}_frame_begin".format(fn)

def getReserveEndLabel(fn):
    return "__cc_{}_frame_end".format(fn)

def getReturnAddressLabel(fn):
    return "__cc_{}_ret_addr".format(fn)

def getGenLabel(n, comment):
    return "__gen_{}_{}".format(n, comment)
