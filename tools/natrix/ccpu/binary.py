from value import Value
from type import BoolType
import operator
import labelname
from .shift import genShift

def genBinary(op, resultLoc, src1Loc, src2Loc, labelProvider):
    if src1Loc.getType().isUnknown() or src2Loc.getType().isUnknown():
        raise ValueError("Unknown source type")
    if op == 'add':
        return genAdd(resultLoc, src1Loc, src2Loc)
    elif op == 'sub':
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "sub", "sbb", "({}) - ({})", operator.sub)
    elif op == 'band':
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "and", "and", "({}) & ({})", operator.and_)
    elif op == 'bor':
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "or", "or", "({}) | ({})", operator.or_)
    elif op == 'bxor':
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "xor", "xor", "({}) ^ ({})", operator.xor)
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
    else:
        raise RuntimeError("Unhandled binary op: {}".format(op))

def _genIntBinary(resultLoc, src1Loc, src2Loc, opLo, opHi, pyPattern, constLambda):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(src1Loc.getType())
    if resultLoc.getType() != src1Loc.getType():
        raise ValueError("Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
    if src1Loc.getType() != src2Loc.getType():
        raise ValueError("Incompatible source types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
    assert(resultLoc.getIndirLevel() == 1)
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    assert(l1 == 0 or l1 == 1)
    assert(l2 == 0 or l2 == 1)
    t = resultLoc.getType()
    rs = resultLoc.getSource()
    result = ""
    isWord = t.getSize() == 2
    if l1 == 0 and l2 == 0:
        # const + const
        c1 = src1Loc.getSource()
        c2 = src2Loc.getSource()
        if isinstance(c1, int) and isinstance(c2, int):
            cr = constLambda(c1, c2)
            if isWord:
                cr = cr & 0xffff
            else:
                cr = cr & 0xff
            return Value(t, 0, cr), result
        else:
            return Value(t, 0, pyPattern.format(c1, c2)), result
        result += 'st b\n'
        if isWord:
            result += '''
                inc pl
                st a
            '''
    elif l2 == 0:
        # var + const
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
        '''.format(src1Loc.getSource())
        if isWord:
            result += 'inc pl\n'
        c = src2Loc.getSource()
        if isinstance(c, int):
            l = _lo(c)
            if l == 0:
                result += 'mov a, 0\n'
            else:
                result += 'ldi a, {}\n'.format(l)
            result += '{} b, a\n'.format(opLo)
            if isWord:
                h = _hi(c)
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
            result += '''
                inc pl
                st a
            '''
    elif l1 == 0:
        # const + var
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld a
        '''.format(src2Loc.getSource())
        if isWord:
            result += 'inc pl\n'
        c = src1Loc.getSource()
        if isinstance(c, int):
            l = _lo(c)
            result += 'ldi b, {}\n'.format(l)
            result += '{} b, a\n'.format(opLo)
            if isWord:
                h = _hi(c)
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
            result += '''
                inc pl
                st a
            '''
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
            result += '''
                inc pl
                st a
            '''
    return resultLoc, result

def _genBoolBinary(resultLoc, src1Loc, src2Loc, op, pyPattern, constLambda):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(src1Loc.getType())
    if resultLoc.getType() != src1Loc.getType():
        raise ValueError("Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
    if src1Loc.getType() != src2Loc.getType():
        raise ValueError("Incompatible source types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
    if src1Loc.getType() != BoolType():
        raise ValueError("Bool type (u8) expected")
    assert(resultLoc.getIndirLevel() == 1)
    rs = resultLoc.getSource()
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    result = ''
    if l1 == 0 and l2 == 0:
        # const and const
        if isinstance(s1, int) and isinstance(s2, int):
            return Value(BoolType(), 0, int(constLambda(bool(s1), bool(s2)))), result
        else:
            return Value(BoolType(), 0, pyPattern.format(src1Loc, src2Loc)), result
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
                    return Value(BoolType(), 0, 1), ""
            elif op == 'and':
                if s2 == 0:
                    return Value(BoolType(), 0, 0), ""
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
        raise ValueError("Can only add ponters and integers, not pointers and other types")
    if src2Loc.getType().getSize() != 2:
        raise ValueError("Can only add a 16-bit integer to a pointer")
    memberSize = src1Loc.getType().deref().getSize()
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    t = resultLoc.getType()
    result = '; {} = {} + {} * {}\n'.format(resultLoc, src1Loc, src2Loc, memberSize)
    if memberSize == 1:
        # no multiplication, just add
        loc, code = _genIntBinary(resultLoc, src1Loc, src2Loc.withType(t), "add", "adc", "({}) + ({})", operator.add)
        return loc, result + code
    elif memberSize == 2:
        if src2Loc.getIndirLevel() == 0:
            if isinstance(s2, int):
                offset = s2 * 2
            else:
                offset = "({}) * 2".format(s2)
            loc, code = _genIntBinary(resultLoc, src1Loc, Value(t, 0, offset), "add", "adc", "({}) + ({})", operator.add)
            return loc, result + code
        else:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld b
                inc pl
                ld a
                shl a
                shl b
                adc a, 0
                xor a, b
                xor b, a
                xor a, b
                ldi pl, lo({1})
                ldi ph, hi({1})
                ld pl
                add a, pl
                ldi pl, lo({1} + 1)
                ld pl
                mov ph, a
                mov a, pl
                adc b, a
                mov a, ph
                ldi pl, lo({2})
                ldi ph, hi({2})
                st a
                inc pl
                st b
            '''.format(s2, s1, rs)
    else:
        raise RuntimeError("Other sizes than 1 and 2 are not supported for pointer indexing")
    return resultLoc, result

def genAdd(resultLoc, src1Loc, src2Loc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(src1Loc.getType())
    if resultLoc.getType() != src1Loc.getType():
        raise ValueError("Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
    if src1Loc.getType().isPointer():
        return _genAddPtr(resultLoc, src1Loc, src2Loc)
    else:
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "add", "adc", "({}) + ({})", operator.add)
