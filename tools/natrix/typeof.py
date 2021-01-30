import re
import operator
from lark import Lark, Transformer, v_args, Tree
from value import Value
from type import IntType, Type, BoolType, PtrType
from location import Location
from literal import unescapeString
import exceptions

def _typeof(v):
    if isinstance(v, Value):
        return v.getType()
    elif isinstance(v, Type):
        return v
    else:
        raise ValueError("WTF")

def _addsub(t):
    t1 = _typeof(t.children[0])
    t2 = _typeof(t.children[1])
    if t1.isPointer():
        if t2.isInteger():
            return t1
        else:
            raise exceptions.SemanticError(Location.fromAny(t), f"Incompatible types: {str(t1)} and {str(t2)}")
    elif t1.isInteger():
        if t2 == t1:
            return t1
        else:
            raise exceptions.SemanticError(Location.fromAny(t), f"Incompatible types: {str(t1)} and {str(t2)}")
    else:
        raise exceptions.SemanticError(Location.fromAny(t), f"Wrong arithmetic type: {str(t1)}")

def _arithm(t):
    t1 = _typeof(t.children[0])
    t2 = _typeof(t.children[1])
    if t1.isInteger():
        if t2 == t1:
            return t1
        else:
            raise exceptions.SemanticError(Location.fromAny(t), f"Incompatible types: {str(t1)} and {str(t2)}")
    else:
        raise exceptions.SemanticError(Location.fromAny(t), f"Wrong arithmetic type: {str(t1)}")

def _cmp(t):
    t1 = _typeof(t.children[0])
    t2 = _typeof(t.children[1])
    if t1.isInteger():
        if t2 == t1:
            return BoolType()
        else:
            raise exceptions.SemanticError(Location.fromAny(t), f"Incompatible types: {str(t1)} and {str(t2)}")
    else:
        raise exceptions.SemanticError(Location.fromAny(t), f"Wrong arithmetic type: {str(t1)}")

def _shift(t):
    t1 = _typeof(t.children[0])
    t2 = _typeof(t.children[1])
    if t1.isInteger() and t2.isInteger():
        return t1
    else:
        raise exceptions.SemanticError(Location.fromAny(t), f"Wrong types for bit shift: {str(t1)} and {str(t2)}")

@v_args(tree = True)
class TypeofTransformer(Transformer):
    def type_cast(self, t):
        return t.children[0]

    def deref(self, t):
        return t.children[0].getType().deref()

    def add(self, t):
        return _addsub(t)

    def sub(self, t):
        return _addsub(t)

    def mul(self, t):
        return _arithm(t)

    def div(self, t):
        return _arithm(t)

    def div(self, t):
        return _arithm(t)

    def band(self, t):
        return _arithm(t)

    def bor(self, t):
        return _arithm(t)

    def bxor(self, t):
        return _arithm(t)

    def shl(self, tree):
        return _shift(tree)

    def shr(self, tree):
        return _shift(tree)

    def neg(self, tree):
        t = _typeof(tree.children[0])
        if t.isInteger():
            return t
        else:
            raise exceptions.SemanticError(Location.fromAny(tree), f"Wrong type for negation: {str(t)}")

    def lnot(self, tree):
        t = _typeof(tree.children[0])
        if t.isBool():
            return BoolType()
        else:
            raise exceptions.SemanticError(Location.fromAny(tree), f"Wrong type for logical not: {str(t)}")

    def lor(self, tree):
        t0 = _typeof(tree.children[0])
        t1 = _typeof(tree.children[1])
        if t0.isBool() and t1.isBool():
            return BoolType()
        else:
            raise exceptions.SemanticError(Location.fromAny(tree), f"Wrong types for logical or: {str(t0)}, {str(t1)}")

    def land(self, tree):
        t0 = _typeof(tree.children[0])
        t1 = _typeof(tree.children[1])
        if t0.isBool() and t1.isBool():
            return BoolType()
        else:
            raise exceptions.SemanticError(Location.fromAny(tree), f"Wrong types for logical and: {str(t0)}, {str(t1)}")

    def bnot(self, tree):
        t = _typeof(tree.children[0])
        if t.isInteger():
            return t
        else:
            raise exceptions.SemanticError(Location.fromAny(tree), f"Wrong type for bitwise not: {str(t)}")

    def lt(self, tree):
        return _cmp(tree)

    def le(self, tree):
        return _cmp(tree)

    def gt(self, tree):
        return _cmp(tree)

    def ge(self, tree):
        return _cmp(tree)

    def eq(self, tree):
        t0 = _typeof(tree.children[0])
        t1 = _typeof(tree.children[1])
        if t0 == t1:
            return BoolType()
        else:
            raise exceptions.SemanticError(Location.fromAny(tree), f"Incompatible types: {str(t0)}, {str(t1)}")

    def ne(self, tree):
        t0 = _typeof(tree.children[0])
        t1 = _typeof(tree.children[1])
        if t0 == t1:
            return BoolType()
        else:
            raise exceptions.SemanticError(Location.fromAny(tree), f"Incompatible types: {str(t0)}, {str(t1)}")

    def arrow(self, tree):
        try:
            ts = _typeof(tree.children[0])
            return ts.deref().getFieldType(tree.children[1])
        except LookupError as e:
            raise exceptions.SemanticError(Location.fromAny(tree), str(e))

    def p_arrow(self, tree):
        try:
            ts = _typeof(tree.children[0])
            return PtrType(ts.deref().getFieldType(tree.children[1]))
        except LookupError as e:
            raise exceptions.SemanticError(Location.fromAny(tree), str(e))
