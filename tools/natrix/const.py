import re
import operator
from lark import Lark, Transformer, v_args, Tree
from value import Value
from type import IntType
from location import Location
from literal import unescapeString
import exceptions

def signExpand(t, value):
    if t.getSign():
        bits = t.getSize() * 8
        sign = bool(value & (1 << (bits - 1)))
        if sign:
            mask = ~(~0 << bits)
            return -((~value + 1) & mask)
        else:
            return value
    else:
        return value

def _const(location, t, value):
    mask = ~(~0 << (t.getSize() * 8))
    return Value(location, t, 0, int(value) & mask, True)

def sameTypeChecker(a, b):
    return a.getType() == b.getType()

def shiftTypeChecker(a, b):
    return b.getType().isInteger()

def binary(tree, op, overrideType=None, typeChecker=sameTypeChecker):
    a, b = tree.children
    if isinstance(a, Tree) or isinstance(b, Tree):
        return tree
    else:
        # not checking levels and sources because only constants are possible now
        if typeChecker(a, b):
            newType = a.getType()
            if overrideType is not None:
                newType = overrideType
            sa = signExpand(a.getType(), a.getSource())
            sb = signExpand(b.getType(), b.getSource())
            return _const(Location.fromAny(tree), newType, op(sa, sb))
        else:
            raise exceptions.SemanticError(Location.fromAny(tree), "Incompatible types in an expression")

def unary(tree, op):
    a = tree.children[0]
    if isinstance(a, Tree):
        return tree
    else:
        sa = signExpand(a.getType(), a.getSource())
        return _const(Location.fromAny(tree), a.getType(), op(sa))

def cast(v, oldType, newType):
    if oldType.getSize() < newType.getSize() and oldType.getSign():
        bits = oldType.getSize() * 8
        sign = bool(v & (1 << (bits - 1)))
        if sign:
            newBits = newType.getSize() * 8
            hi = ~(~0 << (newBits - bits)) << bits
            return hi | v
    return v

def _parseTypeSuffix(s):
    if s is None:
        return IntType(True, 2)
    sign = s[0].lower() == 's'
    s = s[1:]
    if len(s) > 0:
        width = int(s) // 8
    else:
        width = 2
    return IntType(sign, width)

@v_args(tree = True)
class ConstTransformer(Transformer):
    def __init__(self, transformCasts):
        self._transformCast = transformCasts
        self._intRe = dict()
        self._intRe[10] = re.compile(r"([+-]?[1-9]\d*)([su](?:8|16)?)?", re.I)
        self._intRe[16] = re.compile(r"0x([0-9a-f]+)([su](?:8|16)?)?", re.I)
        self._intRe[8] = re.compile(r"0([0-7]*)([su](?:8|16)?)?", re.I)
        self._intRe[2] = re.compile(r"0b([01]+)([su](?:8|16)?)?", re.I)

    def _constFromLiteral(self, t, base):
        value = str(t.children[0])
        m = self._intRe[base].match(value)
        n = int(m.group(1) if len(m.group(1)) > 0 else '0', base)
        suffix = m.group(2)
        return _const(Location.fromAny(t), _parseTypeSuffix(suffix), n)

    def n10(self, t):
        return self._constFromLiteral(t, 10)

    def n16(self, t):
        return self._constFromLiteral(t, 16)

    def n8(self, t):
        return self._constFromLiteral(t, 8)

    def n2(self, t):
        return self._constFromLiteral(t, 2)

    def char(self, t):
        l = Location.fromAny(t)
        try:
            value = str(t.children[0])
            return _const(l, IntType(False, 1), ord(unescapeString(value, "'", False)[0]))
        except ValueError as e:
            raise exceptions.LiteralError(l, str(e))

    def add(self, tree):
        return binary(tree, operator.add)

    def sub(self, tree):
        return binary(tree, operator.sub)

    def mul(self, tree):
        return binary(tree, operator.mul)

    def div(self, tree):
        return binary(tree, operator.floordiv)

    def shl(self, tree):
        return binary(tree, operator.lshift, typeChecker=shiftTypeChecker)

    def shr(self, tree):
        return binary(tree, operator.rshift, typeChecker=shiftTypeChecker)

    def neg(self, tree):
        return unary(tree, operator.neg)

    def lnot(self, tree):
        a = tree.children[0]
        if isinstance(a, Tree):
            return tree
        else:
            return _const(Location.fromAny(tree), IntType(False, 1), 1 if a == 0 else 0)

    def lor(self, tree):
        a, b = tree.children
        if isinstance(a, Tree) or isinstance(b, Tree):
            return tree
        else:
            return _const(Location.fromAny(tree), IntType(False, 1), 1 if bool(a.getSource()) or bool(b.getSource()) else 0)

    def land(self, tree):
        a, b = tree.children
        if isinstance(a, Tree) or isinstance(b, Tree):
            return tree
        else:
            return _const(Location.fromAny(tree), IntType(False, 1), 1 if bool(a.getSource()) and bool(b.getSource()) else 0)

    def bnot(self, tree):
        return unary(tree, operator.invert)

    def band(self, tree):
        return binary(tree, operator.and_)

    def bor(self, tree):
        return binary(tree, operator.or_)

    def bxor(self, tree):
        return binary(tree, operator.xor)

    def lt(self, tree):
        return binary(tree, operator.lt, IntType(False, 1))

    def le(self, tree):
        return binary(tree, operator.le, IntType(False, 1))

    def gt(self, tree):
        return binary(tree, operator.gt, IntType(False, 1))

    def ge(self, tree):
        return binary(tree, operator.ge, IntType(False, 1))

    def eq(self, tree):
        return binary(tree, operator.eq, IntType(False, 1))

    def ne(self, tree):
        return binary(tree, operator.ne, IntType(False, 1))

    def type_cast(self, tree):
        if not self._transformCast:
            return tree
        t, v = tree.children
        if isinstance(v, Tree):
            return tree
        return _const(Location.fromAny(tree), t, cast(v.getSource(), v.getType(), t))
