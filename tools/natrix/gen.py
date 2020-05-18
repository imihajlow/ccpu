from lark import Lark, Transformer, v_args, Tree
from exceptions import SemanticError
from value import Value
from type import Type, BoolType
import variable
import code

class Generator:
    def __init__(self):
        self.maxTempVarIndex = 0
        self.localVars = {}
        self.globalVars = {}
        self.labelIndex = 0

    def allocLabel(self, comment):
        i = self.labelIndex
        self.labelIndex += 1
        return "__gen_{}_{}".format(i, comment)

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
            return code.genMove(resultLoc, src, True)
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
            elif t.data == "type_cast":
                if isinstance(ch[1], Value):
                    argCode = ""
                    rv = ch[1].resolveName(curFn, self.localVars, self.globalVars)
                else:
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                    rv, argCode = self.generateExpression(ch[1], minTempVarIndex,
                        Value.variable(variable.getTempName(minTempVarIndex)), curFn)
                resultLoc, myCode = code.genCast(resultLoc, ch[0], rv)
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
            resultLoc, codeExpr = self.generateExpression(r, 0, dest, "fn")
            if resultLoc == dest:
                # already assigned where needed
                return codeExpr
            else:
                # need to copy
                _, codeMove = code.genMove(dest, resultLoc, False)
                return codeExpr + codeMove
        elif l.data == 'deref':
            # case 2: dereferenced expression
            ptr = l.children[0]
            self.maxTempVarIndex = max(self.maxTempVarIndex, 1)
            rvPtr, codePtr = self.generateExpression(ptr, 0,
                        Value.variable(variable.getTempName(0)), curFn)
            rvR, codeR = self.generateExpression(r, 1,
                        Value.variable(variable.getTempName(1)), curFn)
            codePutIndirect = code.genPutIndirect(rvPtr, rvR)
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
            codePutIndirect = code.genPutIndirect(array, rvR, rvIndex)
            return codeIndex + codeOffset + codeR + codePutIndirect
        else:
            raise RuntimeError("Unknown assignment case")

    def generateConditional(self, cond, ifBody, elseBody, curFn):
        labelEnd = self.allocLabel("if_end")
        if elseBody is not None:
            labelElse = self.allocLabel("if_else")
        self.maxTempVarIndex = max(self.maxTempVarIndex, 0)
        rvCond, codeCond = self.generateExpression(cond, 0, Value.variable(variable.getTempName(0), BoolType()), curFn)
        codeIf = self.generateStatement(ifBody, curFn)
        if elseBody is not None:
            codeElse = self.generateStatement(elseBody, curFn)
        if elseBody is None:
            return codeCond + code.genInvCondJump(rvCond, labelEnd) + codeIf + code.genLabel(labelEnd)
        else:
            return codeCond + code.genInvCondJump(rvCond, labelElse)\
                + codeIf + code.genJump(labelEnd) + code.genLabel(labelElse) + codeElse + code.genLabel(labelEnd)

    def generateWhile(self, cond, body, curFn):
        labelBegin = self.allocLabel("while_begin")
        labelEnd = self.allocLabel("while_end")

        self.maxTempVarIndex = max(self.maxTempVarIndex, 0)
        rvCond, codeCond = self.generateExpression(cond, 0, Value.variable(variable.getTempName(0), BoolType()), curFn)
        codeBody = self.generateStatement(body, curFn)
        return code.genLabel(labelBegin) + codeCond + code.genInvCondJump(rvCond, labelEnd)\
            + codeBody + code.genJump(labelBegin) + code.genLabel(labelEnd)

    def generateStatement(self, t, curFn):
        if t.data == 'assignment':
            l, r = t.children
            return self.generateAssignment(l, r, curFn)
        elif t.data == 'decl_var':
            typ, nam = t.children
            self.localVars[str(nam)] = typ
            return ""
        elif t.data == 'def_var':
            type, name, r = t.children
            self.localVars[str(name)] = type
            dest = Value.variable(str(name))
            return self.generateAssignment(dest, r, curFn)
        elif t.data == 'block':
            return "".join(self.generateStatement(child, curFn) for child in t.children)
        elif t.data == 'conditional':
            return self.generateConditional(t.children[0], t.children[1], t.children[2] if len(t.children) == 3 else None, curFn)
        elif t.data == 'while_loop':
            return self.generateWhile(t.children[0], t.children[1], curFn)

    def generateStart(self, t):
        if t.data == 'start':
            return "".join(self.generateStatement(child, "fn") for child in t.children)

