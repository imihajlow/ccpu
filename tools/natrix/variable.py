def getTempName(n):
    return "__cc_tmp_{}".format(n)

def getLocalName(fn, name):
    return "__cc_loc_{}_{}".format(fn, name)

def getArgumentName(fn, index):
	return "{}_arg{}".format(fn, index)

def getReturnName(fn):
	return "{}_ret".format(fn)
