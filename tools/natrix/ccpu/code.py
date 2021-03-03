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

MAX_INT_SIZE = 4

def startCodeSection():
    return startSection("text")

def startBssSection():
    return startSection("bss")

def startSection(name, alignment=1):
    if alignment > 1:
        return f'''
            .section {name}
            .align {alignment}
        '''
    else:
        return f'''
            .section {name}
        '''

def dumpExports(exports):
    return "".join(".export {}\n".format(s) for s in exports)

def dumpImports(imports):
    return "".join(".global {}\n".format(s) for s in imports) + _dumpRuntimeImports()

def _dumpRuntimeImports():
    return """
    .global __cc_r_sp
    .global __cc_asl
    .global __cc_asl_dword
    .global __cc_asr
    .global __cc_lsr_dword
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
    result = '; ====== literals: ===========\n'
    for label,t,v,section in lp.getLiterals():
        result += f".section {section}\n"
        size = t.getSize()
        if size == 2:
            result += '.align 2\n'
        result += '{}:\n'.format(label)
        # a literal can't be empty
        result += '{} {}\n'.format("db" if size == 1 else "dw", ", ".join(str(x) for x in v))
    result += '; ====== end literals =======\n'
    return result

def reserve(label, size):
    alignment = min(size, MAX_INT_SIZE)
    while not isPowerOfTwo(alignment):
        alignment += 1
    return f"""
        .align {alignment}
        {label}: res {size}
    """

def reserveBlock(label, vs):
    """
    Reserve several integer variables keeping them aligned to the size of the largest one and continous in memory.
    """
    maxSize = min(max(size for _,size in vs), MAX_INT_SIZE)
    if not isPowerOfTwo(maxSize):
        maxSize = MAX_INT_SIZE
    result = f'''
        .align {maxSize}
        {label}:
    '''
    offset = 0
    for label, size in vs:
        alignSize = min(size, MAX_INT_SIZE)
        mod = offset % alignSize
        if mod != 0:
            result += f'res {alignSize - mod}\n'
            offset += alignSize - mod
        result += f'{label}: res {size}\n'
        offset = (offset + size) % maxSize
    return result

def reserveGlobalVars(vs, imports):
    result = '; global vars:\n'
    for v in vs:
        if v not in imports:
            result += reserve(v, vs[v].getReserveSize())
    return result

def reserveTempVars(maxIndex):
    return "".join(reserve(labelname.getTempName(i), MAX_INT_SIZE) for i in range(maxIndex + 1))

def reserveVar(label, type):
    return reserve(label, type.getReserveSize())

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

def _loadConst(size, value, offset=0):
    # load const into a:b
    if isinstance(value, int):
        value = (value >> (offset * 8)) & 0xffff
        result = 'ldi b, {}\n'.format(lo(value))
        if size > 1:
            h = hi(value)
            if h == 0:
                result += 'mov a, 0\n'
            else:
                result += 'ldi a, {}\n'.format(h)
    else:
        if offset != 0:
            RuntimeError("WTF? Labels are 16 bits max.")
        result = f'ldi b, lo({value})\n'
        if size > 1:
            result += f'ldi a, hi({value})\n'
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
                result = f"; {resultLoc} := {srcLoc} (large)\n"
                if srcLoc.getIndirLevel() == 0:
                    for offset in range(0, size, 2):
                        chunkSize = min(2, size - offset)
                        result += _loadConst(chunkSize, srcLoc.getSource(), offset)
                        result += f"""
                            ldi pl, lo({resultLoc.getSource()} + {offset})
                            ldi ph, hi({resultLoc.getSource()} + {offset})
                            st b
                        """
                        if chunkSize > 1:
                            if resultLoc.isAligned():
                                result += 'inc pl\n'
                            else:
                                result += f'''
                                    ldi pl, lo({resultLoc.getSource()} + {offset + 1})
                                    ldi ph, hi({resultLoc.getSource()} + {offset + 1})
                                '''
                            result += 'st a\n'
                    return resultLoc, result
                else:
                    # TODO loop on large objects
                    for offset in range(0, size, 2):
                        chunkSize = min(2, size - offset)
                        result += f'''
                            ldi pl, lo(({srcLoc.getSource()}) + {offset})
                            ldi ph, hi(({srcLoc.getSource()}) + {offset})
                            ld a
                        '''
                        if chunkSize > 1:
                            if srcLoc.isAligned():
                                result += f'''
                                    inc pl
                                '''
                            else:
                                result += f'''
                                    ldi pl, lo(({srcLoc.getSource()}) + {offset + 1})
                                    ldi ph, hi(({srcLoc.getSource()}) + {offset + 1})
                                '''
                            result += f'''
                                ld b
                                ldi pl, lo(({resultLoc.getSource()}) + {offset + 1})
                                ldi ph, hi(({resultLoc.getSource()}) + {offset + 1})
                                st b
                            '''

                            if resultLoc.isAligned():
                                result += '''
                                    dec pl
                                '''
                            else:
                                result += f'''
                                    ldi pl, lo(({resultLoc.getSource()}) + {offset})
                                    ldi ph, hi(({resultLoc.getSource()}) + {offset})
                                '''
                        else:
                            result += f'''
                                ldi pl, lo(({resultLoc.getSource()}) + {offset})
                                ldi ph, hi(({resultLoc.getSource()}) + {offset})
                            '''
                        result += '''
                            st a
                        '''
                    return resultLoc, result

def genCast(resultLoc, t, srcLoc):
    resultLoc = resultLoc.withType(t)
    if resultLoc == srcLoc:
        return resultLoc, ""
    if resultLoc.getIndirLevel() != 1:
        raise RuntimeError("Compiler error: move destination level of indirection is not 1")
    result = '; cast {} := {}\n'.format(resultLoc, srcLoc)
    if srcLoc.getIndirLevel() == 1 and srcLoc.getSource() == resultLoc.getSource():
        # cast into itself
        srcSize = srcLoc.getType().getSize()
        resultSize = resultLoc.getType().getSize()
        if resultSize > srcSize:
            # widen
            if srcLoc.getType().getSign():
                # sign expand
                code = f'''
                    ; widening cast, sign expand
                    ldi pl, lo({srcLoc.getSource()} + {srcSize - 1})
                    ldi ph, hi({srcLoc.getSource()} + {srcSize - 1})
                    ld a
                    shl a
                    exp a
                '''
                for offset in range(srcSize, resultSize):
                    if resultLoc.isAligned():
                        code += 'inc pl\n'
                    else:
                        code += f'''
                            ldi pl, lo({srcLoc.getSource()} + {offset})
                            ldi ph, hi({srcLoc.getSource()} + {offset})
                        '''
                    code += 'st a\n'
                return resultLoc, result + code
            else:
                # zero expand
                result += f'''
                    ; widening cast, zero expand
                    ldi pl, lo({srcLoc.getSource()} + {srcSize})
                    ldi ph, hi({srcLoc.getSource()} + {srcSize})
                    mov a, 0
                    st a
                '''
                for offset in range(srcSize + 1, resultSize):
                    if resultLoc.isAligned():
                        result += '''
                            inc pl
                            st a
                        '''
                    else:
                        result += f'''
                            ldi pl, lo({resultLoc.getSource()} + {offset})
                            ldi ph, hi({resultLoc.getSource()} + {offset})
                            st a
                        '''
                return resultLoc, result
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
        srcSize = srcLoc.getType().getSize()
        resultSize = resultLoc.getType().getSize()
        if resultSize > srcSize:
            # widen
            result += '''
                ; widening cast
            '''
            for offset in range(srcSize):
                # copy the low part
                result += f'''
                    ldi pl, lo({srcLoc.getSource()} + {offset})
                    ldi ph, hi({srcLoc.getSource()} + {offset})
                    ld a
                    ldi pl, lo({resultLoc.getSource()} + {offset})
                    ldi ph, hi({resultLoc.getSource()} + {offset})
                    st a
                '''
            if srcLoc.getType().getSign():
                # sign expand
                # a contains MSB of src
                result += '''
                    ; sign expand
                    shl a
                    exp a
                '''
            else:
                result += '''
                    ; zero expand
                    mov a, 0
                '''
            for offset in range(srcSize, resultSize):
                if resultLoc.isAligned():
                    result += 'inc pl\n'
                else:
                    if srcLoc.getType().getSign():
                        result += f'''
                            ldi pl, lo({resultLoc.getSource()} + {offset})
                            ldi ph, hi({resultLoc.getSource()} + {offset})
                        '''
                    else:
                        # a is 0
                        result += '''
                            inc pl
                            adc ph, a
                        '''
                result += 'st a\n'
            return resultLoc, result
        else:
            # same size or narrower
            return srcLoc.withType(resultLoc.getType()), ""

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

def genPutIndirect(resultAddrLoc, srcLoc, offset=0):
    if srcLoc.getType().isUnknown():
        raise SemanticError(srcLoc.getLocation(), "Unknown source type")
    if resultAddrLoc.getType().isUnknown():
        resultAddrLoc = resultAddrLoc.removeUnknown(srcLoc.getType())
    if resultAddrLoc.getType().deref() != srcLoc.getType():
        raise SemanticError(resultAddrLoc.getLocation() - srcLoc.getLocation(),
            "Incompatible types for put indirect: {} and {}".format(resultAddrLoc.getType().deref(), srcLoc.getType()))
    t = srcLoc.getType()
    result = "; *({} + {}) = {}\n".format(resultAddrLoc, offset, srcLoc)
    s = srcLoc.getSource()
    rs = resultAddrLoc.getSource()
    if t.getSize() <= 2:
        isWord = t.getSize() == 2
        if not isWord:
            result += _loadAB(srcLoc) # only b is used
            result += loadP(resultAddrLoc, offset) # a is overwritten
            result += 'st b\n'
        else:
            result += loadByte('b', srcLoc, 0)
            result += loadP(resultAddrLoc, offset)
            result += 'st b\n'
            result += loadByte('b', srcLoc, 1)
            result += loadP(resultAddrLoc, offset + 1)
            result += 'st b\n'
    else:
        for byte_offset in reversed(range(t.getSize())):
            result += loadByte('b', srcLoc, offset + byte_offset)
            result += loadP(resultAddrLoc, offset + byte_offset)
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
