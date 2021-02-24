from lark import Visitor, v_args, Tree
from lark.visitors import Interpreter
from location import Location
from exceptions import SemanticError

def unescapeString(s, quote='"', acceptUnknownEscapeSeq=True, findLastQuote=False):
    s = s[1:]
    if not findLastQuote:
        s = s[:-1]
    escape = False
    result = ""
    for c in s:
        if not escape:
            if c == '\\':
                escape = True
            else:
                if findLastQuote and c == quote:
                    return result
                if ord(c) > 127:
                    raise ValueError("only 127 ASCII characters are supported")
                result += c
        else:
            if c == quote:
                result += c
            elif c == 'n':
                result += chr(10)
            elif c == '\\':
                result += c
            else:
                if acceptUnknownEscapeSeq:
                    result += ['\\', c]
                else:
                    raise ValueError("unknown escape sequence: \\{}".format(c))
            escape = False
    return result

def hasAttr(attrs, a):
    return any(x.data == a for x in attrs)

def getSection(attrs, default):
    section_attrs = [x for x in attrs if x.data == "attr_section"]
    if len(section_attrs) == 1:
        return unescapeString(section_attrs[0].children[0])
    elif len(section_attrs) == 0:
        return default
    else:
        raise ValueError("Multple sections specified")

class Function:
    def __init__(self, name, retType, attrs, args):
        self.name = name
        self.isExported = hasAttr(attrs, "attr_export")
        self.isImported = hasAttr(attrs, "attr_import")
        self.isAlwaysRecursion = hasAttr(attrs, "attr_always_recursion")
        self.args = [a.children[0] for a in args] # type
        self.paramVars = {str(a.children[1]): (a.children[0], i) for i,a in enumerate(args)}
        self.retType = retType
        self.localVars = {}
        self.section = getSection(attrs, "text")
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

    def __str__(self):
        return f"{self.retType} {self.name}(" + ', '.join(f'{str(t)} {self.argNames[i]}' for i,t in enumerate(self.args)) + ")"


@v_args(tree = True)
class NameInterpreter(Interpreter):
    '''
    Collects all function declarations and definitions, checks for conflicting declarations.
    Collects local and global variables.
    Resolves variable names.
    '''
    def __init__(self):
        self.functions = {} # name -> Function
        self.globalVars = {} # name -> type
        self._currentFunction = None
        self.varImports = []
        self.varExports = []

    def _addFunction(self, t, isDefinition):
        attrs = t.children[0].children
        retType = t.children[1]
        name = t.children[2]
        args = t.children[3].children
        try:
            fn = Function(name, retType, attrs, args)
        except ValueError as e:
            raise SemanticError(Location.fromAny(t), str(e))
        if name in self.functions and not fn.equal(self.functions[name], isDefinition):
            raise SemanticError(Location.fromAny(t), "conflicting declarations of {}".format(name))
        self.functions[name] = fn
        return fn

    def gl_decl_var(self, t):
        attrTree, type, name = t.children
        attrs = attrTree.children
        location = Location.fromAny(t)
        if name in self.globalVars:
            if not name in self.varImports:
                raise SemanticError(location, "conflicting declarations of {}".format(name))
            else:
                i = self.varImports.index(name)
                del self.varImports[i]
        self.globalVars[name] = type
        isImported = False
        isExported = False
        for a in attrs:
            if a.data == "attr_import":
                isImported = True
            elif a.data == "attr_export":
                isExported = True
            elif a.data == "attr_always_recursion":
                raise SemanticError(location, "a variable can't be a traitor")
            else:
                raise RuntimeError("unhandled attribute {}".format(a.data))
        if isImported and isExported:
            raise SemanticError(location, "nothing can be imported and exported at the same time")
        if isImported:
            self.varImports += [name]
        if isExported:
            self.varExports += [name]

    def var(self, t):
        var = t.children[0]
        t.children[0] = var.resolveName(self._currentFunction.name, self._currentFunction.localVars, self.globalVars, self._currentFunction.paramVars)

    def function_declaration(self, t):
        self._addFunction(t, False)

    def function_definition(self, t):
        decl, body = t.children
        fn = self._addFunction(decl, True)
        if fn.isImported:
            raise SemanticError(Location.fromAny(decl), "Cannot define an imported function")
        self._currentFunction = fn
        self.visit(body)
        self._currentFunction = None

    def decl_var(self, t):
        type = t.children[0]
        name = t.children[1]
        lv = self._currentFunction.localVars
        if name in lv:
            raise SemanticError(Location.fromAny(t), f"Local variable {name} redifinition")
        lv[name] = type
