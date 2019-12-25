module alu_hi(
//output
          result,
          to_lo,
          carry_out,
          overflow_out,
//input
          a,
          b,
          op,
          invert,
          from_lo,
          carry_in);
    input wire [3:0] a;
    input wire [3:0] b;
    input wire [3:0] op;
    input wire invert;
    input wire from_lo;
    input wire carry_in;
    output wire [3:0] result;
    output wire to_lo;
    output wire carry_out;
    output wire overflow_out;

    reg [7:0] rom [0:(1 << 15) - 1];

    wire [14:0] address = {invert, from_lo, carry_in, op, b, a};
    assign {overflow_out, to_lo, carry_out, result} = rom[address];

    initial begin
        $readmemh("alu_hi.mem", rom);
    end
endmodule
