from lark import Lark, Transformer, v_args, Tree
from exceptions import SemanticError
from value import Value
from type import Type
import variable
import code

class Generator:
    def __init__(self):
        self.maxTempVarIndex = 0
        self.localVars = {}
        self.globalVars = {}

    def generateExpression(self, t, minTempVarIndex, resultLoc, curFn):
        '''
        Generate code to compute the expression.
        :param t: the expression tree
        :param minTempVarIndex: minimum index of a temp variable to use
        :param resultLoc: where to place the result. The result can be placed somewhere else (TODO).
        :param curFn: name of the current function.
        :return: the actual location of the result
        '''
        if isinstance(t, Value):
            src = t.resolveName(curFn, self.localVars, self.globalVars)
            return code.genMove(resultLoc, src)
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
                resultLoc, myCode = code.genUnary(t.data, resultLoc, rv)
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

                resultLoc, myCode = code.genBinary(t.data, resultLoc, rv1, rv2)
                return resultLoc, argCode1 + argCode2 + myCode
            else:
                raise ValueError("Too many children")

    def generateAssignment(self, l, r, curFn):
        '''
        Assignment. Possible cases:
        1. var = expression
            simply generate the expression into var
        2. *(e1) = e2
            generate e1 into tmp0 (address)
            generate e2 into tmp1
            put indirect tmp1 at tmp0
        3. var[e1] = e2
            generate e1 into tmp0
            tmp0 += var
            generate e2 into tmp1
            put indirect tmp1 at tmp0
        '''
        if isinstance(l, Value):
            # case 1: simple variable
            if not l.isLValue():
                raise ValueError("Cannot assign to an r-value")
            dest = l.resolveName(curFn, self.localVars, self.globalVars)
            _, codeExpr = self.generateExpression(r, 0, dest, "fn")
            return codeExpr
        elif l.data == 'deref':
            # case 2: dereferenced expression
            ptr = l.children[0]
            self.maxTempVarIndex = max(self.maxTempVarIndex, 1)
            rvPtr, codePtr = self.generateExpression(ptr, 0,
                        Value.variable(variable.getTempName(0)), curFn)
            rvR, codeR = self.generateExpression(r, 1,
                        Value.variable(variable.getTempName(1)), curFn)
            _, codePutIndirect = code.genPutIndirect(rvPtr, rvR)
            return codePtr + codeR + codePutIndirect
        elif l.data == 'subscript':
            # case 3: array subscript
            array = l.children[0].resolveName(curFn, self.localVars, self.globalVars)
            index = l.children[1]
            if not array.getType().isPointer():
                raise ValueError("Subscripting a non-pointer type")
            self.maxTempVarIndex = max(self.maxTempVarIndex, 1)
            rvIndex, codeIndex = self.generateExpression(index, 0,
                        Value.variable(variable.getTempName(0)), curFn)
            rvOffset, codeOffset = code.genMulConst(Value.variable(variable.getTempName(0)), rvIndex, array.getType().deref().getSize())
            rvR, codeR = self.generateExpression(r, 1,
                        Value.variable(variable.getTempName(1)), curFn)
            _, codePutIndirect = code.genPutIndirect(array, rvR, rvIndex)
            return codeIndex + codeOffset + codeR + codePutIndirect
        else:
            raise RuntimeError("Unknown assignment case")


    def generateFunction(self, t):
        if t.data == 'assignment':
            l, r = t.children
            return self.generateAssignment(l, r, "fn")
        elif t.data == 'decl_var':
            typ, nam = t.children
            self.localVars[str(nam)] = typ
            return ""
        elif t.data == 'def_var':
            type, name, r = t.children
            self.localVars[str(name)] = type
            _, code = self.generateExpression(r, 0, Value.variable(variable.getLocalName("fn", str(name)), type), "fn")
            return code
        elif t.data == 'start':
            return "".join(self.generateFunction(child) for child in t.children)
        elif t.data == 'block':
            return "".join(self.generateFunction(child) for child in t.children)


