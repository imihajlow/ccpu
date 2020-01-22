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

    reg [7:0] rom [0:(1 << 15) - 1];

    wire [14:0] address = {invert, from_lo, carry_in, op, b, a};
    // AT28C256
    wire [7:0] data;
    assign #350 data = rom[address];
    assign #100 {overflow_out, to_lo, n_carry_out, result} = n_oe ? 8'bz : data;

    initial begin
        $readmemh("alu_hi.mem", rom);
    end
endmodule
