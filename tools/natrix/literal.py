from lark import Transformer, v_args, Tree
from exceptions import LiteralError
from location import Location
from type import IntType, PtrType
from value import Value

class LiteralTransformer(Transformer):
    def __init__(self):
        self._index = 0
        self._literals = []

    def getLiterals(self):
        return self._literals

    def _allocLiteralLabel(self):
        i = self._index
        self._index += 1
        return "__lit_{}".format(i)

    def _addLiteral(self, loc, t, v):
        label = self._allocLiteralLabel()
        self._literals += [(label, t, v)]
        return Value(loc, PtrType(t), 0, label, final=True)

    @v_args(inline = True)
    def string_literal(self, lt):
        s = str(lt)[1:-1]
        result = []
        escape = False
        loc = Location.fromAny(lt)
        for c in s:
            if not escape:
                if c == '\\':
                    escape = True
                else:
                    if ord(c) > 127:
                        raise LiteralError(loc, "only 127 ASCII characters are supported")
                    result += [ord(c)]
            else:
                if c == '"':
                    result += [ord(c)]
                elif c == 'n':
                    result += [10]
                elif c == '\\':
                    result += [ord(c)]
                else:
                    result += [ord('\\'), ord(c)]
                escape = False
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

