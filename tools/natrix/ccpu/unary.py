from value import Value
from type import BoolType
from .common import *
import operator
import labelname
from exceptions import SemanticError, NatrixNotImplementedError

def genDeref(resultLoc, srcLoc, offset=0):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType().deref())
    if srcLoc.getType().deref() != resultLoc.getType() and not srcLoc.getType().deref().isStruct():
        raise SemanticError(srcLoc.getPosition(),
            "Incompatible types for deref: {} and {}".format(srcLoc.getType().deref(), resultLoc.getType()))
    assert(srcLoc.getIndirLevel() <= 1)

    t = resultLoc.getType()

    if srcLoc.getIndirLevel() == 0:
        return Value.withOffset(srcLoc.getPosition(), resultLoc.getType(), 1, srcLoc.getSource(), True, offset), ""

    result = '; {} = deref {} + {}\n'.format(resultLoc, srcLoc, offset)
    result += '; result is {}aligned, srcLoc is {}aligned'.format("" if resultLoc.isAligned() else "not ", "" if srcLoc.isAligned() else "not ")
    rs = resultLoc.getSource()
    for byteOffset in reversed(range(0, t.getSize(), 2)):
        rest = min(2, t.getSize() - byteOffset)
        result += loadP(srcLoc, byteOffset + offset)
        result += 'ld b\n'
        if rest > 1:
            result += '''
                mov a, 0
                inc pl
                adc ph, a
                ld a
            '''
        result += f'''
            ldi pl, lo({rs} + {byteOffset})
            ldi ph, hi({rs} + {byteOffset})
            st b
        '''
        if rest > 1:
            if resultLoc.isAligned():
                result += '''
                    inc pl
                    st a
                '''
            else:
                result += f'''
                    ldi pl, lo({rs} + {byteOffset + 1})
                    ldi ph, hi({rs} + {byteOffset + 1})
                    st a
                '''
    return resultLoc, result

def genUnary(op, resultLoc, srcLoc):
    if srcLoc.getType().isUnknown():
        raise RuntimeError("Unknown source type")
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

# TODO if resultLoc == srcLoc for unary
def genBNot(resultLoc, srcLoc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise SemanticError(srcLoc.getPosition(), "Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    assert(resultLoc.getIndirLevel() == 1)
    assert(srcLoc.getIndirLevel() == 1 or srcLoc.getIndirLevel() == 0)
    t = srcLoc.getType()
    result = '; {} = ~{}\n'.format(resultLoc, srcLoc)
    if srcLoc.getIndirLevel() == 0:
        # constant
        c = srcLoc.getSource()
        c = ~c
        return Value(srcLoc.getPosition(), t, 0, c, True), result
    # var
    s = srcLoc.getSource()
    rs = resultLoc.getSource()
    for offset in range(0, t.getSize(), 2):
        rest = t.getSize() - offset
        result += f'''
            ldi pl, lo({s} + {offset})
            ldi ph, hi({s} + {offset})
            ld b
        '''
        if rest > 1:
            result += incP(srcLoc.isAligned())
            result += 'ld a\n'
        result += f'''
            ldi pl, lo({rs} + {offset})
            ldi ph, hi({rs} + {offset})
            not b
            st b
        '''
        if rest > 1:
            if resultLoc.isAligned:
                result += '''
                    inc pl
                    not a
                    st a
                '''
            else:
                result += '''
                    mov b, a
                    inc pl
                    mov a, 0
                    adc ph, a
                    not b
                    st b
                '''
    return resultLoc, result

def genLNot(resultLoc, srcLoc):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType())
    if resultLoc.getType() != srcLoc.getType():
        raise SemanticError(srcLoc.getPosition(), "Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    if srcLoc.getType().getSize() != 1 or srcLoc.getType().getSign():
        raise SemanticError(srcLoc.getPosition(), "Argument for `!' should be of type u8")
    assert(resultLoc.getIndirLevel() == 1)
    assert(srcLoc.getIndirLevel() == 1 or srcLoc.getIndirLevel() == 0)

    result = '; {} = !{}\n'.format(resultLoc, srcLoc)
    if srcLoc.getIndirLevel() == 0:
        # constant
        c = srcLoc.getSource()
        if c.isNumber():
            c = int(not bool(c))
        else:
            c = 'int(not bool({}))'.format(c) # Warning
        return Value(srcLoc.getPosition(), BoolType(), 0, c, True), result
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
        raise SemanticError(srcLoc.getPosition(), "Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    if not srcLoc.getType().getSign():
        raise SemanticError(srcLoc.getPosition(), "Argument for unary `-' should be of a signed type")
    assert(resultLoc.getIndirLevel() == 1)
    assert(srcLoc.getIndirLevel() == 1 or srcLoc.getIndirLevel() == 0)

    t = srcLoc.getType()
    if t.getSize() > 2:
        raise NatrixNotImplementedError(srcLoc.getPosition(), "Negation of ints wider than s16 is not implemented")
    result = '; {} = -{}\n'.format(resultLoc, srcLoc)
    if srcLoc.getIndirLevel() == 0:
        # constant
        c = srcLoc.getSource()
        if c.isNumber():
            c = -int(c) & (0xff if t.getSize() == 1 else 0xffff)
        else:
            c = '-({})'.format(c) # Warning
        return Value(srcLoc.getPosition(), t, 0, c, True), result
    else:
        # var
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld b
        '''.format(srcLoc.getSource())

        if t.getSize() > 1:
            result += '''
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                ld a
                not a
                not b
                inc b
                adc a, 0
            '''.format(srcLoc.getSource())
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
