from value import Value

def genDeref(resultLoc, srcLoc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType().deref())
    if srcLoc.getType().deref() != resultLoc.getType():
        raise ValueError("Incompatible types for deref: {} and {}".format(srcLoc.getType().deref(), resultLoc.getType()))
    return resultLoc, "{} = deref({})\n".format(resultLoc, srcLoc)

def genUnary(op, resultLoc, srcLoc):
    if srcLoc.getType().isUnknown():
        raise ValueError("Unknown source type")
    if op == 'deref':
        return genDeref(resultLoc, srcLoc)
    else:
        if resultLoc.getType().isUnknown():
            resultLoc = resultLoc.removeUnknown(srcLoc.getType())
        if resultLoc.getType() != srcLoc.getType():
            raise ValueError("Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
        return resultLoc, "{} = {}({})\n".format(resultLoc, op, srcLoc)

def genBinary(op, resultLoc, src1Loc, src2Loc):
    if src1Loc.getType().isUnknown() or src2Loc.getType().isUnknown():
        raise ValueError("Unknown source type")
    if src1Loc.getType() != src2Loc.getType():
        raise ValueError("Incompatible source types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(src1Loc.getType())
    if resultLoc.getType() != src1Loc.getType():
        raise ValueError("Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
    return resultLoc, "{} = {}({}, {})\n".format(resultLoc, op, src1Loc, src2Loc)
