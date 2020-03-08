#!/usr/bin/env python3
bits = 15

def encode_address(ir, clk, condition_result, n_mem_rdy, cycle, s1, s2):
    return ir | (clk << 8) | (condition_result << 9) | (n_mem_rdy << 11) | (cycle << 10) | (s1 << 12) | (s2 << 13)

def encode_a(n_oe_mem, n_we_mem, n_oe_d_di, inc_ip, addr_dp, we_ir):
    return n_oe_mem | (n_we_mem << 1) | (n_oe_d_di << 2) | (inc_ip << 3) | (addr_dp << 4) | (we_ir << 5)

def encode_b(n_oe_pl_alu, n_oe_ph_alu, n_oe_b_alu, n_oe_a_d, n_oe_b_d, n_we_flags, s1_d, s2_d):
    return n_oe_pl_alu | (n_oe_ph_alu << 1) | (n_oe_b_alu << 2) | (n_oe_a_d << 3) | (n_oe_b_d << 4) | (n_we_flags << 5) | (s1_d << 6) | (s2_d << 7)

def encode_c(n_oe_alu_di, n_reset_cycle, swap_p, n_we_pl, n_we_ph, we_a, we_b):
    return n_oe_alu_di | (n_reset_cycle << 1) | (swap_p << 2) | (n_we_pl << 3) | (n_we_ph << 4) | (we_a << 5) | (we_b << 6)

def write_hex(filename, array):
    with open(filename, "w") as f:
        for i,x in enumerate(array):
            f.write("{:02x}".format(x))
            if (i & 0xf) == 0xf:
                f.write("\n")
            else:
                f.write(" ")

def write_bin(filename, array):
    with open(filename, "wb") as f:
        ba = bytearray(array)
        f.write(ba)

def set_oe_alu(ir, r):
    n = ir & 0x03
    key = ["n_oe_zero_alu", "n_oe_b_alu", "n_oe_pl_alu", "n_oe_ph_alu"][n]
    r[key] = 0

def set_we(ir, r):
    n = ir & 0x03
    key = ["we_a", "we_b", "n_we_pl", "n_we_ph"][n]
    if n < 2:
        r[key] = 1 # active high
    else:
        r[key] = 0 # active low

def set_oe_x_d(ir, r):
    n = ir & 0x01
    key = ["n_oe_a_d", "n_oe_b_d"][n]
    r[key] = 0

def get(ir, clk, condition_result, n_mem_rdy, cycle):
    r = {
        "n_oe_mem": 0,
        "n_we_mem": 1,
        "n_oe_d_di": 1,
        "inc_ip": 1,
        "addr_dp": 0,
        "n_we_pl": 1,
        "n_we_ph": 1,
        "we_a": 0,
        "we_b": 0,
        "n_oe_pl_alu": 1,
        "n_oe_ph_alu": 1,
        "n_oe_b_alu": 1,
        "n_oe_zero_alu": 1,
        "n_oe_a_d": 1,
        "n_oe_b_d": 1,
        "n_we_flags": 1,
        "n_oe_alu_di": 1,
        "n_reset_cycle": 0,
        "swap_p": 0,
        "we_ir": 1
    }

    ir_is_alu = (ir & 0x80) == 0
    ir_is_jmp = (ir & 0xc0) == 0xc0
    ir_is_2cy = (ir & 0xa0) == 0xa0
    ir_is_sto = (ir & 0x90) == 0x90

    ld = (ir & 0xf0) == 0x80
    st = (ir & 0xf0) == 0xb0
    alu = (ir & 0x80) == 0
    ldi = (ir & 0xf0) == 0xa0
    jc = (ir & 0xf0) == 0xc0

    if ir & 0x80 == 0:
        # ALU operation
        # 0oooordd
        inverse = ir & 0x04 != 0
        r["n_we_flags"] = 0
        r["n_oe_alu_di"] = 0

        set_oe_alu(ir, r)
        if not inverse:
            r["we_a"] = 1
        else:
            set_we(ir, r)
    elif ir & 0xf0 == 0x80:
        # LD operation
        # 1000__dd
        set_we(ir, r)
        r["n_oe_d_di"] = 0
        if clk:
            r["addr_dp"] = 1
        else:
            r["addr_dp"] = 0
    elif ir & 0xf0 == 0xb0:
        # ST operation
        # 1011___d
        r["n_reset_cycle"] = 1
        if cycle == 0:
            r["n_oe_mem"] = 1
            r["inc_ip"] = 0
            r["addr_dp"] = 1
            if clk == 1:
                r["n_we_mem"] = 1
            else:
                r["n_we_mem"] = 0
                set_oe_x_d(ir, r)
                r["we_ir"] = 0
        else:
            if clk == 1:
                r["we_ir"] = 0
                set_oe_x_d(ir, r)
                r["n_oe_mem"] = 1
                r["addr_dp"] = 1
    elif ir & 0xf0 == 0xa0:
        # LDI operation
        # 1010__dd
        r["n_reset_cycle"] = 1
        if cycle == 0:
            if clk == 0:
                r["we_ir"] = 0
        else:
            r["n_oe_d_di"] = 0
            set_we(ir, r)
            if clk == 1:
                r["we_ir"] = 0
    elif ir & 0xf0 == 0xc0:
        # Jx operation
        # 1010icff
        conditional = ir & 0x08 == 0
        inverse = ir & 0x04 != 0
        success = not conditional or (condition_result != inverse)
        if success:
            r["swap_p"] = 1
    return r

def main():
    part_a = [0] * (2 ** bits)
    part_b = [0] * (2 ** bits)
    part_c = [0] * (2 ** bits)

    for ir in range(256):
        for clk in range(2):
            for condition_result in range(2):
                for n_mem_rdy in range(2):
                    for cycle in range(2):
                        for s1 in range(2):
                            for s2 in range(2):
                                address = encode_address(ir, clk, condition_result, n_mem_rdy, cycle, s1, s2)
                                r = get(ir, clk, condition_result, n_mem_rdy, cycle)
                                part_a[address] = encode_a(r["n_oe_mem"], r["n_we_mem"], r["n_oe_d_di"], r["inc_ip"], r["addr_dp"], r["we_ir"])
                                part_b[address] = encode_b(r["n_oe_pl_alu"], r["n_oe_ph_alu"], r["n_oe_b_alu"], r["n_oe_a_d"], r["n_oe_b_d"], r["n_we_flags"], 0, 0)
                                part_c[address] = encode_c(r["n_oe_alu_di"], r["n_reset_cycle"], r["swap_p"], r["n_we_pl"], r["n_we_ph"], r["we_a"], r["we_b"])
    write_hex("cu_a.mem", part_a)
    write_hex("cu_b.mem", part_b)
    write_hex("cu_c.mem", part_c)
    write_bin("cu_a.bin", part_a)
    write_bin("cu_b.bin", part_b)
    write_bin("cu_c.bin", part_c)

if __name__ == '__main__':
    main()
