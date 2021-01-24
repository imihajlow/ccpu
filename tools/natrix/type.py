import re
from abc import ABC, abstractmethod
from lark import Transformer, v_args, Tree
from exceptions import SemanticError
from location import Location

class Type(ABC):
    @abstractmethod
    def getSign(self):
        pass

    @abstractmethod
    def getSize(self):
        pass

    @abstractmethod
    def isPointer(self):
        pass

    def isInteger(self):
        return False

    def isStruct(self):
        return False

    def getReserveSize(self):
        return self.getSize()

    @abstractmethod
    def removeUnknown(self, newType):
        pass

    @abstractmethod
    def isUnknown(self):
        pass

    def getIndirectionOffset(self):
        '''
        This value is added to the indirection level of a value when the type is resolved
        '''
        return 0

    def deref(self):
        raise ValueError("Cannot dereference a non-pointer type")

class IntType(Type):
    def __init__(self, sign, size):
        self._sign = sign
        self._size = size

    @staticmethod
    def parse(s):
        r = re.match(r"(s|u)(8|16)", s)
        if r is not None:
            return IntType(r.group(1) == 's', int(r.group(2)) // 8)
        else:
            raise ValueError("Invalid type " + s)

    def getSign(self):
        return self._sign

    def getSize(self):
        return self._size

    def isPointer(self):
        return False

    def isInteger(self):
        return True

    def removeUnknown(self, newType):
        if newType != self:
            raise ValueError("Trying to call removeUnknown on an incompatible IntType")
        else:
            return self

    def isUnknown(self):
        return False

    def __str__(self):
        return "{}{}".format("s" if self._sign else "u", self._size * 8)

    def __eq__(self, other):
        if isinstance(other, IntType):
            return self._sign == other._sign and self._size == other._size
        else:
            return False

class BoolType(IntType):
    def __init__(self):
        super().__init__(False, 1)

class PtrType(Type):
    def __init__(self, t):
        self._t = t

    def getSign(self):
        return False

    def getSize(self):
        return 2

    def isPointer(self):
        return True

    def deref(self):
        return self._t

    def removeUnknown(self, newType):
        return PtrType(self._t.removeUnknown(newType))

    def isUnknown(self):
        return self._t.isUnknown()

    def __str__(self):
        return str(self._t) + "*"

    def __eq__(self, other):
        if isinstance(other, PtrType):
            return self._t == other._t
        else:
            return False

class ArrayType(PtrType):
    def __init__(self, t, n):
        super().__init__(t)
        self._n = n

    def getCount(self):
        return self._n

    def removeUnknown(self, newType):
        return ArrayType(self._t.removeUnknown(newType), self._n)

    def getIndirectionOffset(self):
        return -1

    def getReserveSize(self):
        return self._n * self.deref().getReserveSize()

    def __str__(self):
        return str(self._t) + "[{}]".format(self._n)

    def __eq__(self, other):
        if isinstance(other, ArrayType):
            return self._t == other._t and self._n == other._n
        else:
            return False

class StructType(Type):
    def __init__(self, name, fields=None):
        self._name = name
        self._fields = fields

    def setFields(self, fields):
        self._fields = fields

    def getStructName(self):
        return self._name

    def getSize(self):
        if self._fields is None:
            raise ValueError(f"Size of struct {self._name} is not known")
        return sum(t.getReserveSize() for t,_ in self._fields)

    def getFieldType(self, name):
        if self._fields == None:
            raise ValueError(f"Struct {self._name}'s fields ar not known")
        for t,n in self._fields:
            if name == n:
                return t
        raise LookupError(name)

    def getFieldOffset(self, name):
        if self._fields == None:
            raise ValueError(f"Struct {self._name}'s fields ar not known")
        offset = 0
        for t,n in self._fields:
            if name == n:
                return offset
            offset += t.getReserveSize()
        raise LookupError(name)

    def getSign(self):
        return False

    def isPointer(self):
        return False

    def isUnknown(self):
        return False

    def removeUnknown(self, other):
        raise NonImplementedError()

    def __str__(self):
        if self._fields is None:
            return f"struct {self._name} (unknown)"
        else:
            return f"struct {self._name}"

    def __eq__(self, other):
        if isinstance(other, StructType):
            return self._name == other._name
        else:
            return False


class UnknownType(Type):
    def __init__(self):
        pass

    def getSign(self):
        return False

    def getSize(self):
        return 0

    def isPointer(self):
        return False

    def removeUnknown(self, newType):
        return newType

    def isUnknown(self):
        return True

    def __str__(self):
        return "?"

    def __eq__(self, other):
        return False

class TypeTransformer(Transformer):
    def __init__(self):
        super().__init__()
        self._structsToPopulate = []

    def getStructs(self):
        return self._structsToPopulate

    @v_args(inline = True)
    def ptr(self, t):
        return PtrType(t)

    @v_args(inline = True)
    def int_type(self, s):
        try:
            return IntType.parse(s)
        except ValueError as e:
            raise SemanticError(Location.fromAny(t), str(e))

    @v_args(tree = True)
    def struct_type(self, t):
        st = StructType(t.children[0])
        self._structsToPopulate += [(st, Location.fromAny(t))]
        return st

    @v_args(tree = True)
    def decl_array(self, t):
        type = t.children[0]
        size = t.children[2]
        from value import Value
        if isinstance(size, Value):
            if isinstance(size.getSource(), int):
                if size.getIndirLevel() == 0 and size.getSource() > 0:
                    return Tree("decl_var", [ArrayType(type, size.getSource()), t.children[1]], t.meta)
        raise SemanticError(Location.fromAny(t), "Array size must be a positive constant expression")

    @v_args(tree = True)
    def gl_decl_array(self, t):
        attrs, type, name, size = t.children
        from value import Value
        if isinstance(size, Value):
            if isinstance(size.getSource(), int):
                if size.getIndirLevel() == 0 and size.getSource() > 0:
                    return Tree("gl_decl_var", [attrs, ArrayType(type, size.getSource()), name], t.meta)
        raise SemanticError(Location.fromAny(t), "Array size must be a positive constant expression")

class CastTransformer(Transformer):
    @v_args(tree = True)
    def type_cast(self, t):
        type, v = t.children
        from value import Value
        if isinstance(v, Value) and v.getIndirLevel() == 0:
            s = v.getSource()
            # TODO type size > 2 when structs
            if type.getSize() > v.getType().getSize():
                # widening cast
                if isinstance(s, int):
                    if v.getType().getSign():
                        s = s | (0xff00 if bool(s & 0x80) else 0)
                else:
                    if v.getType().getSign():
                        s = "(({0}) | (0xff00 if bool(({0}) & 0x80) else 0))".format(s)
            elif type.getSize() < v.getType().getSize():
                # narrowing cast
                if isinstance(s, int):
                    s = s & 0xff
                else:
                    s = "lo({})".format(s)
            return Value(Location.fromAny(t), type, 0, s)
        else:
            return t
