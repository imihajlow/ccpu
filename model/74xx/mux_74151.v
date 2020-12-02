`timescale 1ns/1ns
module mux_74151(n_g, d, a, b, c, y, w);
    input n_g;
    input [7:0] d;
    input a, b, c;
    output y, w;

    wire [2:0] addr = {c,b,a};
    assign #10 y = n_g ? 1'b0 : d[addr];
    assign w = ~y;
endmodule
