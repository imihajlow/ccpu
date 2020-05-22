from value import Value
from exceptions import SemanticError
from .common import *

def _genDMCommon(resultLoc, src1Loc, src2Loc):
    if src1Loc.getType() != src2Loc.getType():
        raise SemanticError(src1Loc.getLocation() - src2Loc.getLocation(), "division types mismatch")
    t = src1Loc.getType()
    resultLoc = resultLoc.withType(t)
    assert(t.getSize() == 1 or t.getSize() == 2)
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    isWord = t.getSize() == 2
    result = '; {} = {} / {}\n'.format(resultLoc, src1Loc, src2Loc)
    if l1 == 0 and l2 == 0:
        raise NotImplementedError("doing shit with pointers?")
    elif l1 == 0:
        if isWord:
            result += storeConstW(src1Loc.getSource(), "__cc_r_a")
            result += copyW(src2Loc.getSource(), "__cc_r_b")
        else:
            result += storeConstB(src1Loc.getSource(), "__cc_r_a")
            result += copyB(src2Loc.getSource(), "__cc_r_b")
    elif l2 == 0:
        s = src2Loc.getSource()
        if isWord:
            result += copyW(src1Loc.getSource(), "__cc_r_a")
            result += storeConstW(src2Loc.getSource(), "__cc_r_b")
        else:
            result += copyB(src1Loc.getSource(), "__cc_r_a")
            result += storeConstB(src2Loc.getSource(), "__cc_r_b")
    else:
        if isWord:
            result += copyW(src1Loc.getSource(), "__cc_r_a")
            result += copyW(src2Loc.getSource(), "__cc_r_b")
        else:
            result += copyB(src1Loc.getSource(), "__cc_r_a")
            result += copyB(src2Loc.getSource(), "__cc_r_b")
    if isWord:
        if t.getSign():
            result += call("__cc_div_word")
        else:
            result += call("__cc_udiv_word")
    else:
        if t.getSign():
            result += call("__cc_div_byte")
        else:
            result += call("__cc_udiv_byte")
    return resultLoc, result

def genDiv(resultLoc, src1Loc, src2Loc):
    resultLoc, result = _genDMCommon(resultLoc, src1Loc, src2Loc)
    if resultLoc.getType().getSize() == 2:
        result += copyW("__cc_r_quotient", resultLoc.getSource())
    else:
        result += copyB("__cc_r_quotient", resultLoc.getSource())
    return resultLoc, result

def genMod(resultLoc, src1Loc, src2Loc):
    resultLoc, result = _genDMCommon(resultLoc, src1Loc, src2Loc)
    if resultLoc.getType().getSize() == 2:
        result += copyW("__cc_r_remainder", resultLoc.getSource())
    else:
        result += copyB("__cc_r_remainder", resultLoc.getSource())
    return resultLoc, result
