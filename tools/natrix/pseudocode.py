from value import Value

def genFunctionPrologue(fn):
    return genLabel(fn)

def genReturn(fn):
    return "return from {}\n".format(fn)

def genCall(fn):
    return "call {}\n".format(fn)

def genPushLocals(fn):
    return "push locals of {}\n".format(fn)

def genPopLocals(fn):
    return "pop locals of {}\n".format(fn)

def genMove(resultLoc, srcLoc, avoidCopy):
    if srcLoc.getType().isUnknown():
        raise ValueError("Unknown source type")
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise ValueError("Incompatible types to assign: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    if srcLoc == resultLoc:
        return resultLoc, ""
    else:
        if avoidCopy:
            return srcLoc, ""
        else:
            return resultLoc, "{} = {}\n".format(resultLoc, srcLoc)

def genCast(resultLoc, t, srcLoc):
    resultLoc = resultLoc.withType(t)
    return resultLoc, "{} = cast<{}>({})\n".format(resultLoc, t, srcLoc)

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
    if op == 'subscript':
        return genSubscript(resultLoc, src1Loc, src2Loc)
    elif op == 'add':
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
        return "*{} = {}\n".format(resultAddrLoc, srcLoc)
    else:
        return "*({} + {}) = {}\n".format(resultAddrLoc, offset, srcLoc)

def genInvCondJump(condLoc, label):
    '''
    Jump if condLoc is 0
    '''
    return "jmp {} if {} == 0\n".format(label, condLoc)

def genJump(label):
    return "jmp {}\n".format(label)

def genLabel(label):
    return "{}:\n".format(label)

def genSubscript(resultLoc, baseLoc, indexLoc):
    if not indexLoc.getType().isInteger():
        raise ValueError("Index must be an integer, got {}".format(indexLoc.getType()))
    if not baseLoc.getType().isPointer():
        raise ValueError("Subscript base must be a pointer, got {}".format(baseLoc.getType()))
    resultType = baseLoc.getType().deref()
    if baseLoc.getIndirLevel() == 0:
        if indexLoc.getIndirLevel() == 0:
            return Value(resultType, 1, "{} + {} * {}".format(baseLoc.getSource(), indexLoc.getSource(), resultType.getSize())), ""
        else:
            return resultLoc.removeUnknown(resultType), "{} = deref({} + [{}] * {})\n".format(resultLoc, baseLoc, indexLoc, resultType.getSize())
    else:
        if indexLoc.getIndirLevel() == 0:
            return resultLoc.removeUnknown(resultType), "{} = deref([{}] + {} * {}\n".format(resultLoc, baseLoc, indexLoc, resultType.getSize())
        else:
            return resultLoc.removeUnknown(resultType), "{} = deref([{}] + [{}] * {}\n".format(resultLoc, baseLoc, indexLoc, resultType.getSize())

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
