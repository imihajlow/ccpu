#!/usr/bin/env python3
import signal

class DelayedKeyboardInterrupt:
    def __enter__(self):
        self.signal_received = False
        self.old_handler = signal.signal(signal.SIGINT, self.handler)

    def handler(self, sig, frame):
        self.signal_received = (sig, frame)

    def __exit__(self, type, value, traceback):
        signal.signal(signal.SIGINT, self.old_handler)
        if self.signal_received:
            self.old_handler(*self.signal_received)

def isAlu(b):
    return (b & 0x80) == 0

def isLd(b):
    return (b & 0xF0) == 0x80

def isSt(b):
    return (b & 0xF0) == 0xb0

def isLdi(b):
    return (b & 0xF0) == 0xa0

def isJc(b):
    return (b & 0xF8) == 0xc0

def isJmp(b):
    return (b & 0xF8) == 0xc8

def getDest(b):
    return b & 0x03

def getDestName(b, aIsZero=False):
    d = getDest(b)
    if d == 3:
        return "PH"
    elif d == 2:
        return "PL"
    elif d == 1:
        return "B"
    else:
        return "0" if aIsZero else "A"

def getSrc(b):
    return b & 0x01

def getSrcName(b):
    s = getSrc(b)
    if s == 1:
        return "B"
    else:
        return "A"

def getAluOp(b):
    op = (b >> 3) & 0x0f
    return ["ADD", "SUB", "ADC", "SBB", "INC", "DEC", "SHL", "NEG", "MOV", "NOT", "EXP", "AND", "OR", "XOR", "SHR", "SAR"][op]

def getFlag(b):
    return b & 0x03

def getFlagName(b):
    f = getFlag(b)
    return "ZCSO"[f]

def getOverflow(r, a, b, is_sum):
    r_bit = bool(r & 0x80)
    a_bit = bool(a & 0x80)
    b_bit = bool(b & 0x80)
    if not is_sum:
        b_bit = not b_bit
    if a_bit == b_bit:
        return a_bit != r_bit
    else:
        return False

def alu(op, a, b, carry_in, inverse):
    if inverse:
        a,b = b,a
    result = 0
    carry = False
    ovf = False

    if op == 'ADD':
        result = a + b
        carry = result > 255
        result = result & 0xff
        ovf = getOverflow(result, a, b, True)
    elif op == 'SUB':
        result = a - b
        carry = result < 0
        result = result & 0xff
        ovf = getOverflow(result, a, b, False)
    elif op == 'ADC':
        result = a + b + (1 if carry_in else 0)
        carry = result > 255
        result = result & 0xff
        ovf = getOverflow(result, a, b, True)
    elif op == 'SBB':
        result = a - b - (1 if carry_in else 0)
        carry = result < 0
        result = result & 0xff
        ovf = getOverflow(result, a, b, False)
    elif op == 'INC':
        result = a + 1
        carry = result > 255
        result = result & 0xff
        ovf = getOverflow(result, a, 1, True)
    elif op == 'DEC':
        result = a - 1
        carry = result < 0
        result = result & 0xff
        ovf = getOverflow(result, a, 1, False)
    elif op == 'SHL':
        result = a << 1
        carry = result > 255
        result = result & 0xff
    elif op == 'NEG':
        result = (-a) & 0xff
    elif op == 'MOV':
        result = b
    elif op == 'NOT':
        result = (~a) & 0xff
    elif op == 'EXP':
        result = 0xff if carry_in else 0
    elif op == 'AND':
        result = a & b
    elif op == 'OR':
        result = a | b
    elif op == 'XOR':
        result = a ^ b
    elif op == 'SHR':
        result = a >> 1
        carry = bool(a & 1)
    elif op == 'SAR':
        result = a / 2
        carry = bool(a & 1)
    else:
        raise ValueError("Invalid ALU: {}".format(op))
    zero = result == 0
    sign = bool(result & 0x80)
    return result, zero, carry, sign, ovf

def isSingleArgAlu(op):
    return op in ["INC", "DEC", "SHL", "SHR", "NEG", "NOT", "EXP", "SAR"]

class Machine:
    def __init__(self, memory):
        self.memory = memory
        self.ip = 0
        self.p = 0
        self.a = 0
        self.b = 0
        self.z = 0
        self.s = 0
        self.c = 0
        self.o = 0
        self.breakpoints = []

    def disasm(self, addr):
        b = self.memory.get(addr)
        if isAlu(b):
            inverse = bool(b & 0x04)
            op = getAluOp(b)
            singleArg = isSingleArgAlu(op)
            dest = getDestName(b, not inverse)
            if inverse:
                if singleArg:
                    return "{} {}".format(op, dest)
                else:
                    return "{} {}, A".format(op, dest)
            else:
                return "{} A, {}".format(op, dest)
        elif isLd(b):
            dest = getDestName(b)
            return "LD {}".format(dest)
        elif isSt(b):
            src = getSrcName(b)
            return "ST {}".format(src)
        elif isLdi(b):
            dest = getDestName(b)
            return "LDI {}, 0x{:02X}".format(dest, self.memory.get(addr + 1))
        elif isJmp(b):
            return "JMP"
        elif isJc(b):
            inverse = (b & 0x04) == 0x04
            return "J{}{}".format("N" if inverse else "", getFlagName(b))
        else:
            return "WTF (0x{:02X})".format(b)

    def printState(self):
        print("IP={:04X} P={:04X} A={:02X} B={:02X} F=[{}{}{}{}]    {}".format(self.ip, self.p, self.a, self.b, \
                                     "Z" if self.z else " ", "S" if self.s else " ", "C" if self.c else " ", "O" if self.o else " ",\
                                     self.disasm(self.ip)))

    def __assignRegister(self, r, v):
        if r == 0:
            self.a = v
        elif r == 1:
            self.b = v
        elif r == 2:
            self.p = (self.p & 0xff00) | v
        elif r == 3:
            self.p = (self.p & 0x00ff) | (v << 8)

    def __getRegister(self, r, aIsZero=False):
        return [0 if aIsZero else self.a, self.b, self.p & 0xff, self.p >> 8][r]

    def __getFlag(self, f):
        if f == 0:
            return self.z
        elif f == 1:
            return self.c
        elif f == 2:
            return self.s
        elif f == 3:
            return self.o

    def __incIp(self, v):
        self.ip = (self.ip + v) & 0xffff

    def addBreakpoint(self, address):
        self.breakpoints += [address]
        return len(self.breakpoints) - 1

    def step(self):
        b = self.memory.get(self.ip)
        if isAlu(b):
            inverse = bool(b & 0x04)
            op = getAluOp(b)
            dest = getDest(b)
            result, z, c, s, o = alu(op, self.a, self.__getRegister(dest, not inverse), self.c, inverse)
            if op != "MOV":
                self.z, self.c, self.s, self.o = z, c, s, o
            if inverse:
                self.__assignRegister(dest, result)
            else:
                self.a = result
            self.__incIp(1)
        elif isLd(b):
            dest = getDest(b)
            self.__assignRegister(dest, self.memory.get(self.p))
            self.__incIp(1)
        elif isSt(b):
            src = getSrc(b)
            self.memory.set(self.p, self.__getRegister(src))
            self.__incIp(1)
        elif isLdi(b):
            dest = getDest(b)
            self.__assignRegister(dest, self.memory.get(self.ip + 1))
            self.__incIp(2)
        elif isJmp(b):
            self.__incIp(1)
            self.ip, self.p = self.p, self.ip
        elif isJc(b):
            flag = getFlag(b)
            inverse = bool(b & 0x04)
            self.__incIp(1)
            if self.__getFlag(flag) != inverse:
                self.ip, self.p = self.p, self.ip
        else:
            raise ValueError("Invalid instruction 0x{:02X}".format(b))

    def run(self, until=None):
        self.memory.clearReachedWatch()
        try:
            while self.ip not in self.breakpoints and self.memory.getReachedWatch() is None and (until is None or self.ip != until):
                with DelayedKeyboardInterrupt():
                    self.step()
        except KeyboardInterrupt:
            return "interrupted", self.ip
        if self.memory.getReachedWatch() is not None:
            return "watch", self.memory.getReachedWatch()
        elif until is not None and self.ip == until:
            return "until", until
        else:
            return "break", self.breakpoints.index(self.ip)
