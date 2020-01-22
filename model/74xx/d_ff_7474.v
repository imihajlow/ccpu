`timescale 1ns/1ns
module d_ff_7474(
//output
           q,
           n_q,
//input
           d,
           cp,
           n_cd,
           n_sd);
    input wire d;
    input wire cp;
    input wire n_cd;
    input wire n_sd;
    output wire q;
    output wire n_q;

    reg q_reg;
    assign #15 q = (n_cd | n_sd) ? q_reg : 1'b1;
    assign #15 n_q = (n_cd | n_sd) ? ~q_reg : 1'b1;

    always @(posedge cp or negedge n_cd or negedge n_sd) begin
        if (~n_cd) begin
            q_reg <= 1'b0;
        end else if (~n_sd) begin
            q_reg <= 1'b1;
        end else begin
            q_reg <= d;
        end
    end
endmodule
