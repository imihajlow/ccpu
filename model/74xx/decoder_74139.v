`timescale 1ns/1ps
module decoder_74139(
//output
           n_o,
//input
           a,
           n_e);
    input wire [1:0] a;
    input wire n_e;
    output wire [3:0] n_o;

    wire [3:0] n_result = ~(4'b0001 << a);
    assign #13 n_o = n_e ? 4'b1111 : n_result;
endmodule
