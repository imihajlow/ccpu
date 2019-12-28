`timescale 1ns / 1ps
module selector_74153(
//output
          y1,
          y2,
//input
          i1,
          i2,
          s,
          e1,
          e2);
    input wire [3:0] i1;
    input wire [3:0] i2;
    input wire [1:0] s;
    input wire e1;
    input wire e2;
    output wire y1;
    output wire y2;

    wire sum1;
    wire sum2;
    assign #5 sum1 = i1[0] & ~s[1] & ~s[0] | i1[1] & ~s[1] & s[0] | i1[2] & s[1] & ~s[0] | i1[3] & s[1] & s[0];
    assign #5 sum2 = i2[0] & ~s[1] & ~s[0] | i2[1] & ~s[1] & s[0] | i2[2] & s[1] & ~s[0] | i2[3] & s[1] & s[0];

    assign #10 y1 = ~e1 & sum1;
    assign #10 y2 = ~e2 & sum2;

endmodule
