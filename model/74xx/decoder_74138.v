`timescale 1ns/1ns
module decoder_74138(
//output
           n_o,
//input
           a,
           n_e1,
           n_e2,
           e3);
    input wire [2:0] a;
    input wire n_e1, n_e2, e3;
    output wire [7:0] n_o;

    wire [7:0] n_result = ~(8'b1 << a);
    assign #13 n_o = (n_e1 | n_e2 | !e3) ? 8'hff : n_result;
endmodule
