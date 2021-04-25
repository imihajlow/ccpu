from lark import Lark, Transformer, v_args, Tree
from exceptions import SemanticError, RegisterNotSupportedError
from value import Value
from type import Type, BoolType, UnknownType, PtrType
from function import Function
from position import Position
import structure
import labelname
import sys
import random

def randomString(n):
    return "".join(chr(x) for x in random.choices(range(ord('A'), ord('Z') + 1), k=n))

class Generator:
    def __init__(self, callgraph, literalPool, nameInfo, backend, createSubsections, lineInfo):
        self.maxTempVarIndex = -1
        self.labelIndex = 0
        self.breakLabel = [] # stack
        self.continueLabel = [] # stack
        self.callgraph = callgraph
        self.backend = backend
        self.literalPool = literalPool
        self.nameInfo = nameInfo
        self.createSubsections = createSubsections
        self.uniqueId = randomString(10)
        self.lineInfo = lineInfo

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
        try:
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
                            Value.variable(Position.fromAny(ch[0]), labelname.getTempName(minTempVarIndex)), curFn)
                    resultLoc, myCode = self.backend.genUnary(t.data, resultLoc, rv)
                    return resultLoc, argCode + myCode
                elif t.data == "type_cast":
                    if isinstance(ch[1], Value):
                        argCode = ""
                        rv = ch[1]
                    else:
                        self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                        rv, argCode = self.generateExpression(ch[1], minTempVarIndex,
                            Value.variable(Position.fromAny(ch[1]), labelname.getTempName(minTempVarIndex)), curFn)
                    resultLoc, myCode = self.backend.genCast(resultLoc, ch[0], rv)
                    return resultLoc, argCode + myCode
                elif t.data == "arrow":
                    ptr = ch[0]
                    fields = ch[1:]
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                    rv, argCode = self.generateExpression(ptr, minTempVarIndex,
                        Value.variable(Position.fromAny(ptr), labelname.getTempName(minTempVarIndex)), curFn)
                    offset, type = structure.getField(rv.getType().deref(), fields)
                    if type.getIndirectionOffset() == 0:
                        resultLoc, derefCode = self.backend.genDeref(resultLoc.withType(type), rv, offset)
                        return resultLoc, argCode + derefCode
                    elif type.getIndirectionOffset() == -1:
                        rv, offsetCode = self.backend.genAddPointerOffset(resultLoc.withType(type), rv.withType(type), offset)
                        return rv, argCode + offsetCode
                    else:
                        raise RuntimeError("Wrong indirection offset")
                elif t.data == "p_arrow":
                    ptr = ch[0]
                    fields = ch[1:]
                    self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                    rv, argCode = self.generateExpression(ptr, minTempVarIndex, resultLoc.withType(UnknownType()), curFn)
                    offset, type = structure.getField(rv.getType().deref(), fields)
                    if type.getIndirectionOffset() < 0:
                        raise SemanticError(Position.fromAny(t), "Cannot get address")
                    rv, offsetCode = self.backend.genAddPointerOffset(resultLoc.withType(PtrType(type)), rv.withType(PtrType(type)), offset)
                    return rv, argCode + offsetCode
                elif len(ch) == 2:
                    hasFirstArg = False
                    if isinstance(ch[0], Value):
                        rv1 = ch[0]
                        argCode1 = ""
                    else:
                        self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex)
                        tmp0 = Value.variable(Position.fromAny(ch[0]), labelname.getTempName(minTempVarIndex))
                        rv1, argCode1 = self.generateExpression(ch[0], minTempVarIndex, tmp0, curFn)
                        hasFirstArg = True

                    if isinstance(ch[1], Value):
                        rv2 = ch[1]
                        argCode2 = ""
                    else:
                        indexIncrement = 1 if hasFirstArg else 0
                        self.maxTempVarIndex = max(self.maxTempVarIndex, minTempVarIndex + indexIncrement)
                        tmp1 = Value.variable(Position.fromAny(ch[1]), labelname.getTempName(minTempVarIndex + indexIncrement))
                        rv2, argCode2 = self.generateExpression(ch[1], minTempVarIndex + indexIncrement, tmp1, curFn)
                        if rv1.getSource().isRegister():
                            rv1, moveCode = self.backend.genMove(tmp0, rv1, False)
                            argCode1 += moveCode

                    try:
                        resultLoc, myCode = self.backend.genBinary(t.data, resultLoc, rv1, rv2, self)
                    except RegisterNotSupportedError as e:
                        if e.argNumber == 0:
                            rv1, moveCode = self.backend.genMove(tmp0, rv1, False)
                            argCode1 += moveCode
                        elif e.argNumber == 1:
                            rv2, moveCode = self.backend.genMove(tmp1, rv2, False)
                            argCode2 += moveCode
                        else:
                            raise
                        resultLoc, myCode = self.backend.genBinary(t.data, resultLoc, rv1, rv2, self)
                    return resultLoc, argCode1 + argCode2 + myCode
                else:
                    raise RuntimeError("Too many children")
        except LookupError as e:
            raise SemanticError(Position.fromAny(t), str(e))
        except ValueError as e:
            raise SemanticError(Position.fromAny(t), str(e))

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
                raise SemanticError(l.getPosition(), "Cannot assign to an r-value")
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
                        Value.variable(Position.fromAny(ptr), labelname.getTempName(0)), curFn)
            assert(not rvPtr.getSource().isRegister())
            rvR, codeR = self.generateExpression(r, 1,
                        Value.variable(Position.fromAny(r), labelname.getTempName(1)), curFn)
            codePutIndirect = self.backend.genPutIndirect(rvPtr, rvR)
            return codePtr + codeR + codePutIndirect
        elif l.data == 'arrow':
            # case 3: member of a derefed struct
            ptr = l.children[0]
            fields = l.children[1:]
            self.maxTempVarIndex = max(self.maxTempVarIndex, 1)
            rvPtr, codePtr = self.generateExpression(ptr, 0,
                Value.variable(Position.fromAny(ptr), labelname.getTempName(0)), curFn)
            assert(not rvPtr.getSource().isRegister())
            offset, type = structure.getField(rvPtr.getType().deref(), fields)
            if type.getIndirectionOffset() < 0:
                raise SemanticError(Position.fromAny(l), "Cannot assign to an r-value")
            rvR, codeR = self.generateExpression(r, 1,
                                    Value.variable(Position.fromAny(r), labelname.getTempName(1)), curFn)
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
            Value.variable(Position.fromAny(cond), labelname.getTempName(0), BoolType()), curFn)
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
            Value.variable(Position.fromAny(cond), labelname.getTempName(0), BoolType()), curFn)
        self.breakLabel = [labelEnd] + self.breakLabel
        self.continueLabel = [labelBegin] + self.continueLabel
        codeBody = self.generateStatement(body, curFn)
        self.breakLabel = self.breakLabel[1:]
        self.continueLabel = self.continueLabel[1:]
        return self.backend.genLabel(labelBegin) + codeCond + self.backend.genInvCondJump(rvCond, labelEnd)\
            + codeBody + self.backend.genJump(labelBegin) + self.backend.genLabel(labelEnd)

    def generateFor(self, prolog, cond, iteration, body, curFn):
        if prolog.data != 'for_prolog':
            codeProlog = self.generateStatement(prolog, curFn)
        else:
            codeProlog = ""

        hasIterationCode = iteration.data != "for_iteration"

        labelBegin = self.allocLabel("for_begin")
        labelEnd = self.allocLabel("for_end")
        if hasIterationCode:
            labelContinue = self.allocLabel("for_continue")
        else:
            labelContinue = labelBegin

        if isinstance(cond, Value) or cond.data != 'for_condition':
            self.maxTempVarIndex = max(self.maxTempVarIndex, 0)
            rvCond, codeCond = self.generateExpression(cond, 0,
                Value.variable(Position.fromAny(cond), labelname.getTempName(0), BoolType()), curFn)
            codeCond += self.backend.genInvCondJump(rvCond, labelEnd)
        else:
            codeCond = ""

        self.breakLabel = [labelEnd] + self.breakLabel
        self.continueLabel = [labelContinue] + self.continueLabel
        codeBody = self.generateStatement(body, curFn)
        self.breakLabel = self.breakLabel[1:]
        self.continueLabel = self.continueLabel[1:]
        if hasIterationCode:
            codeIter = self.backend.genLabel(labelContinue)
            codeIter += self.generateStatement(iteration, curFn)
            codeIter += self.backend.genJump(labelBegin)
        else:
            codeIter = self.backend.genJump(labelBegin)
        return codeProlog + self.backend.genLabel(labelBegin) + codeCond\
            + codeBody + codeIter + self.backend.genLabel(labelEnd)

    def generateFunctionCall(self, position, name, args, curFn):
        if name not in self.nameInfo.functions:
            raise SemanticError(position, "Undefined function: {}".format(name))
        f = self.nameInfo.functions[name]
        if len(args) != len(f.args):
            raise SemanticError(position, "Incorrect argument count for {}".format(name))
        result = ""
        for n, expr in enumerate(args):
            result += self.generateAssignment(
                Value.variable(Position.fromAny(expr), labelname.getArgumentName(name, n), f.args[n]), expr, curFn)
        isRecursive = self.callgraph.isRecursive(curFn, name)
        if isRecursive:
            sys.stderr.write("Warning: {}: recursion\n".format(position)) # TODO warning function in a different module
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
        pos = Position.fromAny(t)
        f, l = self.lineInfo.translatePosition(pos)
        result = self.backend.sourceFilename(f)
        result += self.backend.lineNumber(l)
        if t.data == 'assignment':
            l, r = t.children
            result += self.generateAssignment(l, r, curFn)
        elif t.data == 'decl_var':
            result += ""
        elif t.data == 'block':
            result += "".join(self.generateStatement(child, curFn) for child in t.children)
        elif t.data == 'conditional':
            result += self.generateConditional(t.children[0], t.children[1], t.children[2] if len(t.children) == 3 else None, curFn)
        elif t.data == 'while_loop':
            result += self.generateWhile(t.children[0], t.children[1], curFn)
        elif t.data == 'for_loop':
            result += self.generateFor(t.children[0], t.children[1], t.children[2], t.children[3], curFn)
        elif t.data == 'break_statement':
            if len(self.breakLabel) == 0:
                raise SemanticError(t.line, "Not in a loop")
            result += self.backend.genJump(self.breakLabel[0])
        elif t.data == 'continue_statement':
            if len(self.continueLabel) == 0:
                raise SemanticError(t.line, "Not in a loop")
            result += self.backend.genJump(self.continueLabel[0])
        elif t.data == 'function_call':
            result += self.generateFunctionCall(Position.fromAny(t), str(t.children[0]), t.children[1:], curFn)
        elif t.data == 'assignment_function':
            call = t.children[1]
            result += self.generateFunctionAssignment(Position.fromAny(t.children[0]), Position.fromAny(call),
                t.children[0], str(call.children[0]), call.children[1:], curFn)
        elif t.data == 'return_statement':
            dest = Value.variable(Position.fromAny(t), labelname.getReturnName(curFn), self.nameInfo.functions[curFn].retType)
            result += self.generateAssignment(dest, t.children[0], curFn) + self.backend.genReturn(curFn)
        elif t.data == 'empty_return_statement':
            result += self.backend.genReturn(curFn)
        elif t.data == 'return_fc_statement':
            call = t.children[0]
            dest = Value.variable(Position.fromAny(t), labelname.getReturnName(curFn), self.nameInfo.functions[curFn].retType)
            callCode = self.generateFunctionAssignment(Position.fromAny(t), Position.fromAny(call),
                dest, str(call.children[0]), call.children[1:], curFn)
            retCode = self.backend.genReturn(curFn)
            result += callCode + retCode
        return result

    def generateFunctionDefinition(self, decl, body):
        name = str(decl.children[2])
        section = self.nameInfo.functions[name].section
        result = f"; ====== function {name} =======\n"
        if self.createSubsections:
            result += self.backend.startSection(f"{section}.{self.uniqueId}_{name}")
        else:
            result += self.backend.startSection(section)
        result += self.backend.genFunctionPrologue(name)
        result += "".join(self.generateStatement(child, name) for child in body.children)
        result += self.backend.genReturn(name)
        result += f"; ====== end function {name} ===\n"
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
        result = self.backend.reserveBlock(labelname.getReserveBeginLabel(fn.name),
            [(labelname.getReturnAddressLabel(fn.name), 2)] +
            [(labelname.getArgumentName(fn.name, i), fn.args[i].getReserveSize()) for i in range(len(fn.args))] +
            [(labelname.getLocalName(fn.name, v), fn.localVars[v].getReserveSize()) for v in fn.localVars],
            self.uniqueId, f"{fn.name}_frame", self.createSubsections)
        result += self.backend.genLabel(labelname.getReserveEndLabel(fn.name))
        result += self.backend.reserve(labelname.getReturnName(fn.name), fn.retType.getReserveSize(),
            "bss", self.uniqueId, self.createSubsections)
        return result

    def generateReserve(self):
        return self.backend.reserveTempVars(self.maxTempVarIndex, self.uniqueId, self.createSubsections) +\
            "".join(self.generateFunctionReserve(self.nameInfo.functions[name]) for name in self.nameInfo.functions) \
            + self.backend.reserveGlobalVars(self.nameInfo.globalVars, self.nameInfo.varImports, self.uniqueId, self.createSubsections)

    def generate(self, t):
        execCode = self.generateStart(t)
        importCode = self.backend.dumpImports(self.getImports())
        exportCode = self.backend.dumpExports(self.getExports())
        reserveCode = self.generateReserve()
        literalsCode = self.backend.dumpLiterals(self.literalPool, self.uniqueId, self.createSubsections)

        return exportCode + importCode + execCode + literalsCode + reserveCode
