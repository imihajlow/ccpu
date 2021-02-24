from lark import Transformer, v_args, Tree
from exceptions import LiteralError
from location import Location
from type import IntType, PtrType
from value import Value
from function import unescapeString

class LiteralTransformer(Transformer):
    def __init__(self, nameInfo):
        self._index = 0
        self._literals = []
        self._new_literals = []
        self._ni = nameInfo

    def getLiterals(self):
        return self._literals

    def _allocLiteralLabel(self):
        i = self._index
        self._index += 1
        return "__lit_{}".format(i)

    def _addLiteral(self, loc, t, v):
        label = self._allocLiteralLabel()
        self._new_literals += [(label, t, v)]
        return Value(loc, PtrType(t), 0, label, True)

    @v_args(tree = True)
    def function_definition(self, t):
        decl, body = t.children
        name = decl.children[2]
        section = self._ni.functions[name].section
        for label, type, value in self._new_literals:
            self._literals += [(label, type, value, section)]
        self._new_literals = []
        return t

    @v_args(inline = True)
    def string_literal(self, lt):
        loc = Location.fromAny(lt)
        try:
            s = unescapeString(str(lt))
        except ValueError as e:
            raise LiteralError(loc, str(e))
        result = []
        for c in s:
            result += [ord(c)]
        result += [0]
        return self._addLiteral(loc, IntType(False, 1), result)

    @v_args(tree = True)
    def array_literal(self, t):
        result = []
        type = None
        for v in t.children:
            if not isinstance(v, Value) or v.getIndirLevel() != 0:
                raise LiteralError(Location.fromAny(v), "only constant expressions are allowed in array literals")
            if type is None:
                type = v.getType()
            if type != v.getType():
                raise LiteralError(Location.fromAny(v), "type mismatch with previous members of an array literal ({} expected)".format(str(type)))
            s = v.getSource()
            if not isinstance(s, int):
                raise LiteralError(Location.fromAny(v), "variable references aren't allowed in array literals")
            result += [v.getSource()]
        return self._addLiteral(Location.fromAny(t), type, result)

