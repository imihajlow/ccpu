from lark import Transformer, v_args, Tree, Discard
from value import Value
from type import StructType
from location import Location
from exceptions import SemanticError


@v_args(tree = True)
class StructDeclarationTransformer(Transformer):
    def __init__(self):
        self._dict = dict()

    def struct_declaration(self, t):
        # print(t.children)
        name = t.children[0]
        fields = []
        for c in t.children[1:]:
            ftype = c.children[0]
            fname = c.children[1]
            fields += [(fname, ftype)]
        if name in self._dict:
            raise SemanticError(Location.fromAny(t), f"struct {name} redefinition")
        self._dict[name] = fields
        raise Discard

    def lookup(self, name):
        return self._dict[name]

    def populateTypes(self, tps):
        print(tps)
        for s, l in tps:
            name = s.getStructName()
            if name not in self._dict:
                raise SemanticError(l, f"Undeclared struct {name}")
            fields = self._dict[name]
            s.setFields(fields)
