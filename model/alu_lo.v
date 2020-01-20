`timescale 1ns/1ps
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

    reg [7:0] rom [0:(1 << 15) - 1];

    wire [14:0] address = {invert, from_hi, carry_in, op, b, a};
    // AT28C256
    wire [7:0] data;
    assign #350 data = rom[address];
    assign #100 {to_hi, n_carry_out, result} = n_oe ? 8'bz : rom[address];

    initial begin
        $readmemh("alu_lo.mem", rom);
    end
endmodule
