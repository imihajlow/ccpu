from value import Value
from exceptions import SemanticError
from .common import *

def _genDMCommon(resultLoc, src1Loc, src2Loc):
    if src1Loc.getType() != src2Loc.getType():
        raise SemanticError(src1Loc.getPosition() - src2Loc.getPosition(), "division types mismatch")
    t = src1Loc.getType()
    resultLoc = resultLoc.withType(t)
    assert(t.getSize() == 1 or t.getSize() == 2)
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    isWord = t.getSize() == 2
    result = '; {} = {} / {}\n'.format(resultLoc, src1Loc, src2Loc)
    if l1 == 0 and l2 == 0:
        raise NotImplementedError("doing shit with pointers?")
    if isWord:
        if l1 == 0:
            result += storeConstW(src1Loc.getSource(), "__cc_r_a", False)
            result += copyW(src2Loc.getSource(), "__cc_r_b", False, True)
        elif l2 == 0:
            s = src2Loc.getSource()
            result += copyW(src1Loc.getSource(), "__cc_r_a", False, True)
            result += storeConstW(src2Loc.getSource(), "__cc_r_b", False)
        else:
            result += copyW(src1Loc.getSource(), "__cc_r_a", False, True)
            result += copyW(src2Loc.getSource(), "__cc_r_b", False, True)
    else:
        result += loadByte('b', src1Loc, 0)
        result += loadByte('a', src2Loc, 0)
        result += '''
            ldi pl, lo(__cc_r_a)
            ldi ph, hi(__cc_r_a)
            st b
            ldi pl, lo(__cc_r_b)
            st a
        '''
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
        result += copyW("__cc_r_quotient", resultLoc.getSource(), True, False)
        return resultLoc, result
    else:
        result += '''
            ldi pl, lo(__cc_r_quotient)
            ldi ph, hi(__cc_r_quotient)
            ld a
        '''
        return Value.register(src1Loc.getPosition() - src2Loc.getPosition(), resultLoc.getType()), result

def genMod(resultLoc, src1Loc, src2Loc):
    resultLoc, result = _genDMCommon(resultLoc, src1Loc, src2Loc)
    if resultLoc.getType().getSize() == 2:
        result += copyW("__cc_r_remainder", resultLoc.getSource(), True, False)
        return resultLoc, result
    else:
        result += '''
            ldi pl, lo(__cc_r_remainder)
            ldi ph, hi(__cc_r_remainder)
            ld a
        '''
        return Value.register(src1Loc.getPosition() - src2Loc.getPosition(), resultLoc.getType()), result
