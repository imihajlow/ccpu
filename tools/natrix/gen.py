from lark import Lark, Transformer, v_args, Tree
from exceptions import SemanticError
from value import Value
from type import Type
import variable

class Generator:
    def __init__(self):
        self.maxTempVarIndex = 0
        self.localVars = {}
        self.globalVars = {}

    def generateExpression(self, t, minTempVarIndex, resultLoc, curFn):
        if isinstance(t, Value):
            # TODO deref and shit
            return resultLoc, "{} := {}\n".format(resultLoc, str(t))
        else:
            ch = t.children
            if len(ch) == 1:
                if isinstance(ch[0], Value):
                    argCode = ""
                    rv = ch[0].resolveName(curFn, self.localVars, self.globalVars)
                else:
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                    rv, argCode = self.generateExpression(ch[0], minTempVarIndex,
                        Value.variable(variable.getTempName(minTempVarIndex)), curFn)
                # TODO type of result, compare types
                myCode = "{} := {}({})\n".format(str(resultLoc), t.data, str(rv))
                return resultLoc, argCode + myCode
            elif len(ch) == 2:
                hasFirstArg = False
                if isinstance(ch[0], Value):
                    rv1 = ch[0].resolveName(curFn, self.localVars, self.globalVars)
                    argCode1 = ""
                else:
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                    rv1, argCode1 = self.generateExpression(ch[0], minTempVarIndex,
                        Value.variable(variable.getTempName(minTempVarIndex)), curFn)
                    hasFirstArg = True

                if isinstance(ch[1], Value):
                    rv2 = ch[1].resolveName(curFn, self.localVars, self.globalVars)
                    argCode2 = ""
                else:
                    indexIncrement = 1 if hasFirstArg else 0
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex + indexIncrement)
                    rv2, argCode2 = self.generateExpression(ch[1], minTempVarIndex + indexIncrement,
                        Value.variable(variable.getTempName(minTempVarIndex + indexIncrement)), curFn)

                # TODO check types, type of result
                myCode = "{} := {}({}, {})\n".format(str(resultLoc), t.data, str(rv1), str(rv2))
                return resultLoc, argCode1 + argCode2 + myCode
            else:
                raise ValueError("Too many children")

    def generateFunction(self, t):
        if t.data == 'assignment':
            l, r = t.children
            if isinstance(l, Value):
                if not l.isLValue():
                    raise SemanticError("input", t.line, "Cannot assign to an r-value")
                dest = l.resolveName("fn", self.localVars, self.globalVars)
                _, code = self.generateExpression(r, 0, dest, "fn")
                return code
        elif t.data == 'decl_var':
            typ, nam = t.children
            self.localVars[str(nam)] = typ
            return ""
        elif t.data == 'def_var':
            type, name, r = t.children
            self.localVars[str(name)] = type
            _, code = self.generateExpression(r, 0, Value.variable(type, variable.getLocalName("fn", str(name))), "fn")
            return code
        elif t.data == 'start':
            return "".join(self.generateFunction(child) for child in t.children)
        elif t.data == 'block':
            return "".join(self.generateFunction(child) for child in t.children)


