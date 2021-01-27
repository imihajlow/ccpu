from value import Value
from type import BoolType
import operator
import labelname
from exceptions import SemanticError

def genDeref(resultLoc, srcLoc, offset=0):
    if resultLoc.getType().isUnknown():
        resultLoc = resultLoc.removeUnknown(srcLoc.getType().deref())
    if srcLoc.getType().deref() != resultLoc.getType() and not srcLoc.getType().deref().isStruct():
        raise SemanticError(srcLoc.getLocation(),
            "Incompatible types for deref: {} and {}".format(srcLoc.getType().deref(), resultLoc.getType()))
    assert(srcLoc.getIndirLevel() <= 1)

    t = resultLoc.getType()
    assert(0 < t.getSize() <= 2)

    if srcLoc.getIndirLevel() == 0:
        return Value.withOffset(srcLoc.getLocation(), resultLoc.getType(), 1, srcLoc.getSource(), True, offset), ""

    result = '; {} = deref {} + {}\n'.format(resultLoc, srcLoc, offset)
    result += '; result is {}aligned, srcLoc is {}aligned'.format("" if resultLoc.isAligned() else "not ", "" if srcLoc.isAligned() else "not ")
    if offset == 0:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld a
            ldi pl, lo({0} + 1)
            ldi ph, hi({0} + 1)
            ld ph
            mov pl, a
        '''.format(srcLoc.getSource()) # TODO optimize aligned
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld a
            ldi b, lo({1})
            add b, a
            ldi pl, lo({0} + 1)
            ldi ph, hi({0} + 1)
            ld a
            ldi ph, hi({1})
            adc ph, a
            mov a, b
            mov pl, a
        '''.format(srcLoc.getSource(), offset)
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
        raise SemanticError(srcLoc.getLocation(), "Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    assert(resultLoc.getIndirLevel() == 1)
    assert(srcLoc.getIndirLevel() == 1 or srcLoc.getIndirLevel() == 0)
    t = srcLoc.getType()
    result = '; {} = ~{}\n'.format(resultLoc, srcLoc)
    if srcLoc.getIndirLevel() == 0:
        # constant
        c = srcLoc.getSource()
        if isinstance(c, int):
            c = ~c
        else:
            c = '~({})'.format(c) # Warning
        return Value(srcLoc.getLocation(), t, 0, c, True), result
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
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
                ld a
                not a
            '''.format(srcLoc.getSource()) # TODO optimize aligned
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
        raise SemanticError(srcLoc.getLocation(), "Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    if srcLoc.getType().getSize() != 1 or srcLoc.getType().getSign():
        raise SemanticError(srcLoc.getLocation(), "Argument for `!' should be of type u8")
    assert(resultLoc.getIndirLevel() == 1)
    assert(srcLoc.getIndirLevel() == 1 or srcLoc.getIndirLevel() == 0)

    result = '; {} = !{}\n'.format(resultLoc, srcLoc)
    if srcLoc.getIndirLevel() == 0:
        # constant
        c = srcLoc.getSource()
        if isinstance(c, int):
            c = int(not bool(c))
        else:
            c = 'int(not bool({}))'.format(c) # Warning
        return Value(srcLoc.getLocation(), BoolType(), 0, c, True), result
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
        raise SemanticError(srcLoc.getLocation(), "Incompatible types: {} and {}".format(resultLoc.getType(), srcLoc.getType()))
    if not srcLoc.getType().getSign():
        raise SemanticError(srcLoc.getLocation(), "Argument for unary `-' should be of a signed type")
    assert(resultLoc.getIndirLevel() == 1)
    assert(srcLoc.getIndirLevel() == 1 or srcLoc.getIndirLevel() == 0)

    t = srcLoc.getType()
    result = '; {} = -{}\n'.format(resultLoc, srcLoc)
    if srcLoc.getIndirLevel() == 0:
        # constant
        c = srcLoc.getSource()
        if isinstance(c, int):
            c = -c & (0xff if t.getSize() == 1 else 0xffff)
        else:
            c = '-({})'.format(c) # Warning
        return Value(srcLoc.getLocation(), t, 0, c, True), result
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
