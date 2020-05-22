from value import Value
from exceptions import SemanticError

def _copyW(f, t):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        ld b
        inc pl
        ld a
        ldi pl, lo({1})
        ldi ph, hi({1})
        st b
        inc pl
        st a
    '''.format(f, t)

def _copyB(f, t):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        ld b
        ldi pl, lo({1})
        ldi ph, hi({1})
        st b
    '''.format(f, t)

def _call(f):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jmp
    '''.format(f)

def _genMulVCByte(rs, v, c):
    result = '; {} = {} * {} (byte)\n'.format(rs, v, c)
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        ld b
    '''.format(v)
    firstAdd = True
    for bit in range(8):
        if bool(c & 1):
            if firstAdd:
                result += 'mov a, b'
                firstAdd = False
            else:
                result += 'add a, b'
        c >>= 1
        if c == 0:
            break
        result += '''
            shl b
        '''
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        st a
    '''.format(rs)
    return result

def _genMulVCWord(rs, v, c):
    result = '; {} = {} * {} (word)\n'.format(rs, v, c)
    # TODO optimize
    result += _copyW(v, "__cc_r_a")
    result += '''
        ldi b, lo({0})
        ldi a, hi({0})
        ldi pl, lo(__cc_r_b)
        ldi ph, hi(__cc_r_b)
        st b
        inc pl
        st a
    '''.format(c)
    result += _call("__cc_mul_word")
    result += _copyW("__cc_r_r", rs)
    return result

def _genMulVC(resultLoc, v, c):
    if c == 0:
        return Value(resultLoc.getLocation(), v.getType(), 0, 0), ""
    elif c == 1:
        return v, ""
    t = resultLoc.getType()
    if t.getSize() == 1:
        return resultLoc, _genMulVCByte(resultLoc.getSource(), v.getSource(), c)
    else:
        return resultLoc, _genMulVCWord(resultLoc.getSource(), v.getSource(), c)

def genMul(resultLoc, src1Loc, src2Loc):
    if src1Loc.getType() != src2Loc.getType():
        raise SemanticError(src1Loc.getLocation() - src2Loc.getLocation(), "multiplication types mismatch")
    t = src1Loc.getType()
    resultLoc = resultLoc.withType(t)
    assert(t.getSize() == 1 or t.getSize() == 2)
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    if l1 == 0 and l2 == 0:
        raise NotImplementedError("doing shit with pointers?")
    elif l1 == 0:
        s = src1Loc.getSource()
        if isinstance(s, int):
            return _genMulVC(resultLoc, src2Loc, s)
        else:
            raise NotImplementedError("doing shit with pointers?")
    elif l2 == 0:
        s = src2Loc.getSource()
        if isinstance(s, int):
            return _genMulVC(resultLoc, src1Loc, s)
        else:
            raise NotImplementedError("doing shit with pointers?")
    else:
        result = '; {} = {} * {}\n'.format(resultLoc, src1Loc, src2Loc)
        isWord = t.getSize() == 2
        if isWord:
            result += _copyW(src1Loc.getSource(), "__cc_r_a")
            result += _copyW(src2Loc.getSource(), "__cc_r_b")
            result += _call("__cc_mul_word")
            result += _copyW("__cc_r_r", resultLoc.getSource())
        else:
            result += _copyB(src1Loc.getSource(), "__cc_r_a")
            result += _copyB(src2Loc.getSource(), "__cc_r_b")
            result += _call("__cc_mul_byte")
            result += _copyB("__cc_r_r", resultLoc.getSource())
        return resultLoc, result
