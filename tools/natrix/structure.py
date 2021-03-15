from lark import Transformer, v_args, Tree, Discard
from value import Value
from type import StructType, PtrType
from location import Location
from exceptions import SemanticError

def getField(t, fields):
    offset = 0
    for field in fields:
        offset += t.getFieldOffset(field)
        t = t.getFieldType(field)
    return offset, t

@v_args(tree = True)
class StructDeclarationTransformer(Transformer):
    def __init__(self):
        self._dict = dict()

    def struct_declaration(self, t):
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
        for s, l in tps:
            name = s.getStructName()
            if name not in self._dict:
                raise SemanticError(l, f"Undeclared struct {name}")
            fields = self._dict[name]
            s.setFields(fields)

@v_args(tree = True)
class MemberAccessTransformer(Transformer):
    def member_access(self, t):
        obj = t.children[0]
        fields = t.children[1:]
        if isinstance(obj, Value):
            try:
                offset, type = getField(obj.getType(), fields)
            except ValueError as e:
                raise SemanticError(Location.fromAny(t), str(e))
            except LookupError as e:
                raise SemanticError(Location.fromAny(t), str(e))
            except AttributeError as e:
                raise SemanticError(Location.fromAny(t), f"{obj} is not a struct")
            if obj.getIndirLevel() != 1:
                raise RuntimeError("WTF is that")
            return Value.withOffset(Location.fromAny(t), type, 1 + type.getIndirectionOffset(), obj.getSource(), False, offset)
        elif obj.data == 'deref':
            return Tree("arrow", [obj.children[0]] + fields, t.meta)
        else:
            raise RuntimeError("Unhandled member_access case")

    def member_address(self, t):
        obj = t.children[0]
        fields = t.children[1:]
        if isinstance(obj, Value):
            try:
                offset, type = getField(obj.getType(), fields)
            except ValueError as e:
                raise SemanticError(Location.fromAny(t), str(e))
            except AttributeError as e:
                raise SemanticError(Location.fromAny(t), f"{obj} is not a struct")
            if obj.getIndirLevel() != 1:
                raise RuntimeError("WTF is that")
            return Value.withOffset(Location.fromAny(t), PtrType(type), 0 + type.getIndirectionOffset(), obj.getSource(), True, offset)
        elif obj.data == 'deref':
            return Tree("p_arrow", [obj.children[0]] + fields, t.meta)
        else:
            raise RuntimeError("Unhandled member_access case")
