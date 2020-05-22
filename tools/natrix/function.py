def hasAttr(attrs, a):
    return any(x.data == a for x in attrs)

class Function:
    def __init__(self, name, retType, attrs, args):
        self.name = name
        self.isExported = hasAttr(attrs, "attr_export")
        self.isImported = hasAttr(attrs, "attr_import")
        self.isAlwaysRecursion = hasAttr(attrs, "attr_always_recursion")
        self.args = [a.children[0] for a in args] # type
        self.retType = retType
        self.localVars = {}
        if self.isExported and self.isImported:
            raise ValueError("A function can't be exported and imported at the same time")

    def equal(self, other, allowAttrOverride):
        if isinstance(other, Function):
            if not(self.name == other.name \
                    and self.retType == other.retType \
                    and self.args == other.args):
                return False
            if allowAttrOverride:
                return True
            else:
                return self.isImported == other.isImported \
                    and self.isExported == other.isExported \
                    and self.isAlwaysRecursion == other.isAlwaysRecursion
        else:
            return False
