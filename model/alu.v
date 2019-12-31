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

    wire [7:0] res;

    // prevent loopback
    assign from_hi = op[3] ? to_lo : 1'b0;
    assign from_lo = op[3] ? 1'b0 : to_hi;

    wire carry_out_lo, carry_out_hi;

    alu_hi hi_inst(
        .result(res[7:4]),
        .to_lo(to_lo),
        .carry_out(carry_out_hi),
        .overflow_out(flags[3]),
        .a(a[7:4]),
        .b(b[7:4]),
        .op(op),
        .invert(invert),
        .from_lo(from_lo),
        .carry_in(carry_in));
    alu_lo lo_inst(
        .result(res[3:0]),
        .to_hi(to_hi),
        .carry_out(carry_out_lo),
        .a(a[3:0]),
        .b(b[3:0]),
        .op(op),
        .invert(invert),
        .from_hi(from_hi),
        .carry_in(carry_in));

    assign flags[0] = ~|res;
    assign flags[1] = carry_out_lo | carry_out_hi;
    assign flags[2] = res[7];

    assign result = n_oe ? 8'bzzzzzzzz : res;
endmodule
