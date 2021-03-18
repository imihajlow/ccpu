
class Location:
    def __init__(self, v):
        if isinstance(v, Location):
            self._isRegister = v._isRegister
            self._v = v._v
            self._isNumber = v._isNumber
        else:
            self._isRegister = False
            self._v = v
            self._isNumber = isinstance(v, int)

    @staticmethod
    def register():
        l = Location("")
        l._isRegister = True
        return l

    def isRegister(self):
        return self._isRegister

    def isNumber(self):
        return not self._isRegister and self._isNumber

    def isExpr(self):
        return not self._isRegister and not self._isNumber

    def __eq__(self, other):
        return self._isRegister == other._isRegister and self._v == other._v and self._isNumber == other._isNumber

    def __hash__(self):
        return hash((self._isRegister, self._v, self._isNumber))

    def __str__(self):
        if self._isRegister:
            return "reg a"
        else:
            return str(self._v)

    def __int__(self):
        if self.isNumber():
            return self._v
        else:
            raise RuntimeError("Not a number")

    def __bool__(self):
        if self.isNumber():
            return bool(self._v)
        else:
            raise RuntimeError("Not a number")

    def _bracedString(self):
        if self._isNumber:
            return str(self._v)
        else:
            return f"({self._v})"

    def __add__(self, other):
        if not isinstance(other, Location):
            other = Location(other)
        if self._isRegister or other._isRegister:
            raise RuntimeError("Can't add a register")
        if self._isNumber and other._isNumber:
            return Location(self._v + other._v)
        else:
            if other.isNumber() and other._v == 0:
                return self
            else:
                return Location(f"{self._bracedString()} + {other._bracedString()}")

    def __sub__(self, other):
        if not isinstance(other, Location):
            other = Location(other)
        if self._isRegister or other._isRegister:
            raise RuntimeError("Can't subtract a register")
        if self._isNumber and other._isNumber:
            return Location(self._v - other._v)
        else:
            if other.isNumber() and other._v == 0:
                return self
            else:
                return Location(f"{self._bracedString()} - {other._bracedString()}")

    def __mul__(self, other):
        if not isinstance(other, Location):
            other = Location(other)
        if self._isRegister or other._isRegister:
            raise RuntimeError("Can't multiply a register")
        if self._isNumber and other._isNumber:
            return Location(self._v * other._v)
        else:
            return Location(f"{self._bracedString()} * {other._bracedString()}")

    def __invert__(self):
        if self._isRegister:
            raise RuntimeError("Can't invert a register")
        if self._isNumber:
            return Location(~self._v)
        else:
            return Location(f"~{self._bracedString()}")

    def lo(self):
        if self._isRegister:
            raise RuntimeError("Can't get lo of a register")
        if self._isNumber:
            return Location(self._v & 0xff)
        else:
            return Location(f"lo({self})")

    def hi(self):
        if self._isRegister:
            raise RuntimeError("Can't get hi of a register")
        if self._isNumber:
            return Location((self._v >> 8) & 0xff)
        else:
            return Location(f"hi({self})")

    def byte(self, n):
        if self._isRegister:
            raise RuntimeError("Can't get byte of a register")
        if self._isNumber:
            return Location((self._v >> (8 * n)) & 0xff)
        else:
            if n == 0:
                return self.lo()
            elif n == 1:
                return self.hi()
            else:
                raise RuntimeError("Nth byte of a label (N > 1)?")

    def widen(self, sign):
        if self._isRegister:
            raise RuntimeError("Can't widen a register")
        if sign:
            if self._isNumber:
                return Location(self._v | (0xff00 if bool(self._v & 0x80) else 0))
            else:
                return Location("({0}) | (0xff00 if bool(({0}) & 0x80) else 0)".format(self._v))
        else:
            return self

