`timescale 1ns/1ns
module alu_lo(
//output
          result,
          to_hi,
          n_carry_out,
//input
          a,
          b,
          op,
          invert,
          from_hi,
          carry_in,
          n_oe);
    input wire [3:0] a;
    input wire [3:0] b;
    input wire [3:0] op;
    input wire invert;
    input wire from_hi;
    input wire carry_in;
    input wire n_oe;
    output wire [3:0] result;
    output wire to_hi;
    output wire n_carry_out;

    wire [14:0] address = {invert, from_hi, carry_in, op, b, a};
    wire [7:0] data;
    rom_28c256 #(.FILENAME("alu_lo.mem")) rom_inst(
      .a(address),
      .d(data),
      .n_oe(n_oe),
      .n_cs(1'b0)
    );
    assign {to_hi, n_carry_out, result} = data;
endmodule
