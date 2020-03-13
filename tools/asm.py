#!/usr/bin/env python3
import argparse
import re
import sys

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

def align(ip, base):
    return ((ip - 1) // base + 1) * base

def updateIp(ip, op, args):
    if op is None:
        return ip
    op = op.lower()
    if op == '' or op is None:
        return ip
    elif op == '.offset':
        return int(args, 0)
    elif op == '.align':
        return align(ip, int(args, 0))
    elif op == '.init' or op == '.noinit':
        return ip
    elif op == 'db':
        return ip + 1
    elif op == 'dw':
        return ip + 2
    elif op == 'dd':
        return ip + 4
    elif op == 'dq':
        return ip + 8
    elif op == 'ld' or op == 'st' or isJump(op) or isAlu(op):
        return ip + 1
    elif op == 'ldi':
        return ip + 2

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

def encodeAlu(op):
    if op == 'add':
        return 0
    if op == 'sub':
        return 1
    if op == 'adc':
        return 2
    if op == 'sbb':
        return 3
    if op == 'inc':
        return 4
    if op == 'dec':
        return 5
    if op == 'shl':
        return 6
    if op == 'neg':
        return 7
    if op == 'mov':
        return 8
    if op == 'not':
        return 9
    if op == 'exp':
        return 10
    if op == 'and':
        return 11
    if op == 'or':
        return  12
    if op == 'xor':
        return 13
    if op == 'shr':
        return 14
    if op == 'sar':
        return 15
    raise ValueError("Wrong instruction: {}".format(op))

def lo(x):
    return x & 0xff

def hi(x):
    return (x >> 8) & 0xff

def evalExpression(value, labels):
    try:
        return eval(value, {'lo': lo, 'hi': hi}, labels)
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

def encode(op, args, labels):
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
        return [(encodeAlu(op) << 3) | (4 if inverse else 0) | encodeSrc(dst if inverse else src)]
    elif op == 'ld':
        return [0x80 | encodeSrc(args)]
    elif op == 'st':
        if args != 'a' and args != 'b':
            raise ValueError("Invalid register for ST: {}. Only A or B are allowed".format(args))
        return [0xb0 | encodeSrc(args)]
    elif op == 'ldi':
        m = re.match(r"(a|b|pl|ph)\s*,\s*\b(.+)", args)
        if m is None:
            raise ValueError("Invalid operands: {} {}".format(op, args))
        reg = m.group(1)
        value = m.group(2)
        return [0xa0 | encodeSrc(reg), evalExpression(value, labels) & 0xff]
    elif op[0] == 'j':
        if args:
            raise ValueError("Unexpected arguments for jump instruction")
        if op == 'jmp':
            return [0xC8]
        else:
            if not (2 <= len(op) <= 3):
                raise ValueError("Invalid instruction {}".format(op))
            if len(op) == 3 and op[1] != 'n':
                raise ValueError("Invalid instruction {}".format(op))
            inverse = len(op) == 3
            flag = op[2] if inverse else op[1]
            return [0xc0 | (4 if inverse else 0) | encodeFlag(flag)]
    elif op == 'db':
        return [evalExpression(args, labels) & 0xff]
    elif op == 'dw':
        v = evalExpression(args, labels)
        return [v & 0xff, (v >> 8) & 0xff]
    elif op == 'dd':
        v = evalExpression(args, labels)
        return [v & 0xff, (v >> 8) & 0xff, (v >> 16) & 0xff, (v >> 24) & 0xff]
    elif op == 'dq':
        v = evalExpression(args, labels)
        return [v & 0xff, (v >> 8) & 0xff, (v >> 16) & 0xff, (v >> 24) & 0xff,\
            (v >> 32) & 0xff, (v >> 40) & 0xff, (v >> 48) & 0xff, (v >> 56) & 0xff]

def assemble(lines):
    r = re.compile(r"^\s*(?:(?P<label>[a-z]\w*)\s*:)?(?:\s*(?P<op>[.a-z]\w*)(?:\s+(?P<args>[a-z()0-9_+\-*/><, \t]*[a-z()0-9_+\-*/><,]))?)?(?:\s*;.*)?$", re.I)
    ip = 0
    labels = {}
    result = [None] * 65536
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
                if label in labels:
                    raise ValueError("Label redefinition: {}".format(label))
                labels[label] = ip
            ip = updateIp(ip, op, args)
            if ip >= 65536:
                raise ValueError("IP overflow")
            if ip < 0:
                raise ValueError("Negative IP")
        except BaseException as e:
            raise AssemblyError(i + 1, e)
    ip = 0
    init = True
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
            if op == '.init':
                init = True
            elif op == '.noinit':
                init = False
            elif op == '.align':
                pass
            elif op == '.offset':
                pass
            else:
                if init:
                    for offset,b in enumerate(encode(op, args, labels)):
                        result[ip + offset] = b
            ip = updateIp(ip, op, args)
        except BaseException as e:
            raise AssemblyError(i + 1, e)
    return result, labels

def save(data, filename, type, full, filler):
    mode = "wb" if type == "bin" else "w"
    with open(filename, mode) as file:
        if type == "hex":
            for i,x in enumerate(data[0:65536 if full else 32768]):
                if x is None:
                    file.write("xx")
                else:
                    file.write("{:02X}".format(x))
                if i % 16 == 15:
                    file.write("\n")
                else:
                    file.write(" ")
        elif type == "bin":
            ba = bytearray(filler if x is None else x for x in data[0:65536 if full else 32768])
            file.write(ba)

def saveLabels(file, labels):
    if file is not None:
        for label in labels:
            file.write("{} = 0x{:04x}\n".format(label, labels[label]))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Assembler')
    parser.add_argument('--full', required=False, default=False, action='store_true', help='generate full 64k or memory, otherwise just 32k for the ROM')
    parser.add_argument('--type', choices=["hex", "bin"], default="bin", help='output file type (default: bin)')
    parser.add_argument('--filler', type=int, default=0, help="value to fill uninitialized memory (bin output type only)")
    parser.add_argument('-m', metavar="MAPFILE", required=False, type=argparse.FileType("w"), help='map file name')
    parser.add_argument('-o', metavar="RESULT", required=True, help='output file name')
    parser.add_argument('file', type=argparse.FileType("r"), help='input file name')
    args = parser.parse_args()

    try:
        lines = args.file.readlines()
        code, labels = assemble(lines)
        save(code, args.o, args.type, args.full, args.filler)
        saveLabels(args.m, labels)
    except AssemblyError as e:
        print(e)
        sys.exit(1)
