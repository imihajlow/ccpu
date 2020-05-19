from value import Value
import operator
import labelname

def _align(x, a):
    if x % a == 0:
        return x
    else:
        return (x // a)  * a + a

def _signExpandByte(x):
    if x & 0x80:
        return x | 0xff00
    else:
        return x

def _hi(x):
    return (x >> 8) & 0xff

def _lo(x):
    return x & 0xff

def startCodeSection():
    return ".section text\n"

def startBssSection():
    return ".section bss\n"
    return ".align 2\n"

def dumpExports(exports):
    return "".join(".export {}\n".format(s) for s in exports)

def dumpImports(imports):
    return "".join(".global {}\n".format(s) for s in imports)

def reserve(label, size):
    return "{}: res {}\n".format(label, min(2, size))

def reserveTempVars(maxIndex):
    return "".join(reserve(labelname.getTempName(i), 2) for i in range(maxIndex + 1))

def reserveVar(label, type):
    rs = _align(type.getReserveSize(), 2)
    return "{}: res {}\n".format(label, rs)

def genFunctionPrologue(fn):
    return genLabel(fn) + '''
        mov a, pl
        mov b, a
        mov a, ph
        ldi pl, lo({0})
        ldi ph, hi({0})
        st b
        inc pl
        st a
        '''.format(labelname.getReturnAddressLabel(fn))

def genReturn(fn):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        ld a
        inc pl
        ld ph
        mov pl, a
        jmp
        ; ========================
        '''.format(labelname.getReturnAddressLabel(fn))

def genCall(fn):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jmp
        '''.format(fn)

def genPushLocals(fn):
    raise NotImplementedError("Recursion isn't implemented")

def genPopLocals(fn):
    raise NotImplementedError("Recursion isn't implemented")

def _loadConst(size, value):
    # load const into a:b
    if isinstance(value, int):
        result = 'ldi b, {}\n'.format(_lo(value))
        if size > 1:
            h = _hi(value)
            if h == 0:
                result += 'mov a, 0\n'
            else:
                result += 'ldi a, {}\n'.format(h)
    else:
        result = 'ldi b, lo({})\n'.format(value)
        if size > 1:
            result += 'ldi a, hi({})\n'.format(value)
    return result

def genMove(resultLoc, srcLoc, avoidCopy):
    if srcLoc.getType().isUnknown():
        raise ValueError("Unknown source type")
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise ValueError("Incompatible types to assign: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    if srcLoc == resultLoc:
        return resultLoc, ""
    else:
        if avoidCopy:
            return srcLoc, ""
        else:
            if resultLoc.getIndirLevel() != 1:
                raise RuntimeError("Compiler error: move destination level of indirection is not 1")
            size = srcLoc.getType().getSize()
            if size != 1 and size != 2:
                raise RuntimeError("Compiler error: move size is {}".format(size))
            loadCode = ""
            if srcLoc.getIndirLevel() == 0:
                # var := const
                c = srcLoc.getSource()
                loadCode += _loadConst(size, c)
            else:
                # var := var
                loadCode += '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld b
                    '''.format(srcLoc.getSource())
                if size > 1:
                    loadCode += '''
                    inc pl
                    ld a
                    '''
            storeCode = '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st b
                '''.format(resultLoc.getSource())
            if size > 1:
                storeCode += '''
                    inc pl
                    st a
                    '''
            return resultLoc, loadCode + storeCode

def genCast(resultLoc, t, srcLoc):
    resultLoc = resultLoc.withType(t)
    if resultLoc == srcLoc:
        return resultLoc, ""
    if resultLoc.getIndirLevel() != 1:
        raise RuntimeError("Compiler error: move destination level of indirection is not 1")
    assert(resultLoc.getType().getSize() == 1 or resultLoc.getType().getSize() == 2)
    assert(srcLoc.getType().getSize() == 1 or srcLoc.getType().getSize() == 2)
    if srcLoc.getIndirLevel() == 1 and srcLoc.getSource() == resultLoc.getSource():
        # cast into itself
        if resultLoc.getType().getSize() > srcLoc.getType().getSize():
            # widen
            if srcLoc.getType().getSign():
                # sign expand
                return resultLoc, '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld a
                    shl a
                    exp a
                    inc pl
                    st a
                    '''.format(srcLoc.getSource())
            else:
                # zero expand
                return resultLoc, '''
                    ldi pl, lo({0} + 1)
                    ldi ph, hi({0} + 1)
                    mov a, 0
                    st a
                    '''.format(srcLoc.getSource())
        else:
            # make narrower or the same, do nothing
            return resultLoc, ""
    else:
        # cast into a different destination
        if srcLoc.getIndirLevel() == 0:
            # cast a constant
            if isinstance(srcLoc.getSource(), int) and srcLoc.getType().getSize() == 1 and srcLoc.getType().getSign():
                # a signed byte into something -> sign expand it
                return genMove(resultLoc, Value(t, 0, _signExpandByte(srcLoc.getSource()), False))
            else:
                return genMove(resultLoc, srcLoc.withType(t), True)
        if resultLoc.getType().getSize() > srcLoc.getType().getSize():
            # widen a byte
            if srcLoc.getType().getSign():
                # sign expand
                result = '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld a
                    ldi pl, lo({1})
                    ldi ph, hi({1})
                    st a
                    shl a
                    exp a
                    inc pl
                    st a
                    '''.format(srcLoc.getSource(), resultLoc.getSource())
            else:
                # zero expand
                result = '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld a
                    ldi pl, lo({1})
                    ldi ph, hi({1})
                    st a
                    inc pl
                    mov a, 0
                    st a
                    '''.format(srcLoc.getSource(), resultLoc.getSource())
            return resultLoc, result
        else:
            # same size or narrower
            result = '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld a
                '''.format(srcLoc.getSource())
            if t.getSize() == 2:
                result += '''
                    inc pl
                    ld b
                '''
            result +='''
                ldi pl, lo({0})
                ldi ph, hi({0})
                st a
                '''.format(resultLoc.getSource())
            if t.getSize() == 2:
                result += '''
                    inc pl
                    st b
                '''
            return resultLoc, result

def genDeref(resultLoc, srcLoc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType().deref())
    if srcLoc.getType().deref() != resultLoc.getType():
        raise ValueError("Incompatible types for deref: {} and {}".format(srcLoc.getType().deref(), resultLoc.getType()))
    assert(srcLoc.getIndirLevel() <= 1)

    t = resultLoc.getType()
    assert(0 < t.getSize() <= 2)

    result = '''
        ldi pl, lo({0})
        ldi ph, hi({0})
    '''.format(srcLoc.getSource())
    if srcLoc.getIndirLevel() == 1:
        result += '''
            ld a
            inc pl
            ld ph
            mov pl, a
        '''
    # TODO: s8 x; s8 a[10]; x = *a;
    result += '''
        ld b
    '''
    if t.getSize() > 1:
        result += '''
            mov a, 0
            inc pl
            adc ph, a
            ld a
        '''
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        st b
    '''.format(resultLoc.getSource())
    if t.getSize() > 1:
        result += '''
            inc pl
            st a
        '''
    return resultLoc, result

def genUnary(op, resultLoc, srcLoc):
    if srcLoc.getType().isUnknown():
        raise ValueError("Unknown source type")
    if op == 'deref':
        return genDeref(resultLoc, srcLoc)
    elif op == 'bnot':
        return genBNot(resultLoc, srcLoc)
    elif op == 'lnot':
        return genLNot(resultLoc, srcLoc)
    elif op == 'neg':
        return genNeg(resultLoc, srcLoc)
    else:
        raise RuntimeError("Unhandled unary op: {}".format(op))

def genBinary(op, resultLoc, src1Loc, src2Loc):
    if src1Loc.getType().isUnknown() or src2Loc.getType().isUnknown():
        raise ValueError("Unknown source type")
    if op == 'subscript':
        return genSubscript(resultLoc, src1Loc, src2Loc)
    elif op == 'add':
        return genAdd(resultLoc, src1Loc, src2Loc)
    elif op == 'sub':
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "sub", "sbb", "({}) - ({})", operator.sub)
    elif op == 'band':
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "and", "and", "({}) & ({})", operator.and_)
    elif op == 'bor':
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "or", "or", "({}) | ({})", operator.or_)
    elif op == 'bxor':
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "xor", "xor", "({}) ^ ({})", operator.xor)
    else:
        if src1Loc.getType() != src2Loc.getType():
            raise ValueError("Incompatible source types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
        if resultLoc.getType().isUnknown():
            resultLoc = resultLoc.removeUnknown(src1Loc.getType())
        if resultLoc.getType() != src1Loc.getType():
            raise ValueError("Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
        return resultLoc, "{} = {}({}, {})\n".format(resultLoc, op, src1Loc, src2Loc)

def genPutIndirect(resultAddrLoc, srcLoc, offset=0):
    if srcLoc.getType().isUnknown():
        raise ValueError("Unknown source type")
    if resultAddrLoc.getType().isUnknown():
        resultAddrLoc = resultAddrLoc.removeUnknown(srcLoc.getType())
    if resultAddrLoc.getType().deref() != srcLoc.getType():
        raise ValueError("Incompatible types for put indirect: {} and {}".format(resultAddrLoc.getType().deref(), srcLoc.getType()))
    if offset == 0:
        return "*{} = {}\n".format(resultAddrLoc, srcLoc)
    else:
        return "*({} + {}) = {}\n".format(resultAddrLoc, offset, srcLoc)

def genInvCondJump(condLoc, label):
    '''
    Jump if condLoc is 0
    '''
    return "jmp {} if {} == 0\n".format(label, condLoc)

def genJump(label):
    return "jmp {}\n".format(label)

def genLabel(label):
    return "{}:\n".format(label)

def genSubscript(resultLoc, baseLoc, indexLoc):
    if not indexLoc.getType().isInteger():
        raise ValueError("Index must be an integer, got {}".format(indexLoc.getType()))
    if not baseLoc.getType().isPointer():
        raise ValueError("Subscript base must be a pointer, got {}".format(baseLoc.getType()))
    resultType = baseLoc.getType().deref()
    if baseLoc.getIndirLevel() == 0:
        if indexLoc.getIndirLevel() == 0:
            return Value(resultType, 1, "{} + {} * {}".format(baseLoc.getSource(), indexLoc.getSource(), resultType.getSize())), ""
        else:
            return resultLoc.removeUnknown(resultType), "{} = deref({} + [{}] * {})\n".format(resultLoc, baseLoc, indexLoc, resultType.getSize())
    else:
        if indexLoc.getIndirLevel() == 0:
            return resultLoc.removeUnknown(resultType), "{} = deref([{}] + {} * {}\n".format(resultLoc, baseLoc, indexLoc, resultType.getSize())
        else:
            return resultLoc.removeUnknown(resultType), "{} = deref([{}] + [{}] * {}\n".format(resultLoc, baseLoc, indexLoc, resultType.getSize())

# TODO if resultLoc == srcLoc for unary
def genBNot(resultLoc, srcLoc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise ValueError("Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    assert(resultLoc.getIndirLevel() == 1)
    assert(srcLoc.getIndirLevel() == 1 or srcLoc.getIndirLevel() == 0)
    t = srcLoc.getType()
    result = ''
    if srcLoc.getIndirLevel() == 0:
        # constant
        c = srcLoc.getSource()
        if isinstance(c, int):
            c = ~c
        else:
            c = '~({})'.format(c) # Warning
        result += _loadConst(t.getSize(), c)
    else:
        # var
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
            not b
        '''.format(srcLoc.getSource())
        if t.getSize() > 1:
            result += '''
                inc pl
                ld a
                not a
            '''
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        st b
    '''.format(resultLoc.getSource())
    if t.getSize() > 1:
        result += '''
            inc pl
            st a
        '''
    return resultLoc, result

def genLNot(resultLoc, srcLoc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise ValueError("Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    if srcLoc.getType().getSize() != 1 or srcLoc.getType().getSign():
        raise ValueError("Argument for `!' should be of type u8")
    assert(resultLoc.getIndirLevel() == 1)
    assert(srcLoc.getIndirLevel() == 1 or srcLoc.getIndirLevel() == 0)

    result = ''
    if srcLoc.getIndirLevel() == 0:
        # constant
        c = srcLoc.getSource()
        if isinstance(c, int):
            c = int(not bool(c))
        else:
            c = '0 if bool({}) else 1'.format(c) # Warning
        result += _loadConst(1, c)
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            st b
        '''.format(resultLoc.getSource())
    else:
        # var
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
            ldi a, 1
            sub b, a ; c = b == 0
            mov a, 0
            adc a, 0
        '''.format(srcLoc.getSource())
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            st a
        '''.format(resultLoc.getSource())
    return resultLoc, result

def genNeg(resultLoc, srcLoc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise ValueError("Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    if not srcLoc.getType().getSign():
        raise ValueError("Argument for unary `-' should be of a signed type")
    assert(resultLoc.getIndirLevel() == 1)
    assert(srcLoc.getIndirLevel() == 1 or srcLoc.getIndirLevel() == 0)

    t = srcLoc.getType()
    result = ''
    if srcLoc.getIndirLevel() == 0:
        # constant
        c = srcLoc.getSource()
        if isinstance(c, int):
            c = -c & (0xff if t.getSize() == 1 else 0xffff)
        else:
            c = '-({})'.format(c) # Warning
        result += _loadConst(t.getSize(), c)
    else:
        # var
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
        '''.format(srcLoc.getSource())

        if t.getSize() > 1:
            result += '''
                inc pl
                ld a
                not a
                not b
                inc b
                adc a, 0
            '''
        else:
            result += 'neg b\n'
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        st b
    '''.format(resultLoc.getSource())
    if t.getSize() > 1:
        result += '''
            inc pl
            st a
        '''
    return resultLoc, result

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
        result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
        '''.format(rs)
        c1 = src1Loc.getSource()
        c2 = src2Loc.getSource()
        if isinstance(c1, int) and isinstance(c2, int):
            cr = constLambda(c1, c2)
            l = _lo(cr)
            h = _hi(cr)
            result += 'ldi b, {}\n'.format(l)
            if isWord:
                if h == 0:
                    result += 'mov a, 0\n'
                else:
                    result += 'ldi a, {}\n'.format(h)
        else:
            result += 'ldi b, lo({})\n'.format(pyPattern.format(c1, c2))
            if isWord:
                result += 'ldi a, hi({})\n'.format(pyPattern.format(c1, c2))
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
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld a
                ldi pl, lo({1})
                ldi ph, hi({1})
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

def genAdd(resultLoc, src1Loc, src2Loc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(src1Loc.getType())
    if resultLoc.getType() != src1Loc.getType():
        raise ValueError("Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
    if src1Loc.getType().isPointer():
        if not src2Loc.getType().isInteger():
            raise ValueError("Can only add ponters and integers, not pointers and other types")
        return resultLoc, "{} = {} + {} * {}\n".format(resultLoc, src1Loc, src2Loc, src1Loc.getType().deref().getSize())
    else:
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "add", "adc", "({}) + ({})", operator.add)

def genMulConst(resultLoc, srcLoc, m):
    resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise ValueError("Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    return resultLoc, "{} = {} * {}\n".format(resultLoc, srcLoc, m)
