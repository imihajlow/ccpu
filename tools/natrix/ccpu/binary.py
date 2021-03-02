from value import Value
from type import BoolType
import operator
import labelname
from .shift import genShift, genSHLVarByConst
from .common import *
from .compare import *
from .mul import *
from .div import *
from exceptions import SemanticError, NatrixNotImplementedError

def genBinary(op, resultLoc, src1Loc, src2Loc, labelProvider):
    if resultLoc.getIndirLevel() == 0:
        raise RuntimeError("Result is a constant") # should never happen, assignments are handled separately
    if src1Loc.getType().isUnknown() or src2Loc.getType().isUnknown():
        raise RuntimeError("Unknown source type")
    if op == 'add':
        return genAdd(resultLoc, src1Loc, src2Loc)
    elif op == 'sub':
        return genSub(resultLoc, src1Loc, src2Loc)
    elif op == 'band':
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "and", "and", "({}) & ({})", operator.and_, True)
    elif op == 'bor':
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "or", "or", "({}) | ({})", operator.or_, True)
    elif op == 'bxor':
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "xor", "xor", "({}) ^ ({})", operator.xor, True)
    elif op == 'lor':
        return _genBoolBinary(resultLoc, src1Loc, src2Loc, "or", "bool({}) or bool({})", lambda a,b: a or b)
    elif op == 'land':
        return _genBoolBinary(resultLoc, src1Loc, src2Loc, "and", "bool({}) and bool({})", lambda a,b: a and b)
    elif op == 'eq':
        return genEq(resultLoc, src1Loc, src2Loc)
    elif op == 'ne':
        return genNe(resultLoc, src1Loc, src2Loc)
    elif op in {'gt', 'ge', 'lt', 'le'}:
        return genCmp(resultLoc, src1Loc, src2Loc, op, labelProvider)
    elif op in {'shl', 'shr'}:
        return genShift(resultLoc, src1Loc, src2Loc, op, labelProvider)
    elif op == 'mul':
        return genMul(resultLoc, src1Loc, src2Loc)
    elif op == 'div':
        return genDiv(resultLoc, src1Loc, src2Loc)
    elif op == 'mod':
        return genMod(resultLoc, src1Loc, src2Loc)
    else:
        raise RuntimeError("Unhandled binary op: {}".format(op))

def _genIntBinary(resultLoc, src1Loc, src2Loc, opLo, opHi, pyPattern, constLambda, carryIrrelevant):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(src1Loc.getType())
    if resultLoc.getType() != src1Loc.getType():
        raise SemanticError(resultLoc.getLocation(),
            "Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
    if src1Loc.getType() != src2Loc.getType():
        raise SemanticError(resultLoc.getLocation(),
            "Incompatible source types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
    assert(resultLoc.getIndirLevel() == 1)
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    assert(l1 == 0 or l1 == 1)
    assert(l2 == 0 or l2 == 1)
    if l1 == 0 and l2 == 0:
        raise RuntimeError("Case unhandled by ConstTransformer")
    t = resultLoc.getType()
    rs = resultLoc.getSource()
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    result = "; {} = {} {}, {}\n".format(resultLoc, opLo, src1Loc, src2Loc)
    if t.getSize() <= 2:
        isWord = t.getSize() == 2
        if l2 == 0:
            # var + const
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld b
            '''.format(src1Loc.getSource())
            if isWord:
                if src1Loc.isAligned():
                    result += 'inc pl\n'
                else:
                    result += '''
                        ldi pl, lo({0} + 1)
                        ldi ph, hi({0} + 1)
                    '''.format(src1Loc.getSource())
            c = src2Loc.getSource()
            if isinstance(c, int):
                l = lo(c)
                if l == 0:
                    result += 'mov a, 0\n'
                else:
                    result += 'ldi a, {}\n'.format(l)
                result += '{} b, a\n'.format(opLo)
                if isWord:
                    h = hi(c)
                    result += '''
                        ld a
                        ldi pl, {}
                        {} a, pl
                    '''.format(h, opHi)
            else:
                result += '''
                    ldi a, lo({})
                    {} b, a
                '''.format(c, opLo)
                if isWord:
                    result += '''
                        ld a
                        ldi pl, hi({})
                        {} a, pl
                    '''.format(c, opHi)
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st b
            '''.format(rs)
            if isWord:
                if resultLoc.isAligned():
                    result += '''
                        inc pl
                        st a
                    '''
                else:
                    result += '''
                        ldi pl, lo({0} + 1)
                        ldi ph, hi({0} + 1)
                        st a
                    '''.format(rs)
        elif l1 == 0:
            # const + var
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld a
            '''.format(src2Loc.getSource())
            if isWord:
                if src2Loc.isAligned():
                    result += 'inc pl\n'
                else:
                    result += '''
                        ldi pl, lo({0} + 1)
                        ldi ph, hi({0} + 1)
                    '''.format(src2Loc.getSource())
            c = src1Loc.getSource()
            if isinstance(c, int):
                l = lo(c)
                result += 'ldi b, {}\n'.format(l)
                result += '{} b, a\n'.format(opLo)
                if isWord:
                    h = hi(c)
                    result += 'ld pl\n'
                    if h == 0:
                        result += 'mov a, 0\n'
                    else:
                        result += 'ldi a, {}\n'.format(h)
                    result += '{} a, pl'.format(opHi)
            else:
                result += '''
                    ldi b, lo({})
                    {} b, a
                '''.format(c, opLo)
                if isWord:
                    result += '''
                        ld pl
                        ldi a, hi({})
                        {} a, pl
                    '''.format(c, opHi)
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st b
            '''.format(rs)
            if isWord:
                if resultLoc.isAligned():
                    result += '''
                        inc pl
                        st a
                    '''
                else:
                    result += '''
                        ldi pl, lo({0} + 1)
                        ldi ph, hi({0} + 1)
                        st a
                    '''.format(rs)
        else:
            # var + var
            s1 = src1Loc.getSource()
            s2 = src2Loc.getSource()
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld b
                ldi pl, lo({1})
                ldi ph, hi({1})
                ld a
                {2} b, a
            '''.format(s1, s2, opLo)
            if isWord:
                result += '''
                    ldi pl, lo({0} + 1)
                    ldi ph, hi({0} + 1)
                    ld a
                    ldi pl, lo({1} + 1)
                    ldi ph, hi({1} + 1)
                    ld pl
                    {2} a, pl
                '''.format(s1, s2, opHi)
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st b
            '''.format(rs)
            if isWord:
                if resultLoc.isAligned():
                    result += '''
                        inc pl
                        st a
                    '''
                else:
                    result += '''
                        ldi pl, lo({0} + 1)
                        ldi ph, hi({0} + 1)
                        st a
                    '''.format(rs)
    else:
        # size > 2
        # This produces less size-efficient code than above, that's why it's not a general case.
        for offset in range(0, t.getSize(), 2):
            rest = t.getSize() - offset
            result += loadByte('a', src1Loc, offset)
            if rest > 1:
                if l1 == 0:
                    result += loadByte('b', src1Loc, offset + 1)
                else:
                    if (offset == 0 or carryIrrelevant) and src1Loc.isAligned():
                        # can trash flags if it's the first pair of bytes or if op is like and, or, xor
                        result += '''
                            inc pl
                            ld b
                        '''
                    else:
                        # must preserve flags
                        if src1Loc.isAligned():
                            result += f'''
                                ldi pl, lo({s1} + {offset + 1})
                                ld b
                            '''
                        else:
                            result += loadByte('b', src1Loc, offset + 1)
            result += loadByte('pl', src2Loc, offset)
            if offset == 0:
                result += f'{opLo} a, pl\n'
            else:
                result += f'{opHi} a, pl\n'
            result += f'''
                ldi pl, lo({rs} + {offset})
                ldi ph, hi({rs} + {offset})
                st a
            '''
            if rest > 1:
                result += loadByte('a', src2Loc, offset + 1)
                result += f'''
                    {opHi} b, a
                    ldi pl, lo({rs} + {offset + 1})
                    ldi ph, hi({rs} + {offset + 1})
                    st b
                '''
    return resultLoc, result

def _genBoolBinary(resultLoc, src1Loc, src2Loc, op, pyPattern, constLambda):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(src1Loc.getType())
    if resultLoc.getType() != src1Loc.getType():
        raise SemanticError(resultLoc.getLocation(),
            "Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
    if src1Loc.getType() != src2Loc.getType():
        raise SemanticError(src1Loc.getLocation() - src2Loc.getLocation(),
            "Incompatible source types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
    if src1Loc.getType() != BoolType():
        raise SemanticError(src1Loc.getLocation(),
            "Bool type (u8) expected")
    assert(resultLoc.getIndirLevel() == 1)
    rs = resultLoc.getSource()
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    result = '; {} = bool {} {}, {}\n'.format(resultLoc, op, src1Loc, src2Loc)
    loc = src1Loc.getLocation() - src2Loc.getLocation()
    if l1 == 0 and l2 == 0:
        # const and const
        if isinstance(s1, int) and isinstance(s2, int):
            return Value(loc, BoolType(), 0, int(constLambda(bool(s1), bool(s2))), True), result
        else:
            return Value(loc, BoolType(), 0, pyPattern.format(src1Loc, src2Loc), True), result
    elif l1 == 0 or l2 == 0:
        # var and const
        if l1 == 0:
            s1, s2 = s2, s1
            src1Loc, src2Loc = src2Loc, src1Loc
        if isinstance(s2, int):
            if op == 'or':
                if s2 == 0:
                    return src1Loc, ""
                else:
                    return Value(loc, BoolType(), 0, 1, True), ""
            elif op == 'and':
                if s2 == 0:
                    return Value(loc, BoolType(), 0, 0, True), ""
                else:
                    return src1Loc, result
            else:
                raise RuntimeError("Unhandled binary boolean op: {}".format(op))
        else:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld a
                dec a
                ldi a, 1
                sbb a, 0
                ldi b, int(bool({1}))
                {2} a, b
            '''.format(s1, s2, op)
    else:
        # var and var
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld a
            dec a
            ldi a, 1
            sbb a, 0
            mov b, a
            ldi pl, lo({1})
            ldi ph, hi({1})
            ld a
            dec a
            ldi a, 1
            sbb a, 0
            {2} a, b
        '''.format(s1, s2, op)
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        st a
    '''.format(rs)
    return resultLoc, result

def _genAddPtr(resultLoc, src1Loc, src2Loc):
    if not src2Loc.getType().isInteger():
        raise SemanticError(src2Loc.getLocation(),
            "Can only add ponters and integers, not pointers and other types")
    memberSize = src1Loc.getType().deref().getSize()
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    t = resultLoc.getType()
    if src2Loc.getType().getSize() > 2:
        raise NatrixNotImplementedError(src2Loc.getLocation(), "Can only add integers up to 16 bit to pointers")
    result = '; {} = {} + {} * {}\n'.format(resultLoc, src1Loc, src2Loc, memberSize)
    isWord = src2Loc.getType().getSize() == 2
    if memberSize > 2:
        if src2Loc.getIndirLevel() == 0:
            loc = src1Loc.getLocation() - src2Loc.getLocation()
            if isinstance(s2, int):
                offset = s2 * memberSize
            else:
                offset = "({}) * {}".format(s2, memberSize)
            loc, code = _genIntBinary(resultLoc, src1Loc, Value(loc, t, 0, offset, True), "add", "adc", "({}) + ({})", operator.add, False)
            return loc, result + code
        elif src1Loc == resultLoc:
            raise NatrixNotImplementedError(src2Loc.getLocation(), "Incrementing a pointer to a large type")
        elif not isPowerOfTwo(memberSize):
            raise NatrixNotImplementedError(src2Loc.getLocation(), f"sizeof({src1Loc.getType().deref()}) = {memberSize} is not a power of two")
        else:
            shift = log(memberSize)
            shiftedLoc, shiftCode = genSHLVarByConst(resultLoc, src2Loc, shift)
            loc, additionCode = _genIntBinary(resultLoc, shiftedLoc, src1Loc, "add", "adc", "({}) + ({})", operator.add, False)
            return loc, result + shiftCode + additionCode
    elif isWord:
        if memberSize == 1:
            # no multiplication, just add
            loc, code = _genIntBinary(resultLoc, src1Loc, src2Loc.withType(t), "add", "adc", "({}) + ({})", operator.add, False)
            return loc, result + code
        elif memberSize == 2:
            if src2Loc.getIndirLevel() == 0:
                loc = src1Loc.getLocation() - src2Loc.getLocation()
                if isinstance(s2, int):
                    offset = s2 * 2
                else:
                    offset = "({}) * 2".format(s2)
                loc, code = _genIntBinary(resultLoc, src1Loc, Value(loc, t, 0, offset, True), "add", "adc", "({}) + ({})", operator.add, False)
                return loc, result + code
            else:
                result += '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld b
                    inc pl
                '''.format(s2)
                if not src2Loc.isAligned():
                    result += '''
                        mov a, 0
                        adc ph, a
                    '''
                result += '''
                    ld a
                    shl a
                    shl b
                    adc a, 0
                '''
                if src1Loc.getIndirLevel() == 1:
                    result += '''
                        xor a, b
                        xor b, a
                        xor a, b
                        ldi pl, lo({0})
                        ldi ph, hi({0})
                        ld pl
                        add a, pl
                        ldi ph, hi({0} + 1)
                        ldi pl, lo({0} + 1)
                        ld pl
                        mov ph, a
                        mov a, pl
                        adc b, a
                        mov a, ph
                    '''.format(s1)
                    result += '''
                        ldi pl, lo({0})
                        ldi ph, hi({0})
                        st a
                        inc pl
                    '''.format(rs)
                    if not resultLoc.isAligned():
                        result += '''
                            mov a, 0
                            adc ph, a
                        '''
                    result += '''
                        st b
                    '''
                else:
                    # a:b - index
                    result += '''
                        mov ph, a
                        ldi a, lo({0})
                        add b, a
                        ldi a, hi({0})
                        adc a, ph
                    '''.format(s1)
                    result += '''
                        ldi pl, lo({0})
                        ldi ph, hi({0})
                        st b
                    '''.format(rs)
                    if resultLoc.isAligned():
                        result += '''
                            inc pl
                            st a
                        '''
                    else:
                        result += '''
                            ldi pl, lo({0} + 1)
                            ldi ph, hi({0} + 1)
                            st a
                        '''.format(rs)
    else: # not isWord
        if src2Loc.getIndirLevel() == 0:
            loc = src1Loc.getLocation() - src2Loc.getLocation()
            if src2Loc.getType().getSign():
                s2 = signExpandByte(s2)
            if isinstance(s2, int):
                offset = s2 * memberSize
            else:
                offset = "({}) * {}".format(s2, memberSize)
            loc, code = _genIntBinary(resultLoc, src1Loc, Value(loc, t, 0, offset, True), "add", "adc", "({}) + ({})", operator.add, False)
            return loc, result + code
        if src2Loc.getType().getSign():
            raise SemanticError(src2Loc.getLocation(), "pointer arithmetic with s8 is not implemented")
        # s2.indirLevel == 1
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
        '''.format(src2Loc.getSource())
        if memberSize == 1:
            if src1Loc.getIndirLevel() == 0:
                result += '''
                    ldi a, lo({0})
                    add b, a
                    ldi a, hi({0})
                    adc a, 0
                '''.format(src1Loc.getSource())
            else:
                result += '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld a
                    add b, a
                    ldi pl, lo({0} + 1)
                    ldi ph, hi({0} + 1)
                    ld a
                    adc a, 0
                '''.format(src1Loc.getSource())
        elif memberSize == 2:
            if src1Loc.getIndirLevel() == 0:
                result += '''
                    mov a, 0
                    mov pl, a
                    shl b
                    adc pl, a
                    ldi a, lo({0})
                    add b, a
                    ldi a, hi({0})
                    adc a, pl
                '''.format(src1Loc.getSource())
            else:
                result += '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld pl ; pl = p_l
                    mov a, 0
                    shl b ; b = i_l
                    adc a, 0
                    mov ph, a ; ph = i_h
                    mov a, pl
                    add b, a ; b = p_l + i_l = r_l
                    mov a, 0
                    adc a, 0 ; a = c
                    add a, ph ; a = i_h + c
                    ldi pl, lo({0} + 1)
                    ldi ph, hi({0} + 1)
                    ld pl
                    add a, pl ; a = i_h + c + p_h = r_h
                '''.format(src1Loc.getSource())
        if resultLoc.isAligned():
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st b
                inc pl
                st a
            '''.format(resultLoc.getSource())
        else:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st b
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                st a
            '''.format(resultLoc.getSource())
    return resultLoc, result

def _genSubPtr(resultLoc, src1Loc, src2Loc):
    if not src2Loc.getType().isInteger():
        raise SemanticError(src2Loc.getLocation(),
            "Can only subtract ponters and integers, not pointers and other types")
    memberSize = src1Loc.getType().deref().getSize()
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    t = resultLoc.getType()
    result = '; {} = {} - {} * {}\n'.format(resultLoc, src1Loc, src2Loc, memberSize)
    isWord = src2Loc.getType().getSize() == 2
    if memberSize > 2:
        if src2Loc.getIndirLevel() == 0:
            loc = src1Loc.getLocation() - src2Loc.getLocation()
            if isinstance(s2, int):
                offset = s2 * memberSize
            else:
                offset = "({}) * {}".format(s2, memberSize)
            loc, code = _genIntBinary(resultLoc, src1Loc, Value(loc, t, 0, offset, True), "sub", "sbb", "({}) - ({})", operator.sub, False)
            return loc, result + code
        elif src1Loc == resultLoc:
            raise NatrixNotImplementedError(src2Loc.getLocation(), "Decrementing a pointer to a large type")
        elif not isPowerOfTwo(memberSize):
            raise NatrixNotImplementedError(src2Loc.getLocation(), f"sizeof({src1Loc.getType().deref()}) = {memberSize} is not a power of two")
        else:
            shift = log(memberSize)
            shiftedLoc, shiftCode = genSHLVarByConst(resultLoc, src2Loc, shift)
            loc, subtractionCode = _genIntBinary(resultLoc, src1Loc, shiftedLoc, "sub", "sbb", "({}) - ({})", operator.sub, False)
            return loc, result + shiftCode + subtractionCode
    elif isWord:
        if memberSize == 1:
            # no multiplication, just subtract
            loc, code = _genIntBinary(resultLoc, src1Loc, src2Loc.withType(t), "sub", "sbb", "({}) - ({})", operator.sub, False)
            return loc, result + code
        elif memberSize == 2:
            if src2Loc.getIndirLevel() == 0:
                loc = src1Loc.getLocation() - src2Loc.getLocation()
                if isinstance(s2, int):
                    offset = s2 * 2
                else:
                    offset = "({}) * 2".format(s2)
                loc, code = _genIntBinary(resultLoc, src1Loc, Value(loc, t, 0, offset, True), "sub", "sbb", "({}) - ({})", operator.sub, False)
                return loc, result + code
            else:
                result += '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld b
                '''.format(s2)
                if src2Loc.isAligned():
                    result += 'inc pl\n'
                else:
                    result += '''
                        ldi pl, lo({0} + 1)
                        ldi ph, hi({0} + 1)
                    '''.format(s2)
                result += '''
                    ld a
                    shl a
                    shl b
                    adc a, 0
                '''
                if src1Loc.getIndirLevel() == 1:
                    result += '''
                        xor a, b
                        xor b, a
                        xor a, b
                        ldi pl, lo({0})
                        ldi ph, hi({0})
                        ld pl
                        sub pl, a
                        mov a, pl
                        ldi ph, hi({0} + 1)
                        ldi pl, lo({0} + 1)
                        ld pl
                        mov ph, a
                        mov a, pl
                        sbb a, b
                        mov b, a
                        mov a, ph
                    '''.format(s1)
                else:
                    # a:b - index
                    result += '''
                        mov ph, a
                        ldi a, lo({0})
                        sub b, a
                        ldi a, hi({0})
                        sbb ph, a
                        mov a, ph
                    '''.format(s1)
                result += '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    st a
                    inc pl
                '''.format(rs)
                if not resultLoc.isAligned():
                    result += '''
                        mov a, 0
                        adc ph, a
                    '''
                result += 'st b\n'
    else: # not isWord
        if src2Loc.getIndirLevel() == 0:
            loc = src1Loc.getLocation() - src2Loc.getLocation()
            if src2Loc.getType().getSign():
                s2 = signExpandByte(s2)
            if isinstance(s2, int):
                offset = s2 * memberSize
            else:
                offset = "({}) * {}".format(s2, memberSize)
            loc, code = _genIntBinary(resultLoc, src1Loc, Value(loc, t, 0, offset, True), "sub", "sbb", "({}) - ({})", operator.sub, False)
            return loc, result + code
        if src2Loc.getType().getSign():
            raise SemanticError(src2Loc.getLocation(), "pointer arithmetic with s8 is not implemented")
        # s2.indirLevel == 1
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
        '''.format(src2Loc.getSource())
        if memberSize == 1:
            if src1Loc.getIndirLevel() == 0:
                result += '''
                    ldi a, lo({0})
                    sub a, b
                    mov b, a
                    ldi a, hi({0})
                    sbb a, 0
                '''.format(src1Loc.getSource())
            else:
                result += '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld a
                    sub a, b
                    mov b, a
                    ldi pl, lo({0} + 1)
                    ldi ph, hi({0} + 1)
                    ld a
                    sbb a, 0
                '''.format(src1Loc.getSource())
        elif memberSize == 2:
            if src1Loc.getIndirLevel() == 0:
                result += '''
                    mov a, 0
                    mov pl, a
                    shl b
                    adc pl, a
                    ldi a, lo({0})
                    sub a, b
                    mov b, a
                    ldi a, hi({0})
                    sbb a, pl
                '''.format(src1Loc.getSource())
            else:
                result += '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld pl ; pl = p_l
                    mov a, 0
                    shl b ; b = i_l
                    adc a, 0
                    mov ph, a ; ph = i_h
                    mov a, pl ; a = p_l
                    sub a, b ; a = r_l
                    mov b, a ; b = r_l
                    mov a, 0
                    adc a, 0 ; a = c
                    add a, ph ; a = i_h + c
                    ldi pl, lo({0} + 1)
                    ldi ph, hi({0} + 1)
                    ld pl ; pl = p_h
                    sub pl, a
                    mov a, pl ; a = p_h - (i_h + c) = r_h
                '''.format(src1Loc.getSource())
        else:
            raise RuntimeError("Other sizes than 1 and 2 are not supported for pointer indexing")
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            st b
        '''.format(resultLoc.getSource())
        if resultLoc.isAligned():
            result += 'inc pl\n'
        else:
            result += '''
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
            '''.format(resultLoc.getSource())
        result += 'st a\n'
    return resultLoc, result

def genAddPointerOffset(resultLoc, src, offset):
    return _genIntBinary(resultLoc, src, Value(resultLoc.getLocation(), src.getType(), 0, offset, True), "add", "adc", "({}) + ({})", operator.add, False)

def genAdd(resultLoc, src1Loc, src2Loc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(src1Loc.getType())
    if resultLoc.getType() != src1Loc.getType():
        raise SemanticError(resultLoc.getLocation(),
            "Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
    if src1Loc.getType().isPointer():
        return _genAddPtr(resultLoc, src1Loc, src2Loc)
    else:
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "add", "adc", "({}) + ({})", operator.add, False)

def genSub(resultLoc, src1Loc, src2Loc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(src1Loc.getType())
    if resultLoc.getType() != src1Loc.getType():
        raise SemanticError(resultLoc.getLocation(),
            "Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
    if src1Loc.getType().isPointer():
        return _genSubPtr(resultLoc, src1Loc, src2Loc)
    else:
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "sub", "sbb", "({}) - ({})", operator.sub, False)
