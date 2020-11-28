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

    reg rq, rnq;

    assign #15 q = rq;
    assign #15 n_q = rnq;

    always @(n_cd or n_sd) begin
        if (n_sd & ~n_cd) begin
            rq = 1'b0;
            rnq = 1'b1;
        end else if (~n_sd & n_cd) begin
            rq = 1'b1;
            rnq = 1'b0;
        end else if (~n_sd & ~n_cd) begin
            rq = 1'b1;
            rnq = 1'b1;
        end
    end

    always @(posedge cp) begin
        if (n_sd & n_cd) begin
            rq <= d;
            rnq <= ~d;
        end
    end
endmodule
