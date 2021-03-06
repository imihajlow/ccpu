`timescale 1ns/1ns
module cpu(clk_in, n_rst, a, d, n_oe, n_we, n_rdy);
    input clk_in;
    input n_rst;
    output [15:0] a;
    inout [7:0] d;
    output n_oe;
    output n_we;
    input n_rdy;

    wire n_clk = ~clk_in;
    wire clk;
    assign #10 clk = ~n_clk;

    wire [7:0] ir_out;
    wire we_ir;

    wire ir_w_clk;
    assign #10 ir_w_clk = n_clk & we_ir; // 74act08 AND gate

    register_74273 reg_ir(
            .q(ir_out),
            .d(d),
            .n_mr(n_rst),
            .cp(ir_w_clk)
        );

    wire [7:0] d_int = 8'bzzzzzzzz; // internal data bus
    wire [7:0] alu_a = 8'bz; // first ALU input
    wire [7:0] alu_b = 8'bz; // second ALU input

    wire a_we;
    wire n_a_to_d_oe;

    wire a_w_clk;
    assign #10 a_w_clk = n_clk & a_we; // 74act08 AND gate
    gp_reg_a reg_a(
            .doa(d),
            .dob(alu_a),
            .di(d_int),
            .w_clk(a_w_clk),
            .n_rst(n_rst),
            .n_oe_a(n_a_to_d_oe)
        );

    wire b_we;
    wire n_b_to_d_oe;
    wire n_b_to_alu_oe;

    wire b_w_clk;
    assign #10 b_w_clk = n_clk & b_we; // 74act08 AND gate
    gp_reg_b reg_b(
            .doa(d),
            .dob(alu_b),
            .di(d_int),
            .w_clk(b_w_clk),
            .n_rst(n_rst),
            .n_oe_a(n_b_to_d_oe),
            .n_oe_b(n_b_to_alu_oe)
        );

    wire [3:0] flags_in;
    wire [3:0] flags_out;
    wire n_flags_we;
    counter_74161 reg_flags(
            .Q(flags_out),
            .clk(n_clk),
            .clr_n(n_rst),
            .enp(1'b0),
            .ent(1'b0),
            .load_n(n_flags_we),
            .P(flags_in));

    wire addr_dp;
    wire n_ph_to_alu_oe;
    wire n_pl_to_alu_oe;
    wire ip_cnt;
    wire n_pl_we;
    wire n_ph_we;
    wire p_selector;
    pointer_pair reg_p(
            .addr_out(a),
            .data_out(alu_b),
            .clk(n_clk),
            .n_rst(n_rst),
            .di(d_int),
            .addr_dp(addr_dp),
            .n_oe_dl(n_pl_to_alu_oe),
            .n_oe_dh(n_ph_to_alu_oe),
            .cnt(ip_cnt),
            .n_we_l(n_pl_we),
            .n_we_h(n_ph_we),
            .selector(p_selector));

    wire n_alu_oe;
    wire [3:0] alu_op = ir_out[6:3];
    wire alu_invert = ir_out[2];
    alu alu_inst(
        .a(alu_a),
        .b(alu_b),
        .op(alu_op),
        .n_oe(n_alu_oe),
        .invert(alu_invert),
        .result(d_int),
        .flags(flags_in),
        .carry_in(flags_out[1])
        );

    wire n_oe_d_di;
    assign d_int = n_oe_d_di ? 8'bz : d;

    wire n_zero_to_alu_oe = ~(n_pl_to_alu_oe & n_ph_to_alu_oe & n_b_to_alu_oe); // fake pull-down
    assign alu_b = n_zero_to_alu_oe ? 8'bz : 8'b0;

    control_unit cu(
                .n_oe_mem(n_oe),
                .n_we_mem(n_we),
                .n_oe_d_di(n_oe_d_di),
                .we_ir(we_ir),
                .inc_ip(ip_cnt),
                .addr_dp(addr_dp),
                .p_selector(p_selector),
                .n_we_pl(n_pl_we),
                .n_we_ph(n_ph_we),
                .we_a(a_we),
                .we_b(b_we),
                .n_oe_pl_alu(n_pl_to_alu_oe),
                .n_oe_ph_alu(n_ph_to_alu_oe),
                .n_oe_b_alu(n_b_to_alu_oe),
                .n_oe_a_d(n_a_to_d_oe),
                .n_oe_b_d(n_b_to_d_oe),
                .n_we_flags(n_flags_we),
                .n_oe_alu_di(n_alu_oe),
                .clk(clk),
                .n_rst(n_rst),
                .ir(ir_out),
                .flags(flags_out),
                .n_mem_rdy(n_rdy));
endmodule
