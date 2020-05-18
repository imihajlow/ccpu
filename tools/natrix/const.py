import operator
from lark import Lark, Transformer, v_args, Tree
from value import Value
from type import IntType
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

def const(t, value):
    mask = ~(~0 << (t.getSize() * 8))
    return Value(t, 0, int(value) & mask)

def binary(tree, op, overrideType=None):
    a, b = tree.children
    if isinstance(a, Tree) or isinstance(b, Tree):
        return tree
    else:
        # not checking levels and sources because only constants are possible now
        if a.getType() == b.getType():
            newType = a.getType()
            if overrideType is not None:
                newType = overrideType
            sa = signExpand(a.getType(), a.getSource())
            sb = signExpand(b.getType(), b.getSource())
            return const(newType, op(sa, sb))
        else:
            raise exceptions.SemanticError("input", tree.line, "Incompatible types in an expression")

def unary(tree, op):
    a = tree.children[0]
    if isinstance(a, Tree):
        return tree
    else:
        sa = signExpand(a.getType(), a.getSource())
        return const(a.t, op(sa))

def cast(v, oldType, newType):
    if oldType.getSize() < newType.getSize() and newType.getSign():
        bits = oldType.getSize() * 8
        sign = bool(value & (1 << (bits - 1)))
        if sign:
            newBits = newType.getSize() * 8
            hi = ~(~0 << (newBits - bits)) << bits
            return hi | v
    return v


@v_args(tree = True)
class ConstTransformer(Transformer):
    def __init__(self, transformCasts):
        self._transformCast = transformCasts

    @v_args(inline = True, meta = True, tree = False)
    def n10(self, meta, value):
        return const(IntType(True, 2), int(value, 10))

    @v_args(inline = True, meta = True, tree = False)
    def n16(self, meta, value):
        return const(IntType(True, 2), int(value, 0))

    @v_args(inline = True, meta = True, tree = False)
    def n8(self, meta, value):
        return const(IntType(True, 2), int(value, 8))

    @v_args(inline = True, meta = True, tree = False)
    def n2(self, meta, value):
        return const(IntType(True, 2), int(value[2:], 2))

    def add(self, tree):
        return binary(tree, operator.add)

    def sub(self, tree):
        return binary(tree, operator.sub)

    def mul(self, tree):
        return binary(tree, operator.mul)

    def div(self, tree):
        return binary(tree, operator.floordiv)

    def shl(self, tree):
        return binary(tree, operator.lshift)

    def shr(self, tree):
        return binary(tree, operator.rshift)

    def neg(self, tree):
        return unary(tree, operator.neg)

    def lnot(self, tree):
        a = tree.children[0]
        if isinstance(a, Tree):
            return tree
        else:
            return const(IntType(False, 1), 1 if a == 0 else 0)

    def lor(self, tree):
        a, b = tree.children
        if isinstance(a, Tree) or isinstance(b, Tree):
            return tree
        else:
            return const(IntType(False, 1), 1 if bool(a.getSource()) or bool(b.getSource()) else 0)

    def land(self, tree):
        a, b = tree.children
        if isinstance(a, Tree) or isinstance(b, Tree):
            return tree
        else:
            return const(IntType(False, 1), 1 if bool(a.getSource()) and bool(b.getSource()) else 0)

    def bnot(self, tree):
        return unary(tree, operator.invert)

    def band(self, tree):
        return binary(tree, operator.and_)

    def bor(self, tree):
        return binary(tree, operator.or_)

    def bxor(self, tree):
        return binary(tree, operator.xor_)

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
        return const(t, cast(v.getSource(), v.getType(), t))
