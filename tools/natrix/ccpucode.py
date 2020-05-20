from value import Value
from type import BoolType
import operator
import labelname
import signed

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
                    ; widening cast, sign expand
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
                    ; widening cast, zero expand
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
                    ; widening cast, sign expand
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
                    ; widening cast, zero expand
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
            return srcLoc.withType(resultLoc.getType()), ""

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

def genBinary(op, resultLoc, src1Loc, src2Loc, labelProvider):
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
    if condLoc.getType() != BoolType():
        raise ValueError("Should be a bool type (u8) for a condition, got {}".format(str(condLoc.getType())))
    l = condLoc.getIndirLevel()
    s = condLoc.getSource()
    assert(l == 0 or l == 1)
    result = '; jump if not {}\n'.format(condLoc)
    if l == 0:
        if isinstance(s, int):
            if not bool(s):
                result += '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    jmp
                '''.format(label)
        else:
            result += '''
                ldi a, lo({0})
                add a, 0
                ldi pl, lo({1})
                ldi ph, hi({1})
                jz
            '''.format(s, label)
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld a
            ldi pl, lo({1})
            ldi ph, hi({1})
            add a, 0
            jz
        '''.format(s, label)
    return result

def genJump(label):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jmp
    '''.format(label)

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
        return Value(t, 0, c), result
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
            c = 'int(not bool({}))'.format(c) # Warning
        return Value(BoolType(), 0, c), result
    else:
        # var
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
            dec b ; c = b == 0
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
        return Value(t, 0, c), result
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
    isWord = t.getSize() == 2
    result = ''
    if l1 == 0 or l2 == 0:
        # var == const
        if l1 == 0:
            s1, s2 = s2, s1
        result = '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
        '''.format(s1)
        if isinstance(s2, int):
            l = _lo(s2)
            if l == 0:
                result += 'mov a, 0\n'
            else:
                result += 'ldi a, {}\n'.format(l)
        else:
            result += 'ldi a, lo({})\n'.format(s2)
        result += 'sub b, a\n'
        if isWord:
            result += '''
                inc pl
                ld pl
            '''
            if isinstance(s2, int):
                h = _hi(s2)
                if h == 0:
                    result += 'mov a, 0\n'
                else:
                    result += 'ldi a, {}\n'.format(h)
            else:
                result += 'ldi a, hi({})\n'.format(s2)
            result += '''
                sub a, pl
                or b, a
            '''
    else:
        if not isWord:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld a
                ldi pl, lo({1})
                ldi ph, hi({1})
                ld b
                sub b, a
            '''.format(s1, s2)
        else:
            result += '''
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld a
                ldi pl, lo({1})
                ldi ph, hi({1})
                ld b
                sub b, a
                inc pl
                ld a
                ldi pl, lo({0})
                ldi ph, hi({0})
                ld pl
                sub a, pl
                or b, a
            '''.format(s1, s2)
    return result

def genEq(resultLoc, src1Loc, src2Loc):
    resultLoc = resultLoc.withType(BoolType())
    assert(resultLoc.getIndirLevel() == 1)
    if src1Loc.getType() != src2Loc.getType():
        raise ValueError("Incompatible types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
    t = src1Loc.getType()
    assert(t.getSize() == 1 or t.getSize() == 2)
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    isWord = t.getSize() == 2
    result = '; {} == {}\n'.format(src1Loc, src2Loc)
    if l1 == 0 and l2 == 0:
        # const == const
        if isinstance(s1, int) and isinstance(s2, int):
            return Value(BoolType(), 0, int(s1 == s2)), result
        else:
            return Value(BoolType(), 0, "int(({}) == ({}))".format(s1, s2)), result
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
        raise ValueError("Incompatible types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
    t = src1Loc.getType()
    assert(t.getSize() == 1 or t.getSize() == 2)
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    isWord = t.getSize() == 2
    result = '; {} == {}\n'.format(src1Loc, src2Loc)
    if l1 == 0 and l2 == 0:
        # const == const
        if isinstance(s1, int) and isinstance(s2, int):
            return Value(BoolType(), 0, int(s1 != s2)), result
        else:
            return Value(BoolType(), 0, "int(({}) != ({}))".format(s1, s2)), result
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

def _genCmpSub(src1Loc, src2Loc):
    # subtract the values so that flags C, S, and O are set accordingly and (b | pl) is zero if the result is zero
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    t = src1Loc.getType()
    isWord = t.getSize() == 2
    result = ''
    if l1 == 0:
        # const and var
        if isinstance(s1, int):
            l = _lo(s1)
            h = _hi(s1)
        else:
            l = "lo({})".format(s1)
            h = "hi({})".format(s1)
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld a
            ldi b, {1}
        '''.format(s2, l)
        if isWord:
            result += '''
                inc pl
                sub b, a
                ld a
                ldi pl, {1}
                sbb pl, a
            '''.format(h)
        else:
            result += 'sub b, a\n'
            if op == 'le' or op == 'gt':
                result += 'ldi pl, 0\n'
    elif l2 == 0:
        # var and const
        if isinstance(s2, int):
            l = _lo(s2)
            h = _hi(s2)
        else:
            l = "lo({})".format(s2)
            h = "hi({})".format(s2)
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
            ldi a, {1}
        '''.format(s1, l)
        if isWord:
            result += '''
                inc pl
                sub b, a
                ld pl
                ldi a, {0}
                sbb pl, a
            '''.format(h)
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
                inc pl
                sub b, a
                ld a
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                ld pl
                sbb pl, a
            '''.format(s1, s2)
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

def _genCmpUnsigned(resultLoc, src1Loc, src2Loc, op):
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    t = src1Loc.getType()
    isWord = t.getSize() == 2
    result = '; compare unsigned {} and {} ({})\n'.format(src1Loc, src2Loc, op)
    if l1 == 0 and l2 == 0:
        # const and const
        if isinstance(s1, int) and isinstance(s2, int):
            pyop = {"gt": operator.gt, "lt": operator.lt, "ge": operator.ge, "le": operator.le}[op]
            return Value(BoolType(), 0, int(pyop(s1, s2))), result
        else:
            pyop = {"gt": ">", "lt": "<", "ge": ">=", "le": "<="}[op]
            return Value(BoolType(), 0, "int(({}) {} ({}))".format(s1, pyop, s2)), result
    else:
        result += _genCmpSub(src1Loc, src2Loc)
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

def _genCmpSigned(resultLoc, src1Loc, src2Loc, op, labelProvider):
    s1 = src1Loc.getSource()
    s2 = src2Loc.getSource()
    rs = resultLoc.getSource()
    l1 = src1Loc.getIndirLevel()
    l2 = src2Loc.getIndirLevel()
    t = src1Loc.getType()
    isWord = t.getSize() == 2
    result = '; compare signed {} and {} ({})\n'.format(src1Loc, src2Loc, op)
    if l1 == 0 and l2 == 0:
        # const and const
        if isinstance(s1, int) and isinstance(s2, int):
            raise NotImplementedError("signed const comparison")
        else:
            raise NotImplementedError("signed const comparison")
    else:
        result += _genCmpSub(src1Loc, src2Loc)
    # S, O - flags
    # Z = (b | pl) == 0
    labelO = labelProvider.allocLabel("o")
    labelEnd = labelProvider.allocLabel("end")
    if op == 'lt' or op == 'le':
        # O != S => lt
        result += '''
            mov a, 0
            ldi pl, lo({0})
            ldi ph, hi({0})
            jno
            ldi pl, lo({1})
            ldi ph, hi({1})
            js ; O & S
            inc a
            jmp ; O & !S
        {0}:ldi pl, lo({1})
            ldi ph, hi({1})
            jns ; !O & !S
            inc a
            ; !O & S
        {1}:
        '''.format(labelO, labelEnd)
    elif op == 'ge' or op == 'gt':
        # O == S => ge
        result += '''
            mov a, 0
            ldi pl, lo({0})
            ldi ph, hi({0})
            jno
            ldi pl, lo({1})
            ldi ph, hi({1})
            jns ; O & !S
            inc a
            jmp ; O & S
        {0}:ldi pl, lo({1})
            ldi ph, hi({1})
            js ; !O & S
            inc a
            ; !O & S
        {1}:
        '''.format(labelO, labelEnd)
    if op == 'le':
        result += '''
            or a, b
            or a, pl
            dec a
            ldi a, 1
            sbb a, 0
        '''
    elif op == 'gt':
        result += '''
            mov ph, a
            mov a, pl
            or a, b
            dec a
            ldi a, 1
            sbb a, 0 ; a == 1 if !Z
            and a, ph
        '''
    result += '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        st a
    '''.format(rs)
    return resultLoc, result

def genCmp(resultLoc, src1Loc, src2Loc, op, labelProvider):
    assert(op in {"gt", "ge", "lt", "le"})
    resultLoc = resultLoc.withType(BoolType())
    assert(resultLoc.getIndirLevel() == 1)
    if src1Loc.getType() != src2Loc.getType():
        raise ValueError("Incompatible types: {} and {}".format(src1Loc.getType(), src2Loc.getType()))
    t = src1Loc.getType()
    assert(t.getSize() == 1 or t.getSize() == 2)
    if t.getSign():
        return _genCmpSigned(resultLoc, src1Loc, src2Loc, op, labelProvider)
    else:
        return _genCmpUnsigned(resultLoc, src1Loc, src2Loc, op)

def genAdd(resultLoc, src1Loc, src2Loc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(src1Loc.getType())
    if resultLoc.getType() != src1Loc.getType():
        raise ValueError("Incompatible result and source types: {} and {}".format(resultLoc.getType(), src1Loc.getType()))
    if src1Loc.getType().isPointer():
        return _genAddPtr(resultLoc, src1Loc, src2Loc)
    else:
        return _genIntBinary(resultLoc, src1Loc, src2Loc, "add", "adc", "({}) + ({})", operator.add)

def genMulConst(resultLoc, srcLoc, m):
    resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise ValueError("Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    return resultLoc, "{} = {} * {}\n".format(resultLoc, srcLoc, m)
