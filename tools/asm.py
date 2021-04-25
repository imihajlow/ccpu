#!/usr/bin/env python3
import argparse
import re
import sys
import json
from object import Object
from expression import evaluate

class AssemblyError(Exception):
    def __init__(self, line, reason):
        self.line = line
        self.reason = reason

    def __str__(self):
        return "Error at line {}: {}".format(self.line, self.reason)

def isJump(op):
    return op == 'jmp' or \
        op == 'jz' or \
        op == 'jnz' or \
        op == 'jc' or \
        op == 'jnc' or \
        op == 'js' or \
        op == 'jns' or \
        op == 'jo' or \
        op == 'jno'

def isAlu(op):
    return op == 'add' or \
        op == 'sub' or \
        op == 'adc' or \
        op == 'sbb' or \
        op == 'inc' or \
        op == 'dec' or \
        op == 'shl' or \
        op == 'neg' or \
        op == 'mov' or \
        op == 'not' or \
        op == 'exp' or \
        op == 'and' or \
        op == 'or' or \
        op == 'xor' or \
        op == 'shr' or \
        op == 'sar'

def isSingleArg(op):
    return op == 'ld' or \
        op == 'st' or \
        op == 'inc' or \
        op == 'dec' or \
        op == 'shl' or \
        op == 'neg' or \
        op == 'not' or \
        op == 'exp' or \
        op == 'shr' or \
        op == 'sar'

def char2len(c):
    return {"b": 1, "w": 2, "d": 4, "q": 8}[c]

def updateIp(op, args):
    if op is None:
        return 0
    op = op.lower()
    if op == '' or op is None:
        return 0
    elif op == 'ascii':
        return len(eval(args, {"__builtins__": {}}))
    elif op == 'ld' or op == 'st' or isJump(op) or isAlu(op):
        return 1
    elif op == 'ldi':
        return 2
    elif op == 'nop':
        return 1
    elif op == 'res':
        return eval(args, {"__builtins__": {}})
    elif op[0] == 'd':
        try:
            return char2len(op[1]) * (args.count(',') + 1)
        except KeyError:
            raise ValueError("Invalid opcode: {}".format(op))
    else:
        raise ValueError("Invalid opcode: {}".format(op))

def encodeSrc(reg):
    if reg == 'a' or reg == '0':
        return 0
    elif reg == 'b':
        return 1
    elif reg == 'pl':
        return 2
    elif reg == 'ph':
        return 3
    else:
        raise ValueError("Bad register `{}`".format(reg))

def encodeAlu(op, aluRevision):
    if aluRevision == 1:
        d = {
            'add': 0,
            'sub': 1,
            'adc': 2,
            'sbb': 3,
            'inc': 4,
            'dec': 5,
            'shl': 6,
            'neg': 7,
            'mov': 8,
            'not': 9,
            'exp': 10,
            'and': 11,
            'or':  12,
            'xor': 13,
            'shr': 14,
            'sar': 15,
        }
    elif aluRevision == 2:
        d = {
            'add': 9,
            'sub': 13,
            'adc': 10,
            'sbb': 14,
            'inc': 11,
            'dec': 15,
            'shl': 3,
            'neg': 12,
            'mov': 8,
            'not': 4,
            'exp': 0,
            'and': 1,
            'or':  2,
            'xor': 5,
            'shr': 6,
            'sar': 7,
        }
    else:
        raise RuntimeError("Bad ALU revision: {}".format(aluRevision))
    if op in d:
        return d[op]
    else:
        raise ValueError("Wrong instruction: {}".format(op))

def evalExpression(value, obj):
    # check if the expression is correct
    try:
        evaluate(value, obj.getMockGlobals(), obj.getMockLocals())
    except BaseException as e:
        raise ValueError(str(e))
    # evaluate without labels
    try:
        return evaluate(value), None
    except NameError as e:
        return 0, value
    except BaseException as e:
        raise ValueError("Error evaluating {}: {}".format(value, e))

def encodeFlag(f):
    if f == 'z':
        return 0
    elif f == 'c':
        return 1
    elif f == 's':
        return 2
    elif f == 'o':
        return 3
    else:
        raise ValueError("Wrong jump condition: {}".format(f))

# TODO use consts here for expressions?
def encode(op, args, obj, aluRevision):
    if isAlu(op):
        singleArg = isSingleArg(op)
        m = re.match(r"(a|b|ph|pl)\s*(?:,\s*(a|b|ph|pl|0))?", args)
        if m is None:
            raise ValueError("Invalid operands: {} {}".format(op, args))
        dst = m.group(1)
        src = dst if singleArg else m.group(2)
        straight = dst == 'a'
        inverse = not straight if singleArg else src == 'a'
        if straight == inverse:
            raise ValueError("Only one of {} operands should be A".format(op))
        return [(encodeAlu(op, aluRevision) << 3) | (4 if inverse else 0) | encodeSrc(dst if inverse else src)], []
    elif op == 'ld':
        return [0x80 | encodeSrc(args)], []
    elif op == 'st':
        if args != 'a' and args != 'b':
            raise ValueError("Invalid register for ST: {}. Only A or B are allowed".format(args))
        return [0xa0 | encodeSrc(args)], []
    elif op == 'ldi':
        m = re.match(r"(a|b|pl|ph)\s*,\s*(\S.*)", args)
        if m is None:
            raise ValueError("Invalid operands: {} {}".format(op, args))
        reg = m.group(1)
        value = m.group(2)
        static, dynamic = evalExpression(value, obj)
        if dynamic is None:
            return [0xc0 | encodeSrc(reg), static & 0xff], []
        else:
            return [0xc0 | encodeSrc(reg), 0], [(1,dynamic)]
    elif op[0] == 'j':
        if args:
            raise ValueError("Unexpected arguments for jump instruction")
        if op == 'jmp':
            return [0xe8], []
        else:
            if not (2 <= len(op) <= 3):
                raise ValueError("Invalid instruction {}".format(op))
            if len(op) == 3 and op[1] != 'n':
                raise ValueError("Invalid instruction {}".format(op))
            inverse = len(op) == 3
            flag = op[2] if inverse else op[1]
            return [0xe0 | (4 if inverse else 0) | encodeFlag(flag)], []
    elif op == 'nop':
        return [0xff], []
    elif op[0] == 'd':
        n = 0
        try:
            n = char2len(op[1])
        except KeyError:
            raise ValueError("Invalid opcode: {}".format(op))
        s = []
        d = []
        for k,expr in enumerate(args.split(',')):
            v, dynamic = evalExpression(expr, obj)
            if dynamic is None:
                s += [(v >> (8 * i)) & 0xff for i in range(n)]
            else:
                s += [0] * n
                d += [(k * n + i, "({}) >> {}".format(dynamic, 8 * i)) for i in range(n)]
        return s,d
    elif op == 'ascii':
        v = eval(args, {"__builtins__": {}})
        return [ord(c) for c in v], []
    elif op == 'res':
        return [0] * eval(args, {"__builtins__": {}}), []
    else:
        raise ValueError("Invalid opcode: {}".format(op))

def assemble(lines, aluRevision):
    result = Object()
    r = re.compile(r"^\s*(?:(?P<label>[_a-z]\w*)\s*:)?(?:\s*(?P<op>[.a-z]\w*)(?:\s+(?P<args>[a-z()0-9_+\-=*/><, \t\"'.?|^&]*[a-z()0-9_+\-=*/><,\"']))?)?(?:\s*;.*)?$", re.I)
    for i,l in enumerate(lines):
        line = l.strip()
        try:
            m = r.match(line)
            if m is None:
                raise ValueError("Syntax error")
            label = m.group('label')
            op = m.group('op')
            args = m.group('args')
            if label:
                result.defineLabel(label)
            if op == '.section':
                result.beginSection(args, 0)
            elif op == '.align':
                result.align(int(args, 0))
            elif op == '.offset':
                raise ValueError(".offset is not implemented")
            elif op == '.const':
                name, value = re.split(r"\s*=\s*", args, 1)
                result.defineConstant(name, eval(value, {"__builtins__": {}}))
            elif op == '.global':
                result.declareGlobal(args)
            elif op == '.export':
                pass
            elif op == '.source':
                result.setSource(args)
            elif op == '.line':
                result.setLineNumber(int(args, 0))
            else:
                result.advance(updateIp(op, args))
        except ValueError as e:
            raise AssemblyError(i + 1, e)
    result.allocate()
    for i,l in enumerate(lines):
        line = l.strip()
        try:
            m = r.match(line)
            if m is None:
                raise ValueError("Syntax error at line {}".format(i + 1))
            op = m.group('op')
            args = m.group('args')
            if op is None:
                continue
            op = op.lower()
            if op[0] == '.':
                if op == '.section':
                    result.beginSection(args, 0)
                elif op == '.align':
                    result.align(int(args, 0))
                elif op == '.export':
                    result.declareExport(args)
            else:
                text, refs = encode(op, args, result, aluRevision)
                result.placeValue(text)
                for offset, ref in refs:
                    result.placeExpression(offset, ref)
                result.advance(len(text))
        except ValueError as e:
            raise AssemblyError(i + 1, e)
    return result

def save(filename, o):
    with open(filename, "w") as file:
        file.write(json.dumps(o.toDict()))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Assembler')
    parser.add_argument('-o', metavar="RESULT", required=True, help='output file name')
    parser.add_argument('file', type=argparse.FileType("r"), help='input file name')
    parser.add_argument('-a', '--alu-revision', type=int, default=2, choices=[1,2], help='ALU revision (default = 2)')
    args = parser.parse_args()

    try:
        lines = args.file.readlines()
        o = assemble(lines, args.alu_revision)
        save(args.o, o)
    except AssemblyError as e:
        print(e)
        sys.exit(1)
