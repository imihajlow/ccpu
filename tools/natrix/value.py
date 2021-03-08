from lark import Transformer, v_args, Tree
from lark.visitors import Interpreter
from .type import UnknownType, PtrType, ArrayType
from .exceptions import SemanticError
from . import labelname
from .location import Location

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
    def __init__(self, location, type, indirLevel, src, aligned):
        if indirLevel < 0:
            raise SemanticError(location, "Cannot take address")
        self._location = location
        self._type = type
        self._level = indirLevel
        self._src = src
        self._isAligned = aligned

    @staticmethod
    def withOffset(location, type, indirLevel, src, aligned, offset):
        source = src
        if offset != 0:
            if isinstance(src, int):
                source = src + offset
            else:
                source = f"({src}) + {offset}"
        return Value(location, type, indirLevel, source, aligned)

    @staticmethod
    def variable(location, name, type=UnknownType()):
        return Value(location, type, 1, name, True)

    def getLocation(self):
        return self._location

    def getType(self):
        return self._type

    def withType(self, t):
        return Value(self._location, t, self._level, self._src, self._isAligned)

    def withIndirectionOffset(self, offset):
        return Value(self._location, self._type, self._level + offset, self._src, self._isAligned)

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
        if isinstance(self._src, int):
            return self
        else:
            if self._src in localVars:
                t = localVars[self._src]
                newType = self._type.removeUnknown(t)
                return Value(self._location, newType, self._level + t.getIndirectionOffset(), labelname.getLocalName(fn, self._src), newType.isAlignedByDefault())
            elif self._src in paramVars:
                t, n = paramVars[self._src]
                newType = self._type.removeUnknown(t)
                return Value(self._location, newType, self._level + t.getIndirectionOffset(), labelname.getArgumentName(fn, n), newType.isAlignedByDefault())
            elif self._src in globalVars:
                t = globalVars[self._src]
                newType = self._type.removeUnknown(t)
                return Value(self._location, newType, self._level + t.getIndirectionOffset(), self._src, newType.isAlignedByDefault())
            else:
                raise SemanticError(self._location, "Undeclared variable {}".format(self._src))

    def removeUnknown(self, newType):
        return Value(self._location, self._type.removeUnknown(newType), self._level, self._src, self._isAligned)

    def __str__(self):
        return "({}, {}, {})".format(self._type, self._level, self._src)

    def __eq__(self, other):
        return isinstance(other, Value) and self._type == other._type and self._level == other._level and self._src == other._src

    def takeAddress(self, newLocation=None):
        if self._level > 0:
            return Value(self._location if newLocation is None else newLocation, PtrType(self._type), self._level - 1, self._src, True)
        else:
            raise SemanticError(self._location, "Cannot get address of this: {}".format(str(self)))

    def isConst(self):
        return self._level == 0

    def isConstNumber(self):
        return self._level == 0 and isinstance(self._src, int)

    def isConstLabel(self):
        return self._level == 0 and not isinstance(self._src, int)

    def isAligned(self):
        return self._isAligned

class VarTransformerStageOne(Transformer):
    @v_args(tree = True)
    def var(self, t):
        sym = t.children[0]
        # all variables are aligned by default
        # having unaligned variables (for example, imported from assembly) may lead to errors!
        return Tree("var", [Value(Location.fromAny(t), UnknownType(), 1, str(sym), True)], t.meta) # will be processed later

class VarTransformerStageTwo(Transformer):
    @v_args(inline = True)
    def var(self, val):
        return val

    @v_args(tree = True)
    def addr(self, t):
        val = t.children[0]
        if isinstance(val, Value):
            return val.takeAddress(Location.fromAny(t))
        elif val.data == "member_access":
            return Tree("member_address", val.children, t.meta)
        elif val.data == "arrow":
            return Tree("p_arrow", val.children, t.meta)
        else:
            raise SemanticError(Location.fromAny(t), "Cannot get address")
