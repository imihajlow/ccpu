from lark import Lark, Transformer, v_args, Tree
from exceptions import SemanticError
from value import Value
from type import Type, BoolType
from function import Function
import labelname

class Generator:
    def __init__(self, filename, callgraph, backend):
        self.maxTempVarIndex = -1
        self.paramVars = {} # name -> (type, index)
        self.localVars = {} # name -> type
        self.globalVars = {} # name -> type
        self.functions = {} # name -> Function
        self.labelIndex = 0
        self.breakLabel = [] # stack
        self.continueLabel = [] # stack
        self.callgraph = callgraph
        self.backend = backend

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
            src = t.resolveName(curFn, self.localVars, self.globalVars, self.paramVars)
            return self.backend.genMove(resultLoc, src, True)
        else:
            ch = t.children
            if len(ch) == 1:
                if isinstance(ch[0], Value):
                    argCode = ""
                    rv = ch[0].resolveName(curFn, self.localVars, self.globalVars, self.paramVars)
                else:
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                    rv, argCode = self.generateExpression(ch[0], minTempVarIndex,
                        Value.variable(labelname.getTempName(minTempVarIndex)), curFn)
                resultLoc, myCode = self.backend.genUnary(t.data, resultLoc, rv)
                return resultLoc, argCode + myCode
            elif t.data == "type_cast":
                if isinstance(ch[1], Value):
                    argCode = ""
                    rv = ch[1].resolveName(curFn, self.localVars, self.globalVars, self.paramVars)
                else:
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                    rv, argCode = self.generateExpression(ch[1], minTempVarIndex,
                        Value.variable(labelname.getTempName(minTempVarIndex)), curFn)
                resultLoc, myCode = self.backend.genCast(resultLoc, ch[0], rv)
                return resultLoc, argCode + myCode
            elif len(ch) == 2:
                hasFirstArg = False
                if isinstance(ch[0], Value):
                    rv1 = ch[0].resolveName(curFn, self.localVars, self.globalVars, self.paramVars)
                    argCode1 = ""
                else:
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                    rv1, argCode1 = self.generateExpression(ch[0], minTempVarIndex,
                        Value.variable(labelname.getTempName(minTempVarIndex)), curFn)
                    hasFirstArg = True

                if isinstance(ch[1], Value):
                    rv2 = ch[1].resolveName(curFn, self.localVars, self.globalVars, self.paramVars)
                    argCode2 = ""
                else:
                    indexIncrement = 1 if hasFirstArg else 0
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex + indexIncrement)
                    rv2, argCode2 = self.generateExpression(ch[1], minTempVarIndex + indexIncrement,
                        Value.variable(labelname.getTempName(minTempVarIndex + indexIncrement)), curFn)

                resultLoc, myCode = self.backend.genBinary(t.data, resultLoc, rv1, rv2)
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
            dest = l.resolveName(curFn, self.localVars, self.globalVars, self.paramVars)
            resultLoc, codeExpr = self.generateExpression(r, 0, dest, curFn)
            if resultLoc == dest:
                # already assigned where needed
                return codeExpr
            else:
                # need to copy
                _, codeMove = self.backend.genMove(dest, resultLoc, False)
                return codeExpr + codeMove
        elif l.data == 'deref':
            # case 2: dereferenced expression
            ptr = l.children[0]
            self.maxTempVarIndex = max(self.maxTempVarIndex, 1)
            rvPtr, codePtr = self.generateExpression(ptr, 0,
                        Value.variable(labelname.getTempName(0)), curFn)
            rvR, codeR = self.generateExpression(r, 1,
                        Value.variable(labelname.getTempName(1)), curFn)
            codePutIndirect = self.backend.genPutIndirect(rvPtr, rvR)
            return codePtr + codeR + codePutIndirect
        elif l.data == 'subscript':
            # case 3: array subscript
            array = l.children[0].resolveName(curFn, self.localVars, self.globalVars, self.paramVars)
            index = l.children[1]
            if not array.getType().isPointer():
                raise ValueError("Subscripting a non-pointer type")
            self.maxTempVarIndex = max(self.maxTempVarIndex, 1)
            rvIndex, codeIndex = self.generateExpression(index, 0,
                        Value.variable(labelname.getTempName(0)), curFn)
            rvOffset, codeOffset = self.backend.genMulConst(Value.variable(labelname.getTempName(0)), rvIndex, array.getType().deref().getSize())
            rvR, codeR = self.generateExpression(r, 1,
                        Value.variable(labelname.getTempName(1)), curFn)
            codePutIndirect = self.backend.genPutIndirect(array, rvR, rvIndex)
            return codeIndex + codeOffset + codeR + codePutIndirect
        else:
            raise RuntimeError("Unknown assignment case")

    def generateConditional(self, cond, ifBody, elseBody, curFn):
        labelEnd = self.allocLabel("if_end")
        if elseBody is not None:
            labelElse = self.allocLabel("if_else")
        self.maxTempVarIndex = max(self.maxTempVarIndex, 0)
        rvCond, codeCond = self.generateExpression(cond, 0, Value.variable(labelname.getTempName(0), BoolType()), curFn)
        codeIf = self.generateStatement(ifBody, curFn)
        if elseBody is not None:
            codeElse = self.generateStatement(elseBody, curFn)
        if elseBody is None:
            return codeCond + self.backend.genInvCondJump(rvCond, labelEnd) + codeIf + self.backend.genLabel(labelEnd)
        else:
            return codeCond + self.backend.genInvCondJump(rvCond, labelElse)\
                + codeIf + self.backend.genJump(labelEnd) + self.backend.genLabel(labelElse) + codeElse + self.backend.genLabel(labelEnd)

    def generateWhile(self, cond, body, curFn):
        labelBegin = self.allocLabel("while_begin")
        labelEnd = self.allocLabel("while_end")

        self.maxTempVarIndex = max(self.maxTempVarIndex, 0)
        rvCond, codeCond = self.generateExpression(cond, 0, Value.variable(labelname.getTempName(0), BoolType()), curFn)
        self.breakLabel = [labelEnd] + self.breakLabel
        self.continueLabel = [labelBegin] + self.continueLabel
        codeBody = self.generateStatement(body, curFn)
        self.breakLabel = self.breakLabel[1:]
        self.continueLabel = self.continueLabel[1:]
        return self.backend.genLabel(labelBegin) + codeCond + self.backend.genInvCondJump(rvCond, labelEnd)\
            + codeBody + self.backend.genJump(labelBegin) + self.backend.genLabel(labelEnd)

    def generateFunctionCall(self, name, args, curFn):
        if name not in self.functions:
            raise ValueError("Undefined function: {}".format(name))
        f = self.functions[name]
        if len(args) != len(f.args):
            raise ValueError("Incorrect argument count for {}".format(name))
        result = ""
        for n, expr in enumerate(args):
            result += self.generateAssignment(Value.variable(labelname.getArgumentName(name, n), f.args[n], final=True), expr, curFn)
        isRecursive = self.callgraph.isRecursive(curFn, name)
        if isRecursive:
            result += self.backend.genPushLocals(curFn)
        result += self.backend.genCall(name)
        if isRecursive:
            result += self.backend.genPopLocals(curFn)
        return result

    def generateFunctionAssignment(self, dest, name, args, curFn):
        codeCall = self.generateFunctionCall(name, args, curFn)
        f = self.functions[name]
        resultLoc = Value.variable(labelname.getReturnName(name), f.retType, final=True)
        return codeCall + self.generateAssignment(dest, resultLoc, curFn)


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
        elif t.data == 'break_statement':
            if len(self.breakLabel) == 0:
                raise SemanticError(t.line, "Not in a loop")
            return self.backend.genJump(self.breakLabel[0])
        elif t.data == 'continue_statement':
            if len(self.continueLabel) == 0:
                raise SemanticError(t.line, "Not in a loop")
            return self.backend.genJump(self.continueLabel[0])
        elif t.data == 'function_call':
            return self.generateFunctionCall(str(t.children[0]), t.children[1:], curFn)
        elif t.data == 'assignment_function':
            call = t.children[1]
            return self.generateFunctionAssignment(t.children[0], str(call.children[0]), call.children[1:], curFn)
        elif t.data == 'return_statement':
            dest = Value.variable(labelname.getReturnName(curFn), self.functions[curFn].retType, final=True)
            return self.generateAssignment(dest, t.children[0], curFn) + self.backend.genReturn(curFn)
        elif t.data == 'empty_return_statement':
            return self.backend.genReturn(curFn)

    def addFunctionDeclaration(self, attrs, type, name, args):
        f = Function(name, type, attrs, args)
        if name in self.functions and f != self.functions[name]:
            raise ValueError("Conflicting declarations of {}".format(name))
        self.functions[name] = f
        return f

    def generateFunctionDefinition(self, decl, body):
        attrs, type, name, args = decl.children
        name = str(name)
        args = args.children
        attrs = attrs.children
        f = self.addFunctionDeclaration(attrs, type, name, args)
        if f.isImported:
            raise ValueError("Cannot define an imported function")
        self.localVars = {}
        self.paramVars = {str(a.children[1]): (a.children[0], i) for i,a in enumerate(args)}
        result = self.backend.genFunctionPrologue(name)
        result += "".join(self.generateStatement(child, name) for child in body.children)
        result += self.backend.genReturn(name)
        f.localVars = self.localVars
        return result

    def generateToplevel(self, t):
        if t.data == 'function_definition':
            decl, body = t.children
            return self.generateFunctionDefinition(decl, body)
        elif t.data == 'function_declaration':
            attrs, type, name, args = t.children
            self.addFunctionDeclaration(attrs.children, type, str(name), args.children)
            return ""

    def generateStart(self, t):
        if t.data == 'start':
            return "".join(self.generateToplevel(child) for child in t.children)
        else:
            raise RuntimeError("Wrong root node")

    def getImports(self):
        for name in self.functions:
            f = self.functions[name]
            if f.isImported:
                yield name
                yield labelname.getReturnName(name)
                for n in range(len(f.args)):
                    yield labelname.getArgumentName(name, n)

    def getExports(self):
        for name in self.functions:
            f = self.functions[name]
            if f.isExported:
                yield name
                yield labelname.getReturnName(name)
                for n in range(len(f.args)):
                    yield labelname.getArgumentName(name, n)

    def generateFunctionReserve(self, fn):
        if fn.isImported:
            return ""
        result = self.backend.genLabel(labelname.getReserveBeginLabel(fn.name))
        result += self.backend.reserve(labelname.getReturnAddressLabel(fn.name), 2)
        result += self.backend.reserve(labelname.getReturnName(fn.name), 2)
        result += "".join(self.backend.reserve(labelname.getArgumentName(fn.name, i), 2) for i in range(len(fn.args)))
        result += "".join(self.backend.reserve(labelname.getLocalName(fn.name, v), 2) for v in fn.localVars)
        result += self.backend.genLabel(labelname.getReserveEndLabel(fn.name))
        return result

    def generateReserve(self):
        return self.backend.reserveTempVars(self.maxTempVarIndex) + "".join(self.generateFunctionReserve(self.functions[name]) for name in self.functions)

    def generate(self, t):
        execCode = self.generateStart(t)
        importCode = self.backend.dumpImports(self.getImports())
        exportCode = self.backend.dumpExports(self.getExports())
        reserveCode = self.generateReserve()

        return exportCode + importCode + self.backend.startCodeSection() + execCode + self.backend.startBssSection() + reserveCode
