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
                return genSHLVarByConst(resultLoc, src1Loc, c)
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

def _genSHLVarByConstLarge(resultLoc, srcLoc, n):
    assert(resultLoc != srcLoc)
    rs = resultLoc.getSource()
    s = srcLoc.getSource()
    size = srcLoc.getType().getSize()
    n = min(n, size * 8)
    byteShift = n // 8
    bitShift = n % 8

    result = ''
    result += 'mov a, 0\n'
    if byteShift > 0:
        result += f'''
            ldi pl, lo({rs})
            ldi ph, hi({rs})
        '''
        for i in range(byteShift - 1):
            result += '''
                st a
                inc pl
            '''
            if not resultLoc.isAligned():
                result += 'adc ph, a\n'
        result += 'st a\n'
    for byteIndex in range(byteShift, size):
        result += f'''
            ldi pl, lo({s} + {byteIndex - byteShift})
            ldi ph, hi({s} + {byteIndex - byteShift})
            ld b
        '''
        for bit in range(bitShift):
            if bit != 0:
                result += 'shl a\n'
            result += '''
                shl b
                adc a, 0
            '''
        if byteIndex + 1 != size:
            result += f'''
                ldi pl, lo({rs} + {byteIndex + 1})
                ldi ph, hi({rs} + {byteIndex + 1})
                st a
            '''
            if resultLoc.isAligned():
                result += 'dec pl\n'
            else:
                result += '''
                    mov a, 0
                    dec pl
                    sbb ph, a
                '''
        else:
            result += f'''
                ldi pl, lo({rs} + {byteIndex})
                ldi ph, hi({rs} + {byteIndex})
            '''
        if byteIndex == byteShift:
            result += 'st b\n'
        else:
            result += '''
                ld a
                or a, b
                st a
            '''
        if byteIndex + 1 != size:
            result += 'mov a, 0\n'
    return result

def _adjustP(resultLoc, offset, oldP):
    if oldP == offset:
        return '', offset
    elif oldP is None or not resultLoc.isAligned():
        return f'''
            ldi pl, lo({resultLoc.getSource()} + {offset})
            ldi ph, hi({resultLoc.getSource()} + {offset})
        ''', offset
    elif oldP == offset:
        return '', offset
    elif offset - oldP == 1:
        return 'inc pl\n', offset
    elif oldP - offset == 1:
        return 'dec pl\n', offset
    else:
        return f'ldi pl, lo({resultLoc.getSource()} + {offset})\n', offset

def _genSHLVarByConstLargeInplace(resultLoc, n):
    rs = resultLoc.getSource()
    size = resultLoc.getType().getSize()
    n = min(n, size * 8)
    byteShift = n // 8
    bitShift = n % 8

    result = ''
    p = None
    lastByteLoaded = False
    # high bytes are assembled from two values
    for offset in reversed(range(byteShift + 1, size)):
        pCode, p = _adjustP(resultLoc, offset - byteShift - 1, p)
        result += pCode
        result += 'ld b\n'
        # B = source byte
        pCode, p = _adjustP(resultLoc, offset - byteShift, p)
        result += pCode
        # P = destination address
        result += 'ld a\n'
        for bit in range(bitShift):
            result += '''
                shl a
                shl b
                adc a, 0
            '''
        pCode, p = _adjustP(resultLoc, offset, p)
        result += pCode
        result += 'st a\n'
        lastByteLoaded = True
    # last meaningful byte is assembled from one value
    if byteShift < size:
        if not lastByteLoaded:
            pCode, p = _adjustP(resultLoc, 0, p)
            result += pCode
            result += 'ld b\n'
            for bit in range(bitShift):
                result += 'shl b\n'
        pCode, p = _adjustP(resultLoc, byteShift, p)
        result += pCode
        result += 'st b\n'
    # the rest are zeroes
    if byteShift > 0:
        result += 'mov a, 0\n'
        for offset in reversed(range(0, byteShift)):
            pCode, p = _adjustP(resultLoc, offset, p)
            result += pCode
            result += 'st a\n'
    return result


def genSHLVarByConst(resultLoc, srcLoc, n):
    rs = resultLoc.getSource()
    s = srcLoc.getSource()
    size = srcLoc.getType().getSize()
    result = f'; {resultLoc} := shl {srcLoc}, {n}\n'
    if n == 0:
        return srcLoc, result
    if size == 1:
        assert(resultLoc.getType().getSize() <= 2)
        expandToWord = resultLoc.getType().getSize() == 2
        signed = srcLoc.getType().getSign()
        if n >= 8:
            if expandToWord:
                n -= 8
                if n >= 8:
                    result += f'''
                        mov a, 0
                        ldi pl, lo({rs})
                        ldi ph, hi({rs})
                        st a
                        inc pl
                    '''
                    if not resultLoc.isAligned():
                        result += 'adc ph, a\n'
                    result += 'st a\n'
                else:
                    result += f'''
                        ldi pl, lo({s})
                        ldi ph, hi({s})
                        ld b
                    '''
                    for i in range(n):
                        result += 'shl b\n'
                    result += f'''
                        mov a, 0
                        ldi pl, lo({rs})
                        ldi ph, hi({rs})
                        st a
                        inc pl
                    '''
                    if not resultLoc.isAligned():
                        result += 'adc ph, a\n'
                    result += 'st b\n'
            else:
                result += f'''
                    mov a, 0
                    ldi pl, lo({rs})
                    ldi ph, hi({rs})
                    st a
                '''
        else:
            result += f'''
                ldi pl, lo({s})
                ldi ph, hi({s})
                ld b
            '''
            if expandToWord:
                if not signed:
                    result += 'mov a, 0\n'
            for i in range(n):
                if expandToWord:
                    if i > 0:
                        result += 'shl a\n'
                    if i == 0 and signed:
                        result += '''
                            shl b
                            exp a
                        '''
                    else:
                        result += '''
                            shl b
                            adc a, 0
                        '''
                else:
                    result += 'shl b\n'
            result += f'''
                ldi pl, lo({rs})
                ldi ph, hi({rs})
                st b
            '''
            if expandToWord:
                if resultLoc.isAligned():
                    result += 'inc pl\n'
                else:
                    result += f'''
                        ldi pl, lo({rs} + 1)
                        ldi ph, hi({rs} + 1)
                    '''
                result += 'st a\n'
    elif size == 2:
        assert(resultLoc.getType().getSize() == 2)
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
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                ld a
            '''.format(s) # TODO optimize aligned
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
    else:
        if resultLoc != srcLoc:
            result += _genSHLVarByConstLarge(resultLoc, srcLoc, n)
        else:
            result += _genSHLVarByConstLargeInplace(resultLoc, n)

    return resultLoc, result

def _genSHRVarByConst(resultLoc, srcLoc, n):
    rs = resultLoc.getSource()
    s = srcLoc.getSource()
    isWord = srcLoc.getType().getSize() == 2
    result = '; shr {}, {}'.format(srcLoc, n)
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
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                ld a
                mov pl, a
            '''.format(s) # TODO optimize aligned
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
        return srcLoc, result
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
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                ld a
                mov pl, a
            '''.format(s) # TODO optimize aligned
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
    lInf = labelProvider.allocLabel("shift_inf")
    result = '; {} = {} {}, {} (byte)'.format(resultLoc, op, src1Loc, src2Loc)
    if src2Loc.getType().getSize() != 1:
        result += '''
            ldi pl, lo({src2} + 1)
            ldi ph, hi({src2} + 1)
            ld a
            add a, 0
            ldi pl, lo({labelInf})
            ldi ph, hi({labelInf})
            jnz
        '''.format(src2 = src2Loc.getSource(), labelInf = lInf)
    result += '''
        ldi pl, lo({src2})
        ldi ph, hi({src2})
        ld a
        ldi b, 7
        sub b, a
        ldi pl, lo({labelBegin})
        ldi ph, hi({labelBegin})
        jnc ; a <= 7
    {labelInf}:
    '''.format(src2 = src2Loc.getSource(), labelBegin = lBegin, labelInf = lInf)
    if src1Loc.getType().getSign() and op != 'shl':
        if src1Loc.getIndirLevel() == 0:
            result += 'ldi b, lo({})\n'.format(src1Loc.getSource())
        else:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld b
            '''.format(src1Loc.getSource())
        result += '''
            shl b
            exp b
        '''
    else:
        result += 'ldi b, 0\n'
    result += '''
        ldi pl, lo({labelEnd})
        ldi ph, hi({labelEnd})
        jmp
    {labelBegin}:
    '''.format(labelBegin = lBegin, labelEnd = lEnd)
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
        ldi pl, lo({labelLoop})
        ldi ph, hi({labelLoop})
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
            ldi pl, lo({0} + 1)
            ldi ph, hi({0} + 1)
            ld a
        '''.format(src1Loc.getSource()) # TODO optimize aligned
    result += '''
        ldi pl, lo(__cc_sh_val)
        ldi ph, hi(__cc_sh_val)
        st b
        inc pl
        st a
        ldi pl, lo({0})
        ldi ph, hi({0})
        ld b
    '''.format(src2Loc.getSource())
    if src2Loc.getType().getSize() == 2:
        result += '''
            ldi pl, lo({0} + 1)
            ldi ph, hi({0} + 1)
            ld a
        '''.format(src2Loc.getSource()) # TODO optimize aligned
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
        ldi pl, lo(__cc_sh_val)
        ldi ph, hi(__cc_sh_val)
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
