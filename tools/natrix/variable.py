def getTempName(n):
    return "__cc_tmp_{}".format(n)

def getLocalName(fn, name):
    return "__cc_loc_{}_{}".format(fn, name)
