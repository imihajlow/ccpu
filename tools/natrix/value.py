from lark import Transformer, v_args, Tree
from lark.visitors import Interpreter
from type import UnknownType, PtrType, ArrayType
from exceptions import SemanticError
import labelname
from position import Position
from location import Location

'''
Value class
5 -> Value(IntType(True, 2), 0, 5)
s8 x;       x -> Value(IntType(True, 1), 1, Symbol("x"))
            &x -> Value(PtrType(IntType(True, 1)), 0, Symbol("x"))
s8 *p;      p -> Value(PtrType(IntType(True, 1)), 1, Symbol("p"))
            *p -> Value(IntType(True, 1), 2, Symbol("p"))
s8 a[10];   a -> Value(ArrayType(IntType(True, 1), 10), 0, Symbol("a"))
            a[2] -> Value(IntType(True, 1), 1, Symbol("a+2"))
'''
class Value:
    def __init__(self, position, type, indirLevel, src, aligned):
        if indirLevel < 0:
            raise SemanticError(position, "Cannot take address")
        self._position = position
        self._type = type
        self._level = indirLevel
        self._src = Location(src)
        self._isAligned = aligned

    @staticmethod
    def withOffset(position, type, indirLevel, src, aligned, offset):
        return Value(position, type, indirLevel, Location(src) + Location(offset), aligned)

    @staticmethod
    def variable(position, name, type=UnknownType()):
        return Value(position, type, 1, name, True)

    @staticmethod
    def register(position, type):
        return Value(position, type, 1, Location.register(), True)

    def getPosition(self):
        return self._position

    def getType(self):
        return self._type

    def withType(self, t):
        return Value(self._position, t, self._level, self._src, self._isAligned)

    def withIndirectionOffset(self, offset):
        return Value(self._position, self._type, self._level + offset, self._src, self._isAligned)

    def getIndirLevel(self):
        '''
        Get level of indirection. Constants have level 0, plain variables level 1.
        '''
        return self._level

    def getSource(self):
        return self._src

    def isLValue(self):
        return self._level > 0

    def resolveName(self, fn, localVars, globalVars, paramVars):
        if self._src.isNumber():
            return self
        else:
            if self._src in localVars:
                t = localVars[self._src]
                newType = self._type.removeUnknown(t)
                return Value(self._position, newType, self._level + t.getIndirectionOffset(), labelname.getLocalName(fn, self._src), newType.isAlignedByDefault())
            elif self._src in paramVars:
                t, n = paramVars[self._src]
                newType = self._type.removeUnknown(t)
                return Value(self._position, newType, self._level + t.getIndirectionOffset(), labelname.getArgumentName(fn, n), newType.isAlignedByDefault())
            elif self._src in globalVars:
                t, _ = globalVars[self._src]
                newType = self._type.removeUnknown(t)
                return Value(self._position, newType, self._level + t.getIndirectionOffset(), self._src, newType.isAlignedByDefault())
            else:
                raise SemanticError(self._position, "Undeclared variable {}".format(self._src))

    def removeUnknown(self, newType):
        return Value(self._position, self._type.removeUnknown(newType), self._level, self._src, self._isAligned)

    def __str__(self):
        return "({}, {}, {})".format(self._type, self._level, self._src)

    def __eq__(self, other):
        return isinstance(other, Value) and self._type == other._type and self._level == other._level and self._src == other._src

    def takeAddress(self, newPosition=None):
        if self._level > 0:
            return Value(self._position if newPosition is None else newPosition, PtrType(self._type), self._level - 1, self._src, True)
        else:
            raise SemanticError(self._position, "Cannot get address of this: {}".format(str(self)))

    def isConst(self):
        return self._level == 0

    def isConstNumber(self):
        return self._level == 0 and self._src.isNumber()

    def isConstLabel(self):
        return self._level == 0 and not self._src.isNumber()

    def isAligned(self):
        return self._isAligned

class VarTransformerStageOne(Transformer):
    @v_args(tree = True)
    def var(self, t):
        sym = t.children[0]
        # all variables are aligned by default
        # having unaligned variables (for example, imported from assembly) may lead to errors!
        return Tree("var", [Value(Position.fromAny(t), UnknownType(), 1, str(sym), True)], t.meta) # will be processed later

class VarTransformerStageTwo(Transformer):
    @v_args(inline = True)
    def var(self, val):
        return val

    @v_args(tree = True)
    def addr(self, t):
        val = t.children[0]
        if isinstance(val, Value):
            return val.takeAddress(Position.fromAny(t))
        elif val.data == "member_access":
            return Tree("member_address", val.children, t.meta)
        elif val.data == "arrow":
            return Tree("p_arrow", val.children, t.meta)
        else:
            raise SemanticError(Position.fromAny(t), "Cannot get address")
