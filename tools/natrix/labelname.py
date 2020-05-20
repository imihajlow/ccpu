def getTempName(n):
    return "__cc_tmp_{}".format(n)

def getLocalName(fn, name):
    return "__cc_loc_{}_{}".format(fn, name)

def getArgumentName(fn, index):
	return "{}_arg{}".format(fn, index)

def getReturnName(fn):
	return "{}_ret".format(fn)

def getReserveBeginLabel(fn):
	return "__cc_{}_frame_begin".format(fn)

def getReserveEndLabel(fn):
	return "__cc_{}_frame_end".format(fn)

def getReturnAddressLabel(fn):
	return "__cc_{}_ret_addr".format(fn)

def getGenLabel(n, comment):
    return "__gen_{}_{}".format(n, comment)
