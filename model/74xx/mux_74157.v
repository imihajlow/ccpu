`timescale 1ns/1ns
module mux_74157(i0, i1, s, n_e, z);
    input wire [3:0] i0;
    input wire [3:0] i1;
    input wire s;
    input wire n_e;
    output wire [3:0] z;

    assign #10 z = n_e ? 4'b0 : (s ? i1 : i0);
endmodule
