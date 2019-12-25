module alu_lo(
//output
          result,
          to_hi,
          carry_out,
//input
          a,
          b,
          op,
          invert,
          from_hi,
          carry_in);
    input wire [3:0] a;
    input wire [3:0] b;
    input wire [3:0] op;
    input wire invert;
    input wire from_hi;
    input wire carry_in;
    output wire [3:0] result;
    output wire to_hi;
    output wire carry_out;

    reg [7:0] rom [0:(1 << 15) - 1];

    wire [14:0] address = {invert, from_hi, carry_in, op, b, a};
    assign {to_hi, carry_out, result} = rom[address];

    initial begin
        $readmemh("alu_lo.mem", rom);
    end
endmodule
