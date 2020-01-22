`timescale 1ns/1ns
module gp_reg_b(
//output
            doa,
            dob,
//input
            di,
            w_clk,
            n_rst,
            n_oe_a,
            n_oe_b);
    input wire [7:0] di;
    input wire w_clk;
    input wire n_rst;
    input wire n_oe_a;
    input wire n_oe_b;

    output wire [7:0] doa;
    output wire [7:0] dob;

    wire [7:0] d;

    register_74273 reg_inst(
        .d(di),
        .cp(w_clk),
        .n_mr(n_rst),
        .q(d));

    buffer_74244 buf_a(
        .i(d),
        .o(doa),
        .n_oe1(n_oe_a),
        .n_oe2(n_oe_a)
        );

    buffer_74244 buf_b(
        .i(d),
        .o(dob),
        .n_oe1(n_oe_b),
        .n_oe2(n_oe_b)
        );
endmodule
