from value import Value
from type import BoolType
import operator
import labelname
from .common import *
from exceptions import SemanticError

def _genEqNeCmp(src1Loc, src2Loc):
    '''
    Compare two locations, store result in b (0 if equal, 1 if not)
    They shouldn't be both constants.
    '''
    t = src1Loc.getType()
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    size = t.getSize()
    result = ''
    if l1 == 0 or l2 == 0:
        # var == const
        if l1 == 0:
            s1, s2 = s2, s1
            src1Loc, src2Loc = src2Loc, src1Loc
        result = f'''
            ldi pl, lo({s1})
            ldi ph, hi({s1})
            ld b
        '''
        result += loadByte('a', src2Loc, 0)
        result += 'sub b, a\n'
        if size > 1:
            if src1Loc.isAligned():
                result += '''
                    inc pl
                    ld pl
                '''
            else:
                result += f'''
                    ldi pl, lo({s1} + 1)
                    ldi ph, hi({s1} + 1)
                    ld pl
                '''
            result += loadByte('a', src2Loc, 1)
            result += '''
                sub a, pl
                or b, a
            '''
        for offset in range(2, size):
            result += f'''
                ldi pl, lo({s1} + {offset})
                ldi ph, hi({s1} + {offset})
                ld pl
            '''
            result += loadByte('a', src2Loc, offset)
            result += '''
                sub a, pl
                or b, a
            '''
    else:
        result += f'''
            ldi pl, lo({s1})
            ldi ph, hi({s1})
            ld a
            ldi pl, lo({s2})
            ldi ph, hi({s2})
            ld b
            sub b, a
        '''
        for offset in range(1, size):
            result += f'''
                ldi pl, lo({s1} + {offset})
                ldi ph, hi({s1} + {offset})
                ld a
                ldi pl, lo({s2} + {offset})
                ldi ph, hi({s2} + {offset})
                ld pl
                sub a, pl
                or b, a
            '''
    return result

def genEq(resultLoc, src1Loc, src2Loc):
    resultLoc = resultLoc.withType(BoolType())
    assert(resultLoc.getIndirLevel() == 1)
    if src1Loc.getType() != src2Loc.getType():
        raise SemanticError(src1Loc.getPosition(), "Incompatible types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
    t = src1Loc.getType()
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    result = '; {} == {}\n'.format(src1Loc, src2Loc)
    if l1 == 0 and l2 == 0:
        # const == const
        pos = src1Loc.getPosition() - src2Loc.getPosition()
        if s1.isNumber() and s2.isNumber():
            return Value(pos, BoolType(), 0, int(int(s1) == int(s2)), True), result
        else:
            return Value(pos, BoolType(), 0, "int(({}) == ({}))".format(s1, s2), True), result
    else:
        result += _genEqNeCmp(src1Loc, src2Loc)
        result += '''
            dec b
            mov a, 0
            adc a, 0
            ldi pl, lo({0})
            ldi ph, hi({0})
            st a
        '''.format(rs)
        return resultLoc, result

def genNe(resultLoc, src1Loc, src2Loc):
    resultLoc = resultLoc.withType(BoolType())
    assert(resultLoc.getIndirLevel() == 1)
    if src1Loc.getType() != src2Loc.getType():
        raise SemanticError(src1Loc.getPosition(), "Incompatible types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
    t = src1Loc.getType()
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    isWord = t.getSize() == 2
    result = '; {} == {}\n'.format(src1Loc, src2Loc)
    if l1 == 0 and l2 == 0:
        # const == const
        pos = src1Loc.getPosition() - src2Loc.getPosition()
        if s1.isNumber() and s2.isNumber():
            return Value(pos, BoolType(), 0, int(int(s1) != int(s2)), True), result
        else:
            return Value(pos, BoolType(), 0, "int(({}) != ({}))".format(s1, s2), True), result
    else:
        result += _genEqNeCmp(src1Loc, src2Loc)
        result += '''
            dec b
            ldi a, 1
            sbb a, 0
            ldi pl, lo({0})
            ldi ph, hi({0})
            st a
        '''.format(rs)
        return resultLoc, result

def _genCmpSubFlags(src1Loc, src2Loc):
    # subtract the values so that flags C, S, and O are set accordingly
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    t = src1Loc.getType()
    size = t.getSize()
    result = ''
    for offset in range(size):
        result += loadByte('a', src1Loc, offset)
        result += loadByte('b', src2Loc, offset)
        if offset == 0:
            result += 'sub a, b\n'
        else:
            result += 'sbb a, b\n'
    return result

def _genCmpSub(src1Loc, src2Loc, op):
    # subtract the values so that flags C, S, and O are set accordingly and (b | pl) is zero if the result is zero
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    t = src1Loc.getType()
    assert(t.getSize() <= 2)
    isWord = t.getSize() == 2
    result = ''
    if l1 == 0:
        # const and var
        l = s1.lo()
        h = s1.hi()
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld a
            ldi b, {1}
        '''.format(s2, l)
        if isWord:
            result += '''
                sub b, a
                ldi pl, lo({1} + 1)
                ldi ph, hi({1} + 1)
                ld a
                ldi pl, {0}
                sbb pl, a
            '''.format(h, s2)
        else:
            result += 'sub b, a\n'
            if op == 'le' or op == 'gt':
                result += 'ldi pl, 0\n'
    elif l2 == 0:
        # var and const
        result += f'''
            ldi pl, lo({s1})
            ldi ph, hi({s1})
            ld b
        '''
        result += loadByte('a', src2Loc, 0)
        if isWord:
            result += f'''
                sub b, a
                ldi pl, lo({s1} + 1)
                ldi ph, hi({s1} + 1)
                ld pl
            '''
            result += loadByte('a', src2Loc, 1)
            result += '''
                sbb pl, a
            '''
        else:
            result += 'sub b, a\n'
            if op == 'le' or op == 'gt':
                result += 'ldi pl, 0\n'
    else:
        # var and var
        if isWord:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld b
                ldi pl, lo({1})
                ldi ph, hi({1})
                ld a
            '''.format(s1, s2)
            if src2Loc.isAligned():
                result += 'inc pl\n'
            else:
                result += '''
                    ldi pl, lo({0} + 1)
                    ldi ph, hi({0} + 1)
                '''.format(s2)
            result += '''
                sub b, a
                ld a
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                ld pl
                sbb pl, a
            '''.format(s1)
        else:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld b
                ldi pl, lo({1})
                ldi ph, hi({1})
                ld a
                sub b, a
            '''.format(s1, s2)
            if op == 'le' or op == 'gt':
                result += 'ldi pl, 0\n'
    return result

def _genCmpUnsigned(resultLoc, src1Loc, src2Loc, op, labelProvider):
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    t = src1Loc.getType()
    result = '; compare unsigned {} and {} ({})\n'.format(src1Loc, src2Loc, op)
    if l1 == 0 and l2 == 0:
        # const and const
        pos = src1Loc.getPosition() - src2Loc.getPosition()
        if s1.isNumber() and s2.isNumber():
            pyop = {"gt": operator.gt, "lt": operator.lt, "ge": operator.ge, "le": operator.le}[op]
            return Value(pos, BoolType(), 0, int(pyop(int(s1), int(s2))), True), result
        else:
            pyop = {"gt": ">", "lt": "<", "ge": ">=", "le": "<="}[op]
            return Value(pos, BoolType(), 0, "int(({}) {} ({}))".format(s1, pyop, s2), True), result
    if t.getSize() <= 2:
        if op == 'lt' or op == 'ge':
            result = _genCmpSubFlags(src1Loc, src2Loc)
        else:
            result += _genCmpSub(src1Loc, src2Loc, op)
        # C = carry flag
        # Z = (b | pl) == 0
        if op == 'lt':
            # 1 if C
            result += '''
                mov a, 0
                adc a, 0
            '''
        elif op == 'ge':
            # 1 if !C
            result += '''
                ldi a, 1
                sbb a, 0
            '''
        elif op == 'le':
            # 1 if C or !(b | pl)
            result += '''
                exp ph ; ph = C (0xff or 0x00)
                mov a, pl
                or a, b
                dec a ; C = Z
                exp a ; a = Z (0xff or 0x00)
                or a, ph ; a = C | Z (0xff or 0x00)
                ldi b, 1
                and a, b
            '''
        elif op == 'gt':
            # 1 if !(C or Z)
            result += '''
                exp ph ; ph = C (0xff or 0x00)
                mov a, pl
                or a, b
                dec a ; C = Z
                exp a ; a = Z (0xff or 0x00)
                or a, ph ; a = C | Z (0xff or 0x00)
                not a
                ldi b, 1
                and a, b
            '''
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            st a
        '''.format(rs)
        return resultLoc, result
    else:
        # large size and le or gt
        if op[0] == 'g':
            src1Loc, src2Loc = src2Loc, src1Loc
        result += _genCmpSubFlags(src1Loc, src2Loc)
        # C if s1 < s2
        if op[1] == 't':
            result += f'''
                mov a, 0
                adc a, 0
                ldi pl, lo({rs})
                ldi ph, hi({rs})
                st a
            '''
        else:
            labelEnd = labelProvider.allocLabel("cmp_end")
            result += f'''
                ldi b, 1
                ldi pl, lo({labelEnd})
                ldi ph, hi({labelEnd})
                jc
                dec b
            '''
            for offset in range(t.getSize()):
                result += loadByte('a', src1Loc, offset)
                result += loadByte('pl', src2Loc, offset)
                result += f'''
                    sub a, pl
                    ldi pl, lo({labelEnd})
                    ldi ph, hi({labelEnd})
                    jnz
                '''
                # invert b
            result += 'inc b\n'
            result += f'''
                {labelEnd}:
                ldi pl, lo({rs})
                ldi ph, hi({rs})
                st b
            '''
        return resultLoc, result


def _genCmpSignedByte(resultLoc, src1Loc, src2Loc, op, labelProvider):
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    result = '; compare signed bytes {} and {} ({})\n'.format(src1Loc, src2Loc, op)
    if l1 == 0:
        result += 'ldi b, lo({})\n'.format(s1)
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
        '''.format(s1)
    if l2 == 0:
        result += 'ldi a, lo({})\n'.format(s2)
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld a
        '''.format(s2)
    result += 'sub b, a\n'
    labelEnd = labelProvider.allocLabel("cmp_end")
    if op == 'lt' or op == 'gt':
        # if equal, return 0
        result += 'mov a, 0\n'
    else:
        # if equal, return 1
        result += 'ldi a, 1\n'
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jz
    '''.format(labelEnd)
    labelO = labelProvider.allocLabel("cmp_no")
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jno
    '''.format(labelO)
    # O is set
    result += 'shl b\n' # S -> C
    if op == 'lt' or op == 'le':
        # return !C
        if op == 'lt':
            result += 'ldi a, 1\n'
        # else a is already 1
        result += 'sbb a, 0'
    else:
        # return C
        if op == 'ge':
            result += 'mov a, 0\n'
        # else a is already 0
        result += 'adc a, 0\n'
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jmp
    '''.format(labelEnd)
    result += '''
    {0}:
        shl b
    '''.format(labelO)
    # O is clear
    if op == 'gt' or op == 'ge':
        # return !C
        if op == 'gt':
            result += 'ldi a, 1\n'
        # else a is already 1
        result += 'sbb a, 0\n'
    else:
        # return C
        if op == 'le':
            result += 'mov a, 0\n'
        # else a is already 0
        result += 'adc a, 0\n'
    result += '{}:\n'.format(labelEnd)
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        st a
    '''.format(rs)
    return resultLoc, result

def _genCmpSignedWord(resultLoc, src1Loc, src2Loc, op, labelProvider):
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    result = '; compare signed words {} and {} ({})\n'.format(src1Loc, src2Loc, op)
    if l1 == 0:
        result += 'ldi b, hi({})\n'.format(s1)
    else:
        result += '''
            ldi pl, lo({0} + 1)
            ldi ph, hi({0} + 1)
            ld b
        '''.format(s1)
    if l2 == 0:
        result += 'ldi a, hi({})\n'.format(s2)
    else:
        result += '''
            ldi pl, lo({0} + 1)
            ldi ph, hi({0} + 1)
            ld a
        '''.format(s2)
    result += 'sub b, a\n'
    labelEnd = labelProvider.allocLabel("cmp_end")
    labelCmpLo = labelProvider.allocLabel("cmp_lo")
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jz
    '''.format(labelCmpLo)
    # hi1 != hi2
    labelO = labelProvider.allocLabel("cmp_no")
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jno
    '''.format(labelO)
    # O is set
    result += 'shl b\n' # S -> C
    if op == 'lt' or op == 'le':
        # return !C
        result += 'ldi a, 1\n'
        result += 'sbb a, 0'
    else:
        # return C
        result += 'mov a, 0\n'
        result += 'adc a, 0\n'
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jmp
    '''.format(labelEnd)
    result += '''
    {0}:
        shl b
    '''.format(labelO)
    # O is clear
    if op == 'gt' or op == 'ge':
        # return !C
        result += 'ldi a, 1\n'
        result += 'sbb a, 0\n'
    else:
        # return C
        result += 'mov a, 0\n'
        result += 'adc a, 0\n'
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jmp
    '''.format(labelEnd)
    # hi1 == hi2 (= a)
    result += '{}:\n'.format(labelCmpLo)
    # if sign, compare low parts as unsigned
    if l1 == 0:
        result += 'ldi b, lo({})\n'.format(s1)
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
        '''.format(s1)
    if l2 == 0:
        result += 'ldi a, lo({})\n'.format(s2)
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld a
        '''.format(s2)
    result += 'sub b, a\n'
    if op == 'le' or op == 'ge':
        # if equal, return 1
        result += 'ldi a, 1\n'
    else:
        # if equal, return 0
        result += 'mov a, 0\n'
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jz
    '''.format(labelEnd)
    if op[0] == 'l':
        # less, return C
        if op == 'le':
            result += 'mov a, 0\n'
        # else a is already 0
        result += 'adc a, 0\n'
    else:
        # greater, return !C
        if op == 'gt':
            result += 'ldi a, 1\n'
        # else a is already 1
        result += 'sbb a, 0\n'
    result += '{}:\n'.format(labelEnd)
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        st a
    '''.format(rs)
    return resultLoc, result

def _genCmpSigned(resultLoc, src1Loc, src2Loc, op, labelProvider):
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    t = src1Loc.getType()
    if t.getSize() > 2:
        raise NotImplementedError("signed over s16 comparison isn't implemented")
    isWord = t.getSize() == 2
    if l1 == 0 and l2 == 0:
        # const and const
        raise NotImplementedError("signed const comparison")
    else:
        if not isWord:
            return _genCmpSignedByte(resultLoc, src1Loc, src2Loc, op, labelProvider)
        else:
            return _genCmpSignedWord(resultLoc, src1Loc, src2Loc, op, labelProvider)

def genCmp(resultLoc, src1Loc, src2Loc, op, labelProvider):
    assert(op in {"gt", "ge", "lt", "le"})
    resultLoc = resultLoc.withType(BoolType())
    assert(resultLoc.getIndirLevel() == 1)
    if src1Loc.getType() != src2Loc.getType():
        raise SemanticError(src1Loc.getPosition(), "Incompatible types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
    t = src1Loc.getType()
    if t.getSign():
        return _genCmpSigned(resultLoc, src1Loc, src2Loc, op, labelProvider)
    else:
        return _genCmpUnsigned(resultLoc, src1Loc, src2Loc, op, labelProvider)
