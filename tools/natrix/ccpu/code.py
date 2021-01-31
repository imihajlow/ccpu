from value import Value
from type import BoolType
import operator
import labelname
from .compare import *
from .binary import *
from .unary import *
from .shift import *
from .common import *
from .stack import *
from exceptions import SemanticError

def startCodeSection():
    return ".section text\n"

def startBssSection():
    return '''
        .section bss
        .align 2
    '''

def dumpExports(exports):
    return "".join(".export {}\n".format(s) for s in exports)

def dumpImports(imports):
    return "".join(".global {}\n".format(s) for s in imports) + _dumpRuntimeImports()

def _dumpRuntimeImports():
    return """
    .global __cc_r_sp
    .global __cc_asl
    .global __cc_asr
    .global __cc_lsr
    .global __cc_sh_val
    .global __cc_sh_count
    .global __cc_push
    .global __cc_pop
    .global __cc_from
    .global __cc_to
    .global __cc_mul_word
    .global __cc_mul_byte
    .global __cc_div_word
    .global __cc_div_byte
    .global __cc_udiv_word
    .global __cc_udiv_byte
    .global __cc_r_r
    .global __cc_r_a
    .global __cc_r_b
    .global __cc_r_quotient
    .global __cc_r_remainder
    """

def dumpLiterals(lp):
    result = '; literals:\n'
    for label,t,v in lp.getLiterals():
        size = t.getSize()
        if size == 2:
            result += '.align 2\n'
        result += '{}:\n'.format(label)
        # a literal can't be empty
        result += '{} {}\n'.format("db" if size == 1 else "dw", ", ".join(str(x) for x in v))
    return result

def reserve(label, size):
    return "{}: res {}\n".format(label, max(2, size))

def reserveGlobalVars(vs, imports):
    result = '; global vars:\n'
    for v in vs:
        if v not in imports:
            result += '{}: res {}\n'.format(v, align(vs[v].getReserveSize(), 2))
    return result

def reserveTempVars(maxIndex):
    return "".join(reserve(labelname.getTempName(i), 2) for i in range(maxIndex + 1))

def reserveVar(label, type):
    rs = align(type.getReserveSize(), 2)
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
        '''.format(labelname.getReturnAddressLabel(fn))

def genCall(fn):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jmp
        '''.format(fn)

def genPushLocals(fn):
    return "; push frame of {}\n".format(fn) + genPush(labelname.getReserveBeginLabel(fn), labelname.getReserveEndLabel(fn))

def genPopLocals(fn):
    return "; pop frame of {}\n".format(fn) + genPop(labelname.getReserveBeginLabel(fn), labelname.getReserveEndLabel(fn))

def _loadConst(size, value):
    # load const into a:b
    if isinstance(value, int):
        result = 'ldi b, {}\n'.format(lo(value))
        if size > 1:
            h = hi(value)
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
        raise SemanticError(srcLoc.getLocation(), "Unknown source type")
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise SemanticError(resultLoc.getLocation() - srcLoc.getLocation(),
            "Incompatible types to assign: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    if srcLoc == resultLoc:
        return resultLoc, ""
    else:
        if avoidCopy:
            return srcLoc, ""
        else:
            if resultLoc.getIndirLevel() != 1:
                raise RuntimeError("Compiler error: move destination level of indirection is not 1")
            size = srcLoc.getType().getSize()
            if size <= 2:
                loadCode = "; {} := {}\n".format(resultLoc, srcLoc)
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
                        loadCode += 'inc pl\n'
                        if not srcLoc.isAligned():
                            loadCode += '''
                                mov a, 0
                                adc ph, a
                            '''.format(srcLoc.getSource())
                        loadCode += 'ld a\n'
                storeCode = '''
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    st b
                    '''.format(resultLoc.getSource())
                if size > 1:
                    if resultLoc.isAligned():
                        storeCode += 'inc pl\n'
                    else:
                        storeCode += '''
                            ldi pl, lo({0} + 1)
                            ldi ph, hi({0} + 1)
                            '''.format(resultLoc.getSource())
                    storeCode += 'st a\n'
                return resultLoc, loadCode + storeCode
            else:
                if srcLoc.getIndirLevel() == 0:
                    raise RuntimeError("struct const")
                result = ""
                for offset in range(size):
                    result += f'''
                        ldi pl, lo(({srcLoc.getSource()}) + {offset})
                        ldi ph, hi(({srcLoc.getSource()}) + {offset})
                        ld a
                        ldi pl, lo(({resultLoc.getSource()}) + {offset})
                        ldi ph, hi(({resultLoc.getSource()}) + {offset})
                        st a
                    '''
                return resultLoc, result

def genCast(resultLoc, t, srcLoc):
    resultLoc = resultLoc.withType(t)
    if resultLoc == srcLoc:
        return resultLoc, ""
    if resultLoc.getIndirLevel() != 1:
        raise RuntimeError("Compiler error: move destination level of indirection is not 1")
    assert(resultLoc.getType().getSize() == 1 or resultLoc.getType().getSize() == 2)
    assert(srcLoc.getType().getSize() == 1 or srcLoc.getType().getSize() == 2)
    result = '; cast {} := {}\n'.format(resultLoc, srcLoc)
    if srcLoc.getIndirLevel() == 1 and srcLoc.getSource() == resultLoc.getSource():
        # cast into itself
        if resultLoc.getType().getSize() > srcLoc.getType().getSize():
            # widen
            if srcLoc.getType().getSign():
                # sign expand
                code = '''
                    ; widening cast, sign expand
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld a
                    shl a
                    exp a
                '''.format(srcLoc.getSource())
                if resultLoc.isAligned():
                    code += 'inc pl\n'
                else:
                    code += '''
                        ldi pl, lo({0} + 1)
                        ldi ph, hi({0} + 1)
                    '''.format(srcLoc.getSource())
                code += 'st a\n'
                return resultLoc, result + code
            else:
                # zero expand
                return resultLoc, result + '''
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
                return genMove(resultLoc, Value(srcLoc.getLocation(), t, 0, signExpandByte(srcLoc.getSource())), True)
            else:
                return genMove(resultLoc, srcLoc.withType(t), True)
        if resultLoc.getType().getSize() > srcLoc.getType().getSize():
            # widen a byte
            if srcLoc.getType().getSign():
                # sign expand
                result += '''
                    ; widening cast, sign expand
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld a
                    ldi pl, lo({1})
                    ldi ph, hi({1})
                    st a
                    shl a
                    exp a
                    '''.format(srcLoc.getSource(), resultLoc.getSource())

                if resultLoc.isAligned():
                    result += 'inc pl\n'
                else:
                    result += '''
                        ldi pl, lo({0} + 1)
                        ldi ph, hi({0} + 1)
                    '''.format(resultLoc.getSource())
                result += 'st a\n'
            else:
                # zero expand
                result += '''
                    ; widening cast, zero expand
                    ldi pl, lo({0})
                    ldi ph, hi({0})
                    ld a
                    ldi pl, lo({1})
                    ldi ph, hi({1})
                    st a
                    mov a, 0
                    inc pl
                '''.format(srcLoc.getSource(), resultLoc.getSource())
                if not resultLoc.isAligned():
                    result += 'adc ph, a\n'
                result += 'st a\n'
            return resultLoc, result
        else:
            # same size or narrower
            return srcLoc.withType(resultLoc.getType()), ""

def _loadP(loc, offset=0):
    result = ''
    if loc.getIndirLevel() == 0:
        result += '''
            ldi pl, lo({0} + {1})
            ldi ph, hi({0} + {1})
        '''.format(loc.getSource(), offset)
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld a
        '''.format(loc.getSource())
        if loc.isAligned():
            result += 'inc pl\n'
        else:
            result += '''
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
            '''.format(loc.getSource())
        result += '''
            ld ph
            mov pl, a
        '''
        if offset != 0:
            l = lo(offset)
            h = hi(offset)
            result += '''
                ldi a, {}
                add pl, a
            '''.format(l)
            if h == 0:
                result += 'mov a, 0\n'
            else:
                result += 'ldi a, {}\n'.format(h)
            result += 'adc ph, a\n'
    return result

def _loadAB(loc):
    result = ''
    isWord = loc.getType().getSize() == 2
    if loc.getIndirLevel() == 0:
        result += 'ldi b, lo({})\n'.format(loc.getSource())
        if isWord:
            result += 'ldi a, hi({})\n'.format(loc.getSource())
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
        '''.format(loc.getSource())
        if isWord:
            result += 'inc pl\n'
            if not loc.isAligned():
                result += '''
                    mov a, 0
                    adc ph, a
                '''
            result += 'ld a\n'
    return result

def _loadBLow(loc):
    result = ''
    if loc.getIndirLevel() == 0:
        result += 'ldi b, lo({})\n'.format(loc.getSource())
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
        '''.format(loc.getSource())
    return result

def _loadBHi(loc):
    result = ''
    if loc.getIndirLevel() == 0:
        result += 'ldi b, hi({})\n'.format(loc.getSource())
    else:
        result += '''
            ldi pl, lo({0} + 1)
            ldi ph, hi({0} + 1)
            ld b
        '''.format(loc.getSource())
    return result

def genPutIndirect(resultAddrLoc, srcLoc, offset=0):
    if srcLoc.getType().isUnknown():
        raise SemanticError(srcLoc.getLocation(), "Unknown source type")
    if resultAddrLoc.getType().isUnknown():
        resultAddrLoc = resultAddrLoc.removeUnknown(srcLoc.getType())
    if resultAddrLoc.getType().deref() != srcLoc.getType():
        raise SemanticError(resultAddrLoc.getLocation() - srcLoc.getLocation(),
            "Incompatible types for put indirect: {} and {}".format(resultAddrLoc.getType().deref(), srcLoc.getType()))
    t = srcLoc.getType()
    isWord = t.getSize() == 2
    s = srcLoc.getSource()
    rs = resultAddrLoc.getSource()
    result = "; *({} + {}) = {}\n".format(resultAddrLoc, offset, srcLoc)
    if not isWord:
        result += _loadAB(srcLoc) # only b is used
        result += _loadP(resultAddrLoc, offset) # a is overwritten
        result += 'st b\n'
    else:
        result += _loadBLow(srcLoc)
        result += _loadP(resultAddrLoc, offset)
        result += 'st b\n'
        result += _loadBHi(srcLoc)
        result += _loadP(resultAddrLoc, offset + 1)
        result += 'st b\n'
    return result

def genInvCondJump(condLoc, label):
    '''
    Jump if condLoc is 0
    '''
    if condLoc.getType() != BoolType():
        raise SemanticError(condLoc.getLocation(), "Should be a bool type (u8) for a condition, got {}".format(str(condLoc.getType())))
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
