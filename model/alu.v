`timescale 1ns/1ns
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

    wire [7:0] sa;
    wire [7:0] sb;
    wire n_sa_ena;
    wire n_sb_ena;
    wire swap;
    mux_74157 mux_alo(.i0(a[3:0]), .i1(b[3:0]), .s(swap), .n_e(n_sa_ena), .z(sa[3:0]));
    mux_74157 mux_ahi(.i0(a[7:4]), .i1(b[7:4]), .s(swap), .n_e(n_sa_ena), .z(sa[7:4]));
    mux_74157 mux_blo(.i0(b[3:0]), .i1(a[3:0]), .s(swap), .n_e(n_sb_ena), .z(sb[3:0]));
    mux_74157 mux_bhi(.i0(b[7:4]), .i1(a[7:4]), .s(swap), .n_e(n_sb_ena), .z(sb[7:4]));

    wire [7:0] adder_b;
    wire adder_sub;
    wire adder_b_one;
    wire adder_c_in;
    wire [7:0] adder_r;
    wire adder_c_out;
    wire adder_c6_out;
    wire [7:0] xor_r;
    adder adder_inst(
        .a(sa),
        .b(adder_b),
        .c_in(adder_c_in),
        .sub(adder_sub),
        .r(adder_r),
        .c_out(adder_c_out),
        .c6_out(adder_c6_out),
        .xor_ab(xor_r));

    wire adder_carry_ena;
    assign #20 adder_c_in = carry_in & adder_carry_ena; // 74x08

    assign #20 adder_b[0] = sb[0] | adder_b_one; // 74x32
    assign adder_b[7:1] = sb[7:1];

    wire n_adder_oe;
    buffer_74244 buf_adder(.o(result), .i(adder_r), .n_oe1(n_adder_oe), .n_oe2(n_adder_oe));

    wire n_xor_oe;
    buffer_74244 buf_xor(.o(result), .i(xor_r), .n_oe1(n_xor_oe), .n_oe2(n_xor_oe));

    wire n_not_oe;
    buffer_74240 buf_not(.o(result), .i(sb), .n_oe1(n_not_oe), .n_oe2(n_not_oe));

    wire n_shl_oe;
    buffer_74244 buf_shl(.o(result), .i({sa[6:0], 1'b0}), .n_oe1(n_shl_oe), .n_oe2(n_shl_oe));

    wire sar_ena;
    wire #20 shr_7 = sar_ena & sa[7]; // 74x08
    wire n_shr_oe;
    buffer_74244 buf_shr(.o(result), .i({shr_7, sa[7:1]}), .n_oe1(n_shr_oe), .n_oe2(n_shr_oe));

    wire n_exp_oe;
    buffer_74244 buf_exp(.o(result), .i({8{carry_in}}), .n_oe1(n_exp_oe), .n_oe2(n_exp_oe));

    wire [7:0] #20 and_r = sa & sb; // 74x08
    wire n_and_oe;
    buffer_74244 buf_and(.o(result), .i(and_r), .n_oe1(n_and_oe), .n_oe2(n_and_oe));

    wire [7:0] #20 or_r = sa | sb; // 74x32
    wire n_or_oe;
    buffer_74244 buf_or(.o(result), .i(or_r), .n_oe1(n_or_oe), .n_oe2(n_or_oe));

    wire [7:0] decoded_op;
    decoder_74138 dec_lo(.n_o(decoded_op), .a(op[2:0]), .n_e1(n_oe), .n_e2(op[3]), .e3(1'b1));

    assign n_exp_oe = decoded_op[0];
    assign n_and_oe = decoded_op[1];
    assign n_or_oe = decoded_op[2];
    assign n_shl_oe = decoded_op[3];
    assign n_not_oe = decoded_op[4];
    assign n_xor_oe = decoded_op[5];
    assign #20 n_shr_oe = decoded_op[6] & decoded_op[7]; // 74x08

    assign sar_ena = decoded_op[6];

    assign #20 adder_b_one = op[0] & op[1]; // 74x08
    assign adder_sub = op[2];
    assign #20 swap = int_swap ^ invert; // 74x86
    assign #20 flags[3] = adder_c6_out ^ adder_c_out; // 74x86
    wire #20 int_swap = op[2] & n_sa_ena; // 74x08

    wire #20 n_op3 = op[3] ^ 1'b1; // 74x86
    assign #20 n_adder_oe = n_oe | n_op3; // 74x08

    assign #20 n_sa_ena = ~(op[0] | op[1]); // 74x02
    assign #20 n_sb_ena = adder_b_one & op[3]; // 74x08

    wire #20 n_op1 = ~(op[1] | op[1]); // 74x02
    assign #20 adder_carry_ena = ~(n_op1 | op[0]); // 74x02

    wire #20 shr_oe = n_shr_oe ^ 1'b1; // 74x86
    wire #20 shl_oe = ~(n_shl_oe | n_shl_oe); // 74x02
    wire #20 c_shr = shr_oe & sa[0]; // 74x08
    wire #20 c_shl = shl_oe & sa[7]; // 74x08
    wire #20 c_adder = adder_c_out & op[3]; // 74x08

    wire #20 c_sh = c_shl | c_shr; // 74x32
    assign #20 flags[1] = c_adder | c_sh; // 74x32

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

    // 74x08 AND gate
    assign #20 flags[0] = z03 & z47;

    assign flags[2] = result[7];

endmodule
