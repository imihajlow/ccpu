`timescale 1ns/1ns
module buffer_74240(
//output
            o,
//input
            i,
            n_oe1,
            n_oe2);
    input wire [7:0] i;
    input wire n_oe1;
    input wire n_oe2;
    output wire [7:0] o;

    assign #11 o[3:0] = n_oe1 ? 4'bzzzz : ~i[3:0];
    assign #11 o[7:4] = n_oe2 ? 4'bzzzz : ~i[7:4];
endmodule
