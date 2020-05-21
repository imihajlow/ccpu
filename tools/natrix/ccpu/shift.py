from value import Value
from type import BoolType
import operator
import labelname
from exceptions import SemanticError

def genShift(resultLoc, src1Loc, src2Loc, op, labelProvider):
    assert(resultLoc.getIndirLevel() == 1)
    t = src1Loc.getType()
    if not t.isInteger():
        raise SemanticError(src1Loc.getLocation(), "Can only shift integers")
    if not src2Loc.getType().isInteger() or src2Loc.getType().getSign():
        raise SemanticError(src2Loc.getLocation(), "Can only shift by unsigned integers")
    resultLoc = resultLoc.withType(t)
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    assert(l1 == 0 or l1 == 1)
    assert(l2 == 0 or l2 == 1)
    if l1 == 0 and l2 == 0:
        raise NotImplementedError("Stop doing shit with pointers!")
    if l2 == 0:
        c = src2Loc.getSource()
        if isinstance(c, int):
            if op == 'shl':
                return _genSHLVarByConst(resultLoc, src1Loc, c)
            elif op == 'shr':
                if t.getSign():
                    return _genSARVarByConst(resultLoc, src1Loc, c)
                else:
                    return _genSHRVarByConst(resultLoc, src1Loc, c)
        else:
            raise NotImplementedError("Stop doing shit with pointers!")
    else:
        if op == 'shl':
            return _genSHLByVar(resultLoc, src1Loc, src2Loc, labelProvider)
        elif op == 'shr':
            if t.getSign():
                return _genSARByVar(resultLoc, src1Loc, src2Loc, labelProvider)
            else:
                return _genSHRByVar(resultLoc, src1Loc, src2Loc, labelProvider)

def _genSHLVarByConst(resultLoc, srcLoc, n):
    rs = resultLoc.getSource()
    s = srcLoc.getSource()
    isWord = srcLoc.getType().getSize() == 2
    result = '; shl {}, {}'.format(srcLoc, n)
    if n == 0:
        return srcLoc, result
    if not isWord:
        if n >= 8:
            result += '''
                mov a, 0
                ldi pl, lo({0})
                ldi ph, hi({0})
                st a
            '''.format(rs)
        else:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld a
            '''.format(s)
            for i in range(n):
                result += 'shl a\n'
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st a
            '''.format(rs)
    else:
        if n >= 16:
            result += '''
                mov a, 0
                ldi pl, lo({0})
                ldi ph, hi({0})
                st a
                inc pl
                st a
            '''.format(rs)
        elif n >= 8:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld a
            '''.format(s)
            for i in range(n - 8):
                result += 'shl a\n'
            result += '''
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                st a
                mov a, 0
                dec pl
                st a
            '''.format(rs)
        else:
            # 1..7
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld b
                inc pl
                ld a
            '''.format(s)
            for i in range(n):
                result += '''
                    shl a
                    shl b
                    adc a, 0
                '''
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st b
                inc pl
                st a
            '''.format(rs)
    return resultLoc, result

def _genSHRVarByConst(resultLoc, srcLoc, n):
    rs = resultLoc.getSource()
    s = srcLoc.getSource()
    isWord = srcLoc.getType().getSize() == 2
    result = '; shr {}, {}'.format(srcLoc, n)
    if n == 0:
        return resultLoc, result
    if not isWord:
        if n >= 8:
            result += '''
                mov a, 0
                ldi pl, lo({0})
                ldi ph, hi({0})
                st a
            '''.format(rs)
        else:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld a
            '''.format(s)
            for i in range(n):
                result += 'shr a\n'
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st a
            '''.format(rs)
    else:
        if n >= 16:
            result += '''
                mov a, 0
                ldi pl, lo({0})
                ldi ph, hi({0})
                st a
                inc pl
                st a
            '''.format(rs)
        elif n >= 8:
            result += '''
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                ld a
            '''.format(s)
            for i in range(n - 8):
                result += 'shr a\n'
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st a
                mov a, 0
                inc pl
                st a
            '''.format(rs)
        else:
            # 1..7
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld b
                inc pl
                ld a
                mov pl, a
            '''.format(s)
            for i in range(n):
                result += '''
                    shr a
                    shr b
                '''
            for i in range(8 - n):
                result += 'shl pl\n'
            result += '''
                mov ph, a
                mov a, pl
                or b, a
                mov a, ph
                ldi pl, lo({0})
                ldi ph, hi({0})
                st b
                inc pl
                st a
            '''.format(rs)
    return resultLoc, result

def _genSARVarByConst(resultLoc, srcLoc, n):
    rs = resultLoc.getSource()
    s = srcLoc.getSource()
    isWord = srcLoc.getType().getSize() == 2
    result = '; sar {}, {}'.format(srcLoc, n)
    if n == 0:
        return resultLoc, result
    if not isWord:
        if n >= 8:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld a
                shl a
                mov a, 0
                sbb a, 0
                ldi pl, lo({1})
                ldi ph, hi({1})
                st a
            '''.format(s, rs)
        else:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld a
            '''.format(s)
            for i in range(n):
                result += 'sar a\n'
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st a
            '''.format(rs)
    else:
        if n >= 16:
            result += '''
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                ld a
                shl a
                mov a, 0
                sbb a, 0
                ldi pl, lo({1})
                ldi ph, hi({1})
                st a
                inc pl
                st a
            '''.format(s, rs)
        elif n >= 8:
            result += '''
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                ld a
                ld b
                shl a
                mov a, 0
                sbb a, 0
            '''.format(s)
            for i in range(n - 8):
                result += 'sar b\n'
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st b
                inc pl
                st a
            '''.format(rs)
        else:
            # 1..7
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld b
                inc pl
                ld a
                mov pl, a
            '''.format(s)
            for i in range(n):
                result += '''
                    sar a
                    shr b
                '''
            for i in range(8 - n):
                result += 'shl pl\n'
            result += '''
                mov ph, a
                mov a, pl
                or b, a
                mov a, ph
                ldi pl, lo({0})
                ldi ph, hi({0})
                st b
                inc pl
                st a
            '''.format(rs)
    return resultLoc, result

def _genShByteByVar(resultLoc, src1Loc, src2Loc, labelProvider, op):
    lBegin = labelProvider.allocLabel("shift_begin")
    lLoop = labelProvider.allocLabel("shift_loop")
    lEnd = labelProvider.allocLabel("shift_end")
    result = '; {} = {} {}, {} (byte)'.format(resultLoc, op, src1Loc, src2Loc)
    if src2Loc.getType().getSize() != 1:
        result += '''
            ldi pl, lo({src2} + 1)
            ldi ph, hi({src2} + 1)
            ld a
            ldi b, 0
            add a, 0
            ldi pl, lo({labelEnd})
            ldi ph, hi({labelEnd})
            jnz
        '''.format(src2 = src2Loc.getSource(), labelEnd = lEnd)
    result += '''
        ldi pl, lo({src2})
        ldi ph, hi({src2})
        ld a
        ldi b, 7
        sub b, a
        ldi pl, lo({labelBegin})
        ldi ph, hi({labelBegin})
        jnc ; a > 7
        ldi b, 0
        ldi pl, lo({labelEnd})
        ldi ph, hi({labelEnd})
        jmp
    {labelBegin}:
    '''.format(src2 = src2Loc.getSource(), labelBegin = lBegin, labelEnd = lEnd)
    if src1Loc.getIndirLevel() == 0:
        result += 'ldi b, lo({})\n'.format(src1Loc.getSource())
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
        '''.format(src1Loc.getSource())
    result += '''
        ldi pl, lo({labelEnd})
        ldi ph, hi({labelEnd})
        add a, 0
        jz ; a == 0
    {labelLoop}:
        {op} b
        dec a
        ldi pl, lo(labelLoop)
        ldi ph, hi(labelLoop)
        jnz
    {labelEnd}:
        ldi pl, lo({res})
        ldi ph, hi({res})
        st b
    '''.format(src2 = src2Loc.getSource(), labelEnd = lEnd, labelLoop = lLoop, res = resultLoc.getSource(), op = op)
    return resultLoc, result

# src2Loc is a var, 1 or 2 bytes
# src1Loc var or const, 2 bytes
def _genShiftWordCall(resultLoc, src1Loc, src2Loc, label):
    result = '; {} = shift {}, {}\n'.format(resultLoc, src1Loc, src2Loc)
    if src1Loc.getIndirLevel() == 0:
        result += '''
            ldi a, hi({0})
            ldi b, lo({0})
        '''.format(src1Loc.getSource())
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
            inc pl
            ld a
        '''.format(src1Loc.getSource())
    result += '''
        ldi pl, lo(__cc_sh_var)
        ldi ph, hi(__cc_sh_var)
        st b
        inc pl
        st a
        ldi pl, lo({0})
        ldi ph, hi({0})
        ld b
    '''.format(src2Loc.getSource())
    if src2Loc.getType().getSize() == 2:
        result += '''
            inc pl
            ld a
        '''
    else:
        result += 'mov a, 0\n'
    result += '''
        ldi pl, lo(__cc_sh_count)
        ldi ph, hi(__cc_sh_count)
        st b
        inc pl
        st a
        ldi pl, lo({0})
        ldi ph, hi({0})
        jmp
        ldi pl, lo(__cc_sh_var)
        ldi ph, hi(__cc_sh_var)
        ld b
        inc pl
        ld a
        ldi pl, lo({1})
        ldi ph, hi({1})
        st b
        inc pl
        st a
    '''.format(label, resultLoc.getSource())
    return resultLoc, result

# src2Loc is a var, 1 or 2 bytes
# src1Loc var or const
def _genSHLByVar(resultLoc, src1Loc, src2Loc, labelProvider):
    isWord = src1Loc.getType().getSize() == 2
    if not isWord:
        return _genShByteByVar(resultLoc, src1Loc, src2Loc, labelProvider, "shl")
    else:
        return _genShiftWordCall(resultLoc, src1Loc, src2Loc, "__cc_asl")

def _genSHRByVar(resultLoc, src1Loc, src2Loc, labelProvider):
    isWord = src1Loc.getType().getSize() == 2
    if not isWord:
        return _genShByteByVar(resultLoc, src1Loc, src2Loc, labelProvider, "shr")
    else:
        return _genShiftWordCall(resultLoc, src1Loc, src2Loc, "__cc_lsr")

def _genSARByVar(resultLoc, src1Loc, src2Loc, labelProvider):
    isWord = src1Loc.getType().getSize() == 2
    if not isWord:
        return _genShByteByVar(resultLoc, src1Loc, src2Loc, labelProvider, "sar")
    else:
        return _genShiftWordCall(resultLoc, src1Loc, src2Loc, "__cc_asr")
