from value import Value
from type import BoolType
import operator
import labelname
from position import Position
from exceptions import SemanticError, NatrixNotImplementedError, RegisterNotSupportedError
from .common import *

def genShift(resultLoc, src1Loc, src2Loc, op, labelProvider):
    assert(resultLoc.getIndirLevel() == 1)
    t = src1Loc.getType()
    if not t.isInteger():
        raise SemanticError(src1Loc.getPosition(), "Can only shift integers")
    if not src2Loc.getType().isInteger() or src2Loc.getType().getSign():
        raise SemanticError(src2Loc.getPosition(), "Can only shift by unsigned integers")
    resultLoc = resultLoc.withType(t)
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    assert(l1 == 0 or l1 == 1)
    assert(l2 == 0 or l2 == 1)
    if l1 == 0 and l2 == 0:
        raise NatrixNotImplementedError(Position.fromAny(resultLoc), "Stop doing shit with pointers!")
    if l2 == 0:
        c = src2Loc.getSource()
        if c.isNumber():
            if op == 'shl':
                return genSHLVarByConst(resultLoc, src1Loc, int(c))
            elif op == 'shr':
                if t.getSign():
                    return _genSARVarByConst(resultLoc, src1Loc, int(c))
                else:
                    return _genSHRVarByConst(resultLoc, src1Loc, int(c))
        else:
            raise NatrixNotImplementedError(Position.fromAny(resultLoc), "Stop doing shit with pointers!")
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
    assert(not srcLoc.getSource().isRegister())
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
    oldLoc, oldOffset = oldP if oldP is not None else (None, None)
    code = ''
    if oldP == (resultLoc, offset):
        code = ''
    elif oldP is None or oldLoc != resultLoc or not resultLoc.isAligned():
        code = f'''
            ldi pl, lo({resultLoc.getSource()} + {offset})
            ldi ph, hi({resultLoc.getSource()} + {offset})
        '''
    elif oldOffset == offset:
        code = ''
    elif offset - oldOffset == 1:
        code = 'inc pl\n'
    elif oldOffset - offset == 1:
        code = 'dec pl\n'
    else:
        code = f'ldi pl, lo({resultLoc.getSource()} + {offset})\n'
    return code, (resultLoc, offset)

def _genSHLVarByConstLargeInplace(resultLoc, n):
    rs = resultLoc.getSource()
    assert(not rs.isRegister())
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
                    result += loadByte('b', srcLoc, 0)
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
                '''
                return Value.register(srcLoc.getPosition(), resultLoc.getType()), result
        else:
            result += loadByte('b', srcLoc, 0)
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
            if expandToWord:
                result += f'''
                    ldi pl, lo({rs})
                    ldi ph, hi({rs})
                    st b
                '''
                if resultLoc.isAligned():
                    result += 'inc pl\n'
                else:
                    result += f'''
                        ldi pl, lo({rs} + 1)
                        ldi ph, hi({rs} + 1)
                    '''
                result += 'st a\n'
            else:
                result += 'mov a, b\n'
                return Value.register(srcLoc.getPosition(), resultLoc.getType()), result
    elif size == 2:
        assert(resultLoc.getType().getSize() == 2)
        assert(not s.isRegister())
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

def _genSHRVarByConstLarge(resultLoc, srcLoc, n):
    s = srcLoc.getSource()
    rs = resultLoc.getSource()
    size = srcLoc.getType().getSize()
    result = f'; {resultLoc} = shr {srcLoc}, {n}\n'
    bitShift = n % 8
    byteShift = n // 8
    p = None
    for offset in range(size - byteShift):
        pCode, p = _adjustP(srcLoc, offset + byteShift, p)
        result += pCode
        result += 'ld b\n'
        lastByte = offset + 1 + byteShift >= size
        if bitShift != 0:
            if not lastByte:
                pCode, p = _adjustP(srcLoc, offset + 1 + byteShift, p)
                result += pCode
                result += 'ld a\n'
            for bit in range(8):
                if bit < bitShift:
                    result += 'shr b\n'
                elif not lastByte:
                    result += 'shl a\n'
            if not lastByte:
                result += 'or b, a\n'
        pCode, p = _adjustP(resultLoc, offset, p)
        result += pCode
        result += 'st b\n'
    if byteShift > 0:
        result += 'mov a, 0\n'
        for offset in range(size - byteShift, size):
            pCode, p = _adjustP(resultLoc, offset, p)
            result += pCode
            result += 'st a\n'
    return resultLoc, result

def _genSHRVarByConst(resultLoc, srcLoc, n):
    rs = resultLoc.getSource()
    s = srcLoc.getSource()
    size = srcLoc.getType().getSize()
    result = '; shr {}, {}\n'.format(srcLoc, n)
    if n == 0:
        return srcLoc, result
    if size == 1:
        if n >= 8:
            result += '''
                mov a, 0
            '''
        else:
            result += loadByte('a', srcLoc, 0)
            for i in range(n):
                result += 'shr a\n'
        return Value.register(srcLoc.getPosition(), resultLoc.getType()), result
    elif size == 2:
        assert(not s.isRegister())
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
    else:
        if n >= 8 * size:
            return Value(srcLoc.getPosition(), resultLoc.getType(), 0, 0, True), ''
        elif resultLoc == srcLoc:
            return _genSHRVarByConstLarge(resultLoc, srcLoc, n)
        else:
            return _genSHRVarByConstLarge(resultLoc, srcLoc, n)

    return resultLoc, result

def _genSARVarByConst(resultLoc, srcLoc, n):
    rs = resultLoc.getSource()
    s = srcLoc.getSource()
    size = srcLoc.getType().getSize()
    result = '; sar {}, {}\n'.format(srcLoc, n)
    if n == 0:
        return srcLoc, result
    if size == 1:
        if n >= 8:
            result += loadByte('a', srcLoc, 0)
            result += '''
                shl a
                mov a, 0
                sbb a, 0
            '''.format(s, rs)
        else:
            result += loadByte('a', srcLoc, 0)
            for i in range(n):
                result += 'sar a\n'
        return Value.register(srcLoc.getPosition(), resultLoc.getType()), result
    elif size == 2:
        assert(not s.isRegister())
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
    else:
        assert(not s.isRegister())
        byteShift = n // 8
        bitShift = n % 8
        if byteShift >= 1:
            # fill high bytes with sign
            result += f'''
                ldi pl, lo({s} + {size - 1})
                ldi ph, hi({s} + {size - 1})
                ld a
                shl a
                exp a
            '''
            result += f'''
                ldi pl, lo({rs} + {size - 1})
                ldi ph, hi({rs} + {size - 1})
            '''

            for i in range(byteShift):
                if i != 0:
                    result += 'dec pl\n'
                    if not resultLoc.isAligned():
                        result += f'ldi ph, hi({rs} + {size - 1 - i})\n'
                result += 'st a\n'
        for i in range(size - byteShift):
            result += f'''
                ldi pl, lo({s} + {i + byteShift})
                ldi ph, hi({s} + {i + byteShift})
                ld a
            '''
            if bitShift != 0:
                if i + byteShift != size - 1:
                    # usual byte
                    result += 'inc pl\n'
                    if not srcLoc.isAligned():
                        result += f'ldi ph, hi({s} + {i + byteShift + 1})\n'
                    result += 'ld b\n'
                    for bit in range(bitShift):
                        result += 'shr a\n'
                    for bit in range(8 - bitShift):
                        result += 'shl b\n'
                    result += 'or a, b\n'
                else:
                    # hi byte
                    for bit in range(bitShift):
                        result += 'sar a\n'
            result += f'''
                ldi pl, lo({rs} + {i})
                ldi ph, hi({rs} + {i})
                st a
            '''
    return resultLoc, result

def _genShByteByVar(resultLoc, src1Loc, src2Loc, labelProvider, op):
    if src2Loc.getType().getSize() > 1:
        raise NatrixNotImplementedError(src2Loc.getPosition(), "Shift by variables over 8 bits")
    lBegin = labelProvider.allocLabel("shift_begin")
    lLoop = labelProvider.allocLabel("shift_loop")
    lEnd = labelProvider.allocLabel("shift_end")
    lInf = labelProvider.allocLabel("shift_inf")
    if src1Loc.getSource().isRegister():
        raise RegisterNotSupportedError(0)
    result = '; {} = {} {}, {} (byte)\n'.format(resultLoc, op, src1Loc, src2Loc)
    result += loadByte('a', src2Loc, 0)
    result += f'''
        ldi b, 7
        sub b, a
        ldi pl, lo({lBegin})
        ldi ph, hi({lBegin})
        jnc ; a <= 7
    {lInf}:
    '''
    if src1Loc.getType().getSign() and op != 'shl':
        result += loadByte('b', src1Loc, 0)
        result += '''
            shl b
            exp b
        '''
    else:
        result += 'ldi b, 0\n'
    result += f'''
        ldi pl, lo({lEnd})
        ldi ph, hi({lEnd})
        jmp
    {lBegin}:
    '''
    result += loadByte('b', src1Loc, 0)
    result += f'''
        ldi pl, lo({lEnd})
        ldi ph, hi({lEnd})
        add a, 0
        jz ; a == 0
    {lLoop}:
        {op} b
        dec a
        ldi pl, lo({lLoop})
        ldi ph, hi({lLoop})
        jnz
    {lEnd}:
        mov a, b
    '''
    return Value.register(resultLoc.getPosition(), resultLoc.getType()), result

# src2Loc is a var, 1 or 2 bytes
# src1Loc var or const, 2 bytes
def _genShiftWordCall(resultLoc, src1Loc, src2Loc, label):
    result = '; {} = shift {}, {}\n'.format(resultLoc, src1Loc, src2Loc)
    if src2Loc.getType().getSize() == 2:
        assert(not src2Loc.getSource().isRegister())
        result += f'''
            ldi pl, lo({src2Loc.getSource()})
            ldi ph, hi({src2Loc.getSource()})
            ld b
        '''
        result += incP(src1Loc.isAligned())
        result += 'ld a\n'
    else:
        result += loadByte('b', src2Loc, 0)
        result += 'mov a, 0\n'
    result += '''
        ldi pl, lo(__cc_sh_count)
        ldi ph, hi(__cc_sh_count)
        st b
        inc pl
        st a
    '''
    if src1Loc.getIndirLevel() == 0:
        result += loadByte('a', src1Loc, 1)
        result += loadByte('b', src1Loc, 0)
    else:
        result += f'''
            ldi pl, lo({src1Loc.getSource()})
            ldi ph, hi({src1Loc.getSource()})
            ld b
        '''
        result += incP(src1Loc.isAligned())
        result += 'ld a\n'
    result += f'''
        ldi pl, lo(__cc_sh_val)
        ldi ph, hi(__cc_sh_val)
        st b
        inc pl
        st a
        ldi pl, lo({label})
        ldi ph, hi({label})
        jmp
        ldi pl, lo(__cc_sh_val)
        ldi ph, hi(__cc_sh_val)
        ld b
        inc pl
        ld a
        ldi pl, lo({resultLoc.getSource()})
        ldi ph, hi({resultLoc.getSource()})
        st b
        inc pl
        st a
    '''
    return resultLoc, result

# src2Loc is a var, 1 or 2 bytes
# src1Loc var or const, N bytes
def _genShiftLargeCall(resultLoc, src1Loc, src2Loc, label):
    result = f'; {resultLoc} = shift {src1Loc}, {src2Loc}\n'
    s2 = src2Loc.getSource()
    s1 = src1Loc.getSource()
    rs = resultLoc.getSource()
    if src2Loc.getType().getSize() == 2:
        raise NatrixNotImplementedError(Position.fromAny(src2Loc), "Shift large by word")
    result += loadByte('a', src2Loc, 0)
    result += f'''
        ldi pl, lo(__cc_sh_count)
        ldi ph, hi(__cc_sh_count)
        st a
    '''
    size = src1Loc.getType().getSize()
    for offset in range(0, size, 2):
        rest = size - offset
        pCode, p = _adjustP(src1Loc, offset, None)
        result += pCode
        result += 'ld a\n'
        if rest > 1:
            pCode, p = _adjustP(src1Loc, offset + 1, p)
            result += pCode
            result += 'ld b\n'
        result += f'''
            ldi pl, lo(__cc_sh_val + {offset})
            ldi ph, hi(__cc_sh_val + {offset})
            st a
        '''
        if rest > 1:
            result += '''
                inc pl
                st b
            '''
    result += f'''
        ldi pl, lo({label})
        ldi ph, hi({label})
        jmp
    '''
    for offset in range(0, size, 2):
        result += f'''
            ldi pl, lo(__cc_sh_val + {offset})
            ldi ph, hi(__cc_sh_val + {offset})
            ld a
        '''
        if rest > 1:
            result += '''
                inc pl
                ld b
            '''
        p = None
        rest = size - offset
        pCode, p = _adjustP(resultLoc, offset, p)
        result += pCode
        result += 'st a\n'
        if rest > 1:
            pCode, p = _adjustP(resultLoc, offset + 1, p)
            result += pCode
            result += 'st b\n'
    return resultLoc, result

# src2Loc is a var, 1 or 2 bytes
# src1Loc var or const
def _genSHLByVar(resultLoc, src1Loc, src2Loc, labelProvider):
    size = src1Loc.getType().getSize()
    if size == 1:
        return _genShByteByVar(resultLoc, src1Loc, src2Loc, labelProvider, "shl")
    elif size == 2:
        return _genShiftWordCall(resultLoc, src1Loc, src2Loc, "__cc_asl")
    elif size == 4:
        return _genShiftLargeCall(resultLoc, src1Loc, src2Loc, "__cc_asl_dword")
    else:
        raise NatrixNotImplementedError(Position.fromAny(resultLoc), "SHL large by var")

def _genSHRByVar(resultLoc, src1Loc, src2Loc, labelProvider):
    size = src1Loc.getType().getSize()
    if size == 1:
        return _genShByteByVar(resultLoc, src1Loc, src2Loc, labelProvider, "shr")
    elif size == 2:
        return _genShiftWordCall(resultLoc, src1Loc, src2Loc, "__cc_lsr")
    elif size == 4:
        return _genShiftLargeCall(resultLoc, src1Loc, src2Loc, "__cc_lsr_dword")
    else:
        raise NatrixNotImplementedError(Position.fromAny(resultLoc), "SHR large by var")

def _genSARByVar(resultLoc, src1Loc, src2Loc, labelProvider):
    size = src1Loc.getType().getSize()
    if size == 1:
        return _genShByteByVar(resultLoc, src1Loc, src2Loc, labelProvider, "sar")
    elif size == 2:
        return _genShiftWordCall(resultLoc, src1Loc, src2Loc, "__cc_asr")
    else:
        raise NatrixNotImplementedError(Position.fromAny(resultLoc), "SAR large by var")
