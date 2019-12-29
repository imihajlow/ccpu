`timescale 1ns/1ps
module register_74273(
//output
          q,
//input
          d,
          n_mr,
          cp);
    input wire [7:0] d;
    input wire n_mr;
    input wire cp;
    output reg [7:0] q;

    initial begin
        q = 8'bx;
    end

    always @(posedge cp or negedge n_mr) begin
        if (~n_mr) begin
            q <= #10.5 8'b0;
        end else begin
            q <= #11 d;
        end
    end
endmodule
