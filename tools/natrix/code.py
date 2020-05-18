from value import Value

def genMove(resultLoc, srcLoc):
    # TODO if a copy can be avoided, avoid it and return srcLoc
    if srcLoc.getType().isUnknown():
        raise ValueError("Unknown source type")
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise ValueError("Incompatible types to assign: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    if srcLoc == resultLoc:
        return resultLoc, ""
    else:
        return resultLoc, "{} = {}\n".format(resultLoc, srcLoc)

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
    if op == 'add':
        return genAdd(resultLoc, src1Loc, src2Loc)
    else:
        if src1Loc.getType() != src2Loc.getType():
            raise ValueError("Incompatible source types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
        if resultLoc.getType().isUnknown():
            resultLoc = resultLoc.removeUnknown(src1Loc.getType())
        if resultLoc.getType() != src1Loc.getType():
            raise ValueError("Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
        return resultLoc, "{} = {}({}, {})\n".format(resultLoc, op, src1Loc, src2Loc)

def genPutIndirect(resultAddrLoc, srcLoc, offset=0):
    if srcLoc.getType().isUnknown():
        raise ValueError("Unknown source type")
    if resultAddrLoc.getType().isUnknown():
        resultAddrLoc = resultAddrLoc.removeUnknown(srcLoc.getType())
    if resultAddrLoc.getType().deref() != srcLoc.getType():
        raise ValueError("Incompatible types for put indirect: {} and {}".format(resultAddrLoc.getType().deref(), srcLoc.getType()))
    if offset == 0:
        return resultAddrLoc, "*{} = {}\n".format(resultAddrLoc, srcLoc)
    else:
        return resultAddrLoc, "*({} + {}) = {}\n".format(resultAddrLoc, offset, srcLoc)

def genInvCondJump(condLoc, label):
    '''
    Jump if condLoc is 0
    '''
    return "jmp {} if {} == 0\n".format(label, condLoc)

def genJump(label):
    return "jmp {}\n".format(label)

def genLabel(label):
    return "{}:\n".format(label)

def genAdd(resultLoc, src1Loc, src2Loc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(src1Loc.getType())
    if src1Loc.getType().isPointer():
        if not src2Loc.getType().isInteger():
            raise ValueError("Can only add ponters and integers, not pointers and other types")
        if resultLoc.getType() != src1Loc.getType():
            raise ValueError("Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
        return resultLoc, "{} = {} + {} * {}\n".format(resultLoc, src1Loc, src2Loc, src1Loc.getType().deref().getSize())
    else:
        if src1Loc.getType() != src2Loc.getType():
            raise ValueError("Incompatible source types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
        return resultLoc, "{} = {} + {}\n".format(resultLoc, src1Loc, src2Loc)

def genMulConst(resultLoc, srcLoc, m):
    resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise ValueError("Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    return resultLoc, "{} = {} * {}\n".format(resultLoc, srcLoc, m)
