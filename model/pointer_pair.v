`timescale 1ns/1ps
module pointer_pair(
//output
         addr_out,
         data_out,
//input
         clk,
         n_rst,
         di,
         n_oe_addr_ip,
         n_oe_addr_dp,
         n_oe_dl,
         n_oe_dh,
         cnt,
         n_we_l,
         n_we_h,
         selector);
    input wire clk;
    input wire n_rst;
    input wire [7:0] di;
    input wire n_oe_addr_ip;
    input wire n_oe_addr_dp;
    input wire n_oe_dl;
    input wire n_oe_dh;
    input wire cnt;
    input wire n_we_l;
    input wire n_we_h;
    input wire selector; // swap registers: 0 - A is IP, 1 - B is IP

    output wire [15:0] addr_out;
    output wire [7:0] data_out;

    wire n_a_oe_addr;
    wire n_a_oe_dl;
    wire n_a_oe_dh;
    wire a_cnt;
    wire n_a_we_l;
    wire n_a_we_h;

    wire n_b_oe_addr;
    wire n_b_oe_dl;
    wire n_b_oe_dh;
    wire b_cnt;
    wire n_b_we_l;
    wire n_b_we_h;

    wire n_selector;
    assign #35 n_selector = ~selector; // MOSFET invertor, 10k pull-up, 3.5 pF input capacitance

    // 74x32 OR gate
    assign #20 n_a_oe_dl = n_selector | n_oe_dl; // can only read DP;
    assign #20 n_a_oe_dh = n_selector | n_oe_dh; // can only read DP;
    assign #20 n_a_we_l = n_selector | n_we_l; // can only write to DP;
    assign #20 n_a_we_h = n_selector | n_we_h; // can only write to DP;
    assign #20 n_b_oe_dl = selector | n_oe_dl;
    assign #20 n_b_oe_dh = selector | n_oe_dh;
    assign #20 n_b_we_l = selector | n_we_l;
    assign #20 n_b_we_h = selector | n_we_h;

    selector_74153 sel_inst(
        .y1(n_a_oe_addr),
        .y2(n_b_oe_addr),
        .i1({2'b00, n_oe_addr_dp, n_oe_addr_ip}),
        .i2({2'b00, n_oe_addr_ip, n_oe_addr_dp}),
        .s({1'b0, selector}),
        .e1(1'b0),
        .e2(1'b0));

    // 74x08 AND gate
    assign #20 a_cnt = n_selector & cnt;       // can only count IP;
    assign #20 b_cnt = selector & cnt;


    pointer_reg reg_a(
        .addr_out(addr_out),
        .data_out(data_out),
        .clk(clk),
        .n_rst(n_rst),
        .di(di),
        .n_oe_addr(n_a_oe_addr),
        .n_oe_dl(n_a_oe_dl),
        .n_oe_dh(n_a_oe_dh),
        .cnt(a_cnt),
        .n_we_l(n_a_we_l),
        .n_we_h(n_a_we_h));

    pointer_reg reg_b(
        .addr_out(addr_out),
        .data_out(data_out),
        .clk(clk),
        .n_rst(n_rst),
        .di(di),
        .n_oe_addr(n_b_oe_addr),
        .n_oe_dl(n_b_oe_dl),
        .n_oe_dh(n_b_oe_dh),
        .cnt(b_cnt),
        .n_we_l(n_b_we_l),
        .n_we_h(n_b_we_h));
endmodule
