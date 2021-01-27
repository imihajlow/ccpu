from lark import Lark, Transformer, v_args, Tree
from exceptions import SemanticError
from value import Value
from type import Type, BoolType, UnknownType, PtrType
from function import Function
from location import Location
import structure
import labelname
import sys

class Generator:
    def __init__(self, callgraph, literalPool, nameInfo, backend):
        self.maxTempVarIndex = -1
        self.labelIndex = 0
        self.breakLabel = [] # stack
        self.continueLabel = [] # stack
        self.callgraph = callgraph
        self.backend = backend
        self.literalPool = literalPool
        self.nameInfo = nameInfo

    def allocLabel(self, comment):
        i = self.labelIndex
        self.labelIndex += 1
        return labelname.getGenLabel(i, comment)

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
            return self.backend.genMove(resultLoc, t, True)
        else:
            ch = t.children
            if len(ch) == 1:
                if isinstance(ch[0], Value):
                    argCode = ""
                    rv = ch[0]
                else:
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                    rv, argCode = self.generateExpression(ch[0], minTempVarIndex,
                        Value.variable(Location.fromAny(ch[0]), labelname.getTempName(minTempVarIndex)), curFn)
                resultLoc, myCode = self.backend.genUnary(t.data, resultLoc, rv)
                return resultLoc, argCode + myCode
            elif t.data == "type_cast":
                if isinstance(ch[1], Value):
                    argCode = ""
                    rv = ch[1]
                else:
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                    rv, argCode = self.generateExpression(ch[1], minTempVarIndex,
                        Value.variable(Location.fromAny(ch[1]), labelname.getTempName(minTempVarIndex)), curFn)
                resultLoc, myCode = self.backend.genCast(resultLoc, ch[0], rv)
                return resultLoc, argCode + myCode
            elif t.data == "arrow":
                ptr = ch[0]
                fields = ch[1:]
                self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                rv, argCode = self.generateExpression(ptr, minTempVarIndex,
                    Value.variable(Location.fromAny(ptr), labelname.getTempName(minTempVarIndex)), curFn)
                offset, type = structure.getField(rv.getType().deref(), fields)
                resultLoc, derefCode = self.backend.genDeref(resultLoc.withType(type), rv, offset)
                return resultLoc, argCode + derefCode
            elif t.data == "p_arrow":
                ptr = ch[0]
                fields = ch[1:]
                self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                rv, argCode = self.generateExpression(ptr, minTempVarIndex, resultLoc.withType(UnknownType()), curFn)
                offset, type = structure.getField(rv.getType().deref(), fields)
                rv, offsetCode = self.backend.genAddPointerOffset(resultLoc.withType(PtrType(type)), rv.withType(PtrType(type)), offset)
                return rv, argCode + offsetCode
            elif len(ch) == 2:
                hasFirstArg = False
                if isinstance(ch[0], Value):
                    rv1 = ch[0]
                    argCode1 = ""
                else:
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                    rv1, argCode1 = self.generateExpression(ch[0], minTempVarIndex,
                        Value.variable(Location.fromAny(ch[0]), labelname.getTempName(minTempVarIndex)), curFn)
                    hasFirstArg = True

                if isinstance(ch[1], Value):
                    rv2 = ch[1]
                    argCode2 = ""
                else:
                    indexIncrement = 1 if hasFirstArg else 0
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex + indexIncrement)
                    rv2, argCode2 = self.generateExpression(ch[1], minTempVarIndex + indexIncrement,
                        Value.variable(Location.fromAny(ch[1]), labelname.getTempName(minTempVarIndex + indexIncrement)), curFn)

                resultLoc, myCode = self.backend.genBinary(t.data, resultLoc, rv1, rv2, self)
                return resultLoc, argCode1 + argCode2 + myCode
            else:
                raise RuntimeError("Too many children")

    def generateAssignment(self, l, r, curFn):
        '''
        Assignment. Possible cases:
        1. var = expression
            simply generate the expression into var
        2. *(e1) = e2
            generate e1 into tmp0 (address)
            generate e2 into tmp1
            put indirect tmp1 at tmp0
        3. (*var).field = expression
        '''
        if isinstance(l, Value):
            # case 1: simple variable
            if not l.isLValue():
                raise SemanticError(l.getLocation(), "Cannot assign to an r-value")
            dest = l
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
                        Value.variable(Location.fromAny(ptr), labelname.getTempName(0)), curFn)
            rvR, codeR = self.generateExpression(r, 1,
                        Value.variable(Location.fromAny(r), labelname.getTempName(1)), curFn)
            codePutIndirect = self.backend.genPutIndirect(rvPtr, rvR)
            return codePtr + codeR + codePutIndirect
        elif l.data == 'arrow':
            # case 3: member of a derefed struct
            ptr = l.children[0]
            fields = l.children[1:]
            self.maxTempVarIndex = max(self.maxTempVarIndex, 1)
            rvPtr, codePtr = self.generateExpression(ptr, 0,
                Value.variable(Location.fromAny(ptr), labelname.getTempName(0)), curFn)
            offset, type = structure.getField(rvPtr.getType().deref(), fields)
            rvR, codeR = self.generateExpression(r, 1,
                                    Value.variable(Location.fromAny(r), labelname.getTempName(1)), curFn)
            codePutIndirect = self.backend.genPutIndirect(rvPtr.withType(PtrType(type)), rvR, offset)
            return codePtr + codeR + codePutIndirect
        else:
            raise RuntimeError("Unknown assignment case")

    def generateConditional(self, cond, ifBody, elseBody, curFn):
        labelEnd = self.allocLabel("if_end")
        if elseBody is not None:
            labelElse = self.allocLabel("if_else")
        self.maxTempVarIndex = max(self.maxTempVarIndex, 0)
        rvCond, codeCond = self.generateExpression(cond, 0,
            Value.variable(Location.fromAny(cond), labelname.getTempName(0), BoolType()), curFn)
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
        rvCond, codeCond = self.generateExpression(cond, 0,
            Value.variable(Location.fromAny(cond), labelname.getTempName(0), BoolType()), curFn)
        self.breakLabel = [labelEnd] + self.breakLabel
        self.continueLabel = [labelBegin] + self.continueLabel
        codeBody = self.generateStatement(body, curFn)
        self.breakLabel = self.breakLabel[1:]
        self.continueLabel = self.continueLabel[1:]
        return self.backend.genLabel(labelBegin) + codeCond + self.backend.genInvCondJump(rvCond, labelEnd)\
            + codeBody + self.backend.genJump(labelBegin) + self.backend.genLabel(labelEnd)

    def generateFunctionCall(self, location, name, args, curFn):
        if name not in self.nameInfo.functions:
            raise SemanticError(location, "Undefined function: {}".format(name))
        f = self.nameInfo.functions[name]
        if len(args) != len(f.args):
            raise SemanticError(location, "Incorrect argument count for {}".format(name))
        result = ""
        for n, expr in enumerate(args):
            result += self.generateAssignment(
                Value.variable(Location.fromAny(expr), labelname.getArgumentName(name, n), f.args[n]), expr, curFn)
        isRecursive = self.callgraph.isRecursive(curFn, name)
        if isRecursive:
            sys.stderr.write("Warning: {}: recursion\n".format(location)) # TODO warning function in a different module
        if isRecursive:
            result += self.backend.genPushLocals(curFn)
        result += self.backend.genCall(name)
        if isRecursive:
            result += self.backend.genPopLocals(curFn)
        return result

    def generateFunctionAssignment(self, lloc, rloc, dest, name, args, curFn):
        codeCall = self.generateFunctionCall(rloc, name, args, curFn)
        f = self.nameInfo.functions[name]
        resultLoc = Value.variable(rloc, labelname.getReturnName(name), f.retType)
        return codeCall + self.generateAssignment(dest, resultLoc, curFn)

    def generateStatement(self, t, curFn):
        if t.data == 'assignment':
            l, r = t.children
            return self.generateAssignment(l, r, curFn)
        elif t.data == 'decl_var':
            return ""
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
            return self.generateFunctionCall(Location.fromAny(t), str(t.children[0]), t.children[1:], curFn)
        elif t.data == 'assignment_function':
            call = t.children[1]
            return self.generateFunctionAssignment(Location.fromAny(t.children[0]), Location.fromAny(call),
                t.children[0], str(call.children[0]), call.children[1:], curFn)
        elif t.data == 'return_statement':
            dest = Value.variable(Location.fromAny(t), labelname.getReturnName(curFn), self.nameInfo.functions[curFn].retType)
            return self.generateAssignment(dest, t.children[0], curFn) + self.backend.genReturn(curFn)
        elif t.data == 'empty_return_statement':
            return self.backend.genReturn(curFn)
        elif t.data == 'return_fc_statement':
            call = t.children[0]
            dest = Value.variable(Location.fromAny(t), labelname.getReturnName(curFn), self.nameInfo.functions[curFn].retType)
            callCode = self.generateFunctionAssignment(Location.fromAny(t), Location.fromAny(call),
                dest, str(call.children[0]), call.children[1:], curFn)
            retCode = self.backend.genReturn(curFn)
            return callCode + retCode

    def generateFunctionDefinition(self, decl, body):
        name = str(decl.children[2])
        result = self.backend.genFunctionPrologue(name)
        result += "".join(self.generateStatement(child, name) for child in body.children)
        result += self.backend.genReturn(name)
        return result

    def generateToplevel(self, t):
        if t.data == 'function_definition':
            decl, body = t.children
            return self.generateFunctionDefinition(decl, body)
        else:
            return ""

    def generateStart(self, t):
        if t.data == 'start':
            return "".join(self.generateToplevel(child) for child in t.children)
        else:
            raise RuntimeError("Wrong root node")

    def getImports(self):
        for name in self.nameInfo.functions:
            f = self.nameInfo.functions[name]
            if f.isImported:
                yield name
                yield labelname.getReturnName(name)
                for n in range(len(f.args)):
                    yield labelname.getArgumentName(name, n)
        for name in self.nameInfo.varImports:
            yield name

    def getExports(self):
        for name in self.nameInfo.functions:
            f = self.nameInfo.functions[name]
            if f.isExported:
                yield name
                yield labelname.getReturnName(name)
                for n in range(len(f.args)):
                    yield labelname.getArgumentName(name, n)
        for name in self.nameInfo.varExports:
            yield name

    def generateFunctionReserve(self, fn):
        if fn.isImported:
            return ""
        result = self.backend.genLabel(labelname.getReserveBeginLabel(fn.name))
        result += self.backend.reserve(labelname.getReturnAddressLabel(fn.name), 2)
        result += "".join(self.backend.reserve(labelname.getArgumentName(fn.name, i), 2) for i in range(len(fn.args)))
        result += "".join(self.backend.reserveVar(labelname.getLocalName(fn.name, v), fn.localVars[v]) for v in fn.localVars)
        result += self.backend.genLabel(labelname.getReserveEndLabel(fn.name))
        result += self.backend.reserve(labelname.getReturnName(fn.name), 2)
        return result

    def generateReserve(self):
        return self.backend.reserveTempVars(self.maxTempVarIndex) + "".join(self.generateFunctionReserve(self.nameInfo.functions[name]) for name in self.nameInfo.functions) \
            + self.backend.reserveGlobalVars(self.nameInfo.globalVars, self.nameInfo.varImports)

    def generate(self, t):
        execCode = self.generateStart(t)
        importCode = self.backend.dumpImports(self.getImports())
        exportCode = self.backend.dumpExports(self.getExports())
        reserveCode = self.generateReserve()
        literalsCode = self.backend.dumpLiterals(self.literalPool)

        return exportCode + importCode + self.backend.startCodeSection() + execCode + literalsCode + self.backend.startBssSection() + reserveCode
