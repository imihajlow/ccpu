from lark import Transformer, v_args, Tree
from type import UnknownType, PtrType, ArrayType
from exceptions import SemanticError
import variable

'''
Value class
5 -> Value(IntType(True, 2), 0, 5)
s8 x;       x -> Value(IntType(True, 1), 1, Symbol("x"))
            &x -> Value(PtrType(IntType(True, 1)), 0, Symbol("x"))
s8 *p;      p -> Value(PtrType(IntType(True, 1)), 1, Symbol("p"))
            *p -> Value(IntType(True, 1), 2, Symbol("p"))
s8 a[10];   p -> Value(ArrayType(IntType(True, 1), 10), 0, Symbol("a"))
            p[2] -> Value(IntType(True, 1), 1, Symbol("a+2"))
'''
class Value:
    def __init__(self, type, indirLevel, src):
        self._type = type
        self._level = indirLevel
        self._src = src

    @staticmethod
    def variable(name, type=UnknownType()):
        return Value(type, 1, name)

    def getType(self):
        return self._type

    def withType(self, t):
        return Value(t, self._level, self._src)

    def getIndirLevel(self):
        '''
        Get level of indirection. Constants have level 0, plain variables level 1.
        '''
        return self._level

    def getSource(self):
        return self._src

    def isLValue(self):
        return self._level > 0

    def resolveName(self, fn, localVars, globalVars):
        if isinstance(self._src, int):
            return self
        else:
            if self._src in localVars:
                t = localVars[self._src]
                return Value(self._type.removeUnknown(t), self._level + t.getIndirectionOffset(), variable.getLocalName(fn, self._src))
            elif self._src in globalVars:
                t = globalVars[self._src]
                return Value(self._type.removeUnknown(t), self._level + t.getIndirectionOffset(), self._src)
            else:
                raise ValueError("Undeclared variable {}".format(self._src))

    def removeUnknown(self, newType):
        return Value(self._type.removeUnknown(newType), self._level, self._src)

    def __str__(self):
        return "({}, {}, {})".format(self._type, self._level, self._src)

    def __eq__(self, other):
        return isinstance(other, Value) and self._type == other._type and self._level == other._level and self._src == other._src

    def takeAddress(self):
        if self._level > 0:
            return Value(PtrType(self._type), self._level - 1, self._src)
        else:
            raise ValueError("Cannot get address of this: {}".format(str(self)))

    def isConst(self):
        return self._level == 0 and isinstance(self._src, int)

class ValueTransformer(Transformer):
    @v_args(inline = True)
    def var(self, sym):
        return Value(UnknownType(), 1, str(sym))

    @v_args(tree = True)
    def addr(self, t):
        val = t.children[0]
        if isinstance(val, Value):
            try:
                return val.takeAddress()
            except ValueError as e:
                raise SemanticError("input", t.line, str(e))
        else:
            return t
