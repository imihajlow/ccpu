def signExpand(x, size):
	sign = bool(x & (1 << (size * 8 - 1)))
	if sign:
		return x | (~0 << (size * 8))
	else:
		return x

def gt(x, y, size):
	return signExpand(x, size) > signExpand(y, size)

def lt(x, y, size):
	return signExpand(x, size) < signExpand(y, size)

def ge(x, y, size):
	return signExpand(x, size) >= signExpand(y, size)

def le(x, y, size):
	return signExpand(x, size) <= signExpand(y, size)

def op(op, x, y, size):
	return {"gt": gt, "lt": lt, "ge": ge, "le": le}[op](x, y, size)
