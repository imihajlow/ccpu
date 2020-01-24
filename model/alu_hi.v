`timescale 1ns/1ns
module alu_hi(
//output
          result,
          to_lo,
          n_carry_out,
          overflow_out,
//input
          a,
          b,
          op,
          invert,
          from_lo,
          carry_in,
          n_oe);
    input wire [3:0] a;
    input wire [3:0] b;
    input wire [3:0] op;
    input wire invert;
    input wire from_lo;
    input wire carry_in;
    input wire n_oe;
    output wire [3:0] result;
    output wire to_lo;
    output wire n_carry_out;
    output wire overflow_out;

    wire [14:0] address = {invert, from_lo, carry_in, op, b, a};
    // AT28C256
    wire [7:0] data;
    rom_28c256 #(.FILENAME("alu_hi.mem")) rom_inst(
      .a(address),
      .d(data),
      .n_oe(n_oe),
      .n_cs(1'b0)
    );
    assign {overflow_out, to_lo, n_carry_out, result} = data;
endmodule
