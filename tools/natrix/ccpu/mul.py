from value import Value
from exceptions import SemanticError
from .common import *

def _genMulVCByte(rs, v, c):
    result = '; {} = {} * {} (byte)\n'.format(rs, v, c)
    result += loadByte('a', v, 0)
    firstAdd = True
    inA = True
    for bit in range(8):
        curBit = bool(c & 1)
        c >>= 1
        if curBit:
            if firstAdd:
                if c == 0:
                    break
                result += 'mov b, a\n'
                firstAdd = False
            else:
                result += 'add b, a\n'
                if c == 0:
                    break
        result += '''
            shl a
        '''
    if not firstAdd:
        result += 'mov a, b\n'
    return result

def _genMulVCWord(rs, v, c):
    result = '; {} = {} * {} (word)\n'.format(rs.getSource(), v.getSource(), c)
    # TODO optimize
    result += copyW(v.getSource(), "__cc_r_a", v.isAligned(), True)
    result += storeConstW(c, "__cc_r_b", True)
    result += call("__cc_mul_word")
    result += copyW("__cc_r_r", rs.getSource(), True, rs.isAligned())
    return result

def _genMulVC(resultLoc, v, c):
    if c == 0:
        return Value(resultLoc.getPosition(), v.getType(), 0, 0, True), ""
    elif c == 1:
        return v, ""
    t = resultLoc.getType()
    if t.getSize() == 1:
        return Value.register(v.getPosition(), t), _genMulVCByte(resultLoc.getSource(), v, c)
    else:
        return resultLoc, _genMulVCWord(resultLoc, v, c)

def genMul(resultLoc, src1Loc, src2Loc):
    if src1Loc.getType() != src2Loc.getType():
        raise SemanticError(src1Loc.getPosition() - src2Loc.getPosition(), "multiplication types mismatch")
    t = src1Loc.getType()
    resultLoc = resultLoc.withType(t)
    assert(t.getSize() == 1 or t.getSize() == 2)
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    if l1 == 0 and l2 == 0:
        raise NotImplementedError("doing shit with pointers?")
    elif l1 == 0:
        s = src1Loc.getSource()
        if s.isNumber():
            return _genMulVC(resultLoc, src2Loc, int(s))
        else:
            raise NotImplementedError("doing shit with pointers?")
    elif l2 == 0:
        s = src2Loc.getSource()
        if s.isNumber():
            return _genMulVC(resultLoc, src1Loc, int(s))
        else:
            raise NotImplementedError("doing shit with pointers?")
    else:
        result = '; {} = {} * {}\n'.format(resultLoc, src1Loc, src2Loc)
        isWord = t.getSize() == 2
        if isWord:
            result += copyW(src1Loc.getSource(), "__cc_r_a", src1Loc.isAligned(), True)
            result += copyW(src2Loc.getSource(), "__cc_r_b", src2Loc.isAligned(), True)
            result += call("__cc_mul_word")
            result += copyW("__cc_r_r", resultLoc.getSource(), True, resultLoc.isAligned())
            return resultLoc, result
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
            result += call("__cc_mul_byte")
            result += '''
                ldi pl, lo(__cc_r_r)
                ldi ph, hi(__cc_r_r)
                ld a
            '''
            return Value.register(src1Loc.getPosition() - src2Loc.getPosition(), t), result
