import re
from abc import ABC, abstractmethod
from lark import Transformer, v_args, Tree
from exceptions import SemanticError

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

    @abstractmethod
    def removeUnknown(self, newType):
        pass

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

    def removeUnknown(self, newType):
        if newType != self:
            raise ValueError("Trying to call removeUnknown on an incompatible IntType")
        else:
            return self

    def __str__(self):
        return "{}{}".format("s" if self._sign else "u", self._size * 8)

    def __eq__(self, other):
        if isinstance(other, IntType):
            return self._sign == other._sign and self._size == other._size
        else:
            return False

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

    def __str__(self):
        return str(self._t) + "[{}]".format(self._n)

    def __eq__(self, other):
        if isinstance(other, ArrayType):
            return self._t == other._t and self._n == other._n
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

    def __str__(self):
        return "?"

    def __eq__(self, other):
        return False

class TypeTransformer(Transformer):
    @v_args(inline = True)
    def ptr(self, t):
        return PtrType(t)

    @v_args(inline = True)
    def int_type(self, s):
        return IntType.parse(s)

    @v_args(tree = True)
    def decl_array(self, t):
        type = t.children[0]
        size = t.children[2]
        from value import Value
        if isinstance(size, Value):
            if isinstance(size.getSource(), int):
                if size.getIndirLevel() == 0 and size.getSource() > 0:
                    return Tree("decl_var", [ArrayType(type, size.getSource()), t.children[1]], t.meta)
        raise SemanticError("input", t.line, "Array size must be a positive constant expression")
