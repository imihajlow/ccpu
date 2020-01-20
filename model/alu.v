`timescale 1ns/1ps
module alu(a, b, op, n_oe, invert, carry_in, result, flags);
    input [7:0] a;
    input [7:0] b;
    output [7:0] result;
    input [3:0] op;
    input n_oe;
    input invert;
    input carry_in;
    output [3:0] flags;

    // flags:
    // 0: zero
    // 1: carry
    // 2: sign
    // 3: overflow

    // operations are defined by gen-alu.py

    wire to_lo;
    wire from_hi;
    wire to_hi;
    wire from_lo;

    wire n_op3;

    // 74x00 NAND gate
    assign #20 n_op3 = ~(op[3] & op[3]);
    // 74x08 AND gate
    // prevent loopback
    assign #20 from_hi = op[3] & to_lo;
    assign #20 from_lo = ~op[3] & to_hi;

    wire n_carry_out_lo, n_carry_out_hi;

    alu_hi hi_inst(
        .result(result[7:4]),
        .to_lo(to_lo),
        .n_carry_out(n_carry_out_hi),
        .overflow_out(flags[3]),
        .a(a[7:4]),
        .b(b[7:4]),
        .op(op),
        .invert(invert),
        .from_lo(from_lo),
        .carry_in(carry_in),
        .n_oe(n_oe));
    alu_lo lo_inst(
        .result(result[3:0]),
        .to_hi(to_hi),
        .n_carry_out(n_carry_out_lo),
        .a(a[3:0]),
        .b(b[3:0]),
        .op(op),
        .invert(invert),
        .from_hi(from_hi),
        .carry_in(carry_in),
        .n_oe(n_oe));

    wire nor01, nor23, nor45, nor67;
    wire z03, z47;
    wire n_z;

    // 74x02 NOR gate
    assign #20 nor01 = ~(result[0] | result[1]);
    assign #20 nor23 = ~(result[2] | result[3]);
    assign #20 nor45 = ~(result[4] | result[5]);
    assign #20 nor67 = ~(result[6] | result[7]);

    // 74x08 AND gate
    assign #20 z03 = nor01 & nor23;
    assign #20 z47 = nor45 & nor67;

    // 74x00 NAND gate
    assign #20 n_z = ~(z03 & z47);
    assign #20 flags[0] = ~(n_z & n_z);
    assign #20 flags[1] = ~(n_carry_out_lo & n_carry_out_hi);

    assign flags[2] = result[7];
endmodule
