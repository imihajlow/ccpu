from lark import Transformer, v_args, Tree
from exceptions import LiteralError
from position import Position
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

    def _addLiteral(self, pos, t, v):
        label = self._allocLiteralLabel()
        self._new_literals += [(label, t, v)]
        return Value(pos, PtrType(t), 0, label, True)

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
        pos = Position.fromAny(lt)
        try:
            s = unescapeString(str(lt))
        except ValueError as e:
            raise LiteralError(pos, str(e))
        result = []
        for c in s:
            result += [ord(c)]
        result += [0]
        return self._addLiteral(pos, IntType(False, 1), result)

    @v_args(tree = True)
    def array_literal(self, t):
        result = []
        type = None
        for v in t.children:
            if not isinstance(v, Value) or v.getIndirLevel() != 0:
                raise LiteralError(Position.fromAny(v), "only constant expressions are allowed in array literals")
            if type is None:
                type = v.getType()
            if type != v.getType():
                raise LiteralError(Position.fromAny(v), "type mismatch with previous members of an array literal ({} expected)".format(str(type)))
            s = v.getSource()
            if not isinstance(s, int):
                raise LiteralError(Position.fromAny(v), "variable references aren't allowed in array literals")
            result += [v.getSource()]
        return self._addLiteral(Position.fromAny(t), type, result)

