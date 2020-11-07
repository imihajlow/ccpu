`timescale 1ns/1ns
module adder(a, b, c_in, sub, r, c_out, c6_out, xor_ab);
    input [7:0] a;
    input [7:0] b;
    input c_in, sub;
    output [7:0] r;
    output c_out, c6_out;
    output [7:0] xor_ab;

    wire [7:0] c_ripple;
    wire [7:0] c = {c_ripple[6:0], c_in};
    assign c_out = c_ripple[7];

    assign #20 xor_ab = a ^ b; // 74x86
    assign #20 r = xor_ab ^ c; // 74x86

    wire [7:0] int_c1;
    wire [7:0] int_c2;

    assign #20 int_c1 = a ^ {8{sub}}; // 74x86
    assign #20 int_c2 = xor_ab ^ {8{sub}}; // 74x86

    assign #40 c_ripple = (c & int_c2) | (b & int_c1); // 74x08, 74x32

    assign c6_out = c_ripple[6];
endmodule
