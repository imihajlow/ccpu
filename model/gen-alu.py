#!/usr/bin/env python3
bits = 15

def encode_address(a, b, op, invert, from_other, carry):
    return a | (b << 4) | (op << 8) | (carry << 12) | (from_other << 13) | (invert << 14)

def encode_result(r, carry, to_other, overflow):
    return r | (carry << 4) | (to_other << 5) | (overflow << 6)


# ALU operations:
ADD = 0  # a + b
SUB = 1  # a - b
ADC = 2  # a + b + c
SBB = 3  # a - b - c
INC = 4  # a + 1
DEC = 5  # a - 1
SHL = 6  # a << 1
NEG = 7  # -a
MOV = 8  # a
NOT = 9  # ~a
EXP = 10 # c ? 0xff : 0x00
AND = 11 # a & b
OR  = 12 # a | b
XOR = 13 # a ^ b
SHR = 14 # a >> 1, zero extended
SAR = 15 # a >> 1, sign extended

def get_result_lo(a, b, op, invert, from_other, carry):
    r = 0
    carry_out = 0
    to_other = 0
    if op == ADD:
        r = a + b
        to_other = 1 if r > 15 else 0
        r = r & 15
    elif op == ADC:
        r = a + b + carry
        to_other = 1 if r > 15 else 0
        r = r & 15
    elif op == SUB:
        r = a - b
        to_other = 1 if r < 0 else 0
        if r < 0:
            r += 16
    elif op == SBB:
        r = a - b - carry
        to_other = 1 if r < 0 else 0
        if r < 0:
            r += 16
    elif op == INC:
        r = a + 1
        to_other = 1 if r > 15 else 0
        r = r & 15
    elif op == DEC:
        r = a - 1
        to_other = 1 if r < 0 else 0
        if r < 0:
            r += 16
    elif op == SHL:
        r = a << 1
        to_other = 1 if r > 15 else 0
        r = r & 15
    elif op == EXP:
        r = 15 if carry == 1 else 0
    elif op == MOV:
        r = a
    elif op == NOT:
        r = (~a) & 15
    elif op == NEG:
        r = (~a & 15) + 1
        to_other = 1 if r > 15 else 0
        r = r & 15
    elif op == AND:
        r = a & b
    elif op == OR:
        r = a | b
    elif op == XOR:
        r = a ^ b
    elif op == SHR or op == SAR:
        r = (8 if from_other == 1 else 0) | (a >> 1)
        carry_out = a & 1
    return r, carry_out, to_other

def get_overflow(r, a, b, is_sum):
    r_bit = (r & 8) == 8
    a_bit = (a & 8) == 8
    b_bit = (b & 8) == 8
    if not is_sum:
        b_bit = not b_bit
    if a_bit == b_bit:
        return 1 if a_bit != r_bit else 0
    else:
        return 0

def get_result_hi(a, b, op, invert, from_other, carry_in):
    r = 0
    carry_out = 0
    to_other = 0
    overflow_out = 0
    if op == ADD or op == ADC:
        r = a + b + from_other
        carry_out = 1 if r > 15 else 0
        r = r & 15
        overflow_out = get_overflow(r, a, b, True)
    elif op == SUB or op == SBB:
        r = a - b - from_other
        carry_out = 1 if r < 0 else 0
        if r < 0:
            r += 16
        overflow_out = get_overflow(r, a, b, False)
    elif op == INC:
        r = a + from_other
        carry_out = 1 if r > 15 else 0
        r = r & 15
        overflow_out = get_overflow(r, a, 1, True)
    elif op == DEC:
        r = a - from_other
        carry_out = 1 if r < 0 else 0
        if r < 0:
            r += 16
        overflow_out = get_overflow(r, a, 1, False)
    elif op == SHL:
        r = a << 1
        carry_out = 1 if r > 15 else 0
        r = r & 15
        r = r | from_other
    elif op == EXP:
        r = 15 if carry_in == 1 else 0
    elif op == MOV:
        r = a
    elif op == NOT:
        r = (~a) & 0xf
    elif op == NEG:
        r = (~a + from_other) & 15
    elif op == AND:
        r = a & b
    elif op == OR:
        r = a | b
    elif op == XOR:
        r = a ^ b
    elif op == SHR:
        r = a >> 1
        to_other = a & 1
    elif op == SAR:
        r = (a >> 1) | (8 if a & 8 == 8 else 0)
        to_other = a & 1
    return r, carry_out, to_other, overflow_out

def write_file(filename, array):
    with open(filename, "w") as f:
        for i,x in enumerate(array):
            f.write("{:02x}".format(x))
            if (i & 0xf) == 0xf:
                f.write("\n")
            else:
                f.write(" ")

def main():
    lo = [0] * (2 ** bits)
    hi = [0] * (2 ** bits)
    for a in range(16):
        for b in range(16):
            for op in range(16):
                for invert in range(2):
                    for carry in range(2):
                        for from_other in range(2):
                            r_lo, carry_lo, to_other_lo = get_result_lo(a, b, op, invert, from_other, carry)
                            r_hi, carry_hi, to_other_hi, overflow = get_result_hi(a, b, op, invert, from_other, carry)
                            address = encode_address(a, b, op, invert, from_other, carry)
                            data_lo = encode_result(r_lo, carry_lo, to_other_lo, 0)
                            data_hi = encode_result(r_hi, carry_hi, to_other_hi, overflow)
                            lo[address] = data_lo
                            hi[address] = data_hi
    write_file("alu_lo.mem", lo)
    write_file("alu_hi.mem", hi)

if __name__ == '__main__':
    main()
