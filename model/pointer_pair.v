`timescale 1ns/1ps
module pointer_pair(
//output
         addr_out,
         data_out,
//input
         clk,
         rst,
         di,
         oe_addr_ip,
         oe_addr_dp,
         oe_dl,
         oe_dh,
         cnt,
         we_l,
         we_h,
         selector);
    input wire clk;
    input wire rst;
    input wire [7:0] di;
    input wire oe_addr_ip;
    input wire oe_addr_dp;
    input wire oe_dl;
    input wire oe_dh;
    input wire cnt;
    input wire we_l;
    input wire we_h;
    input wire selector; // swap registers: 0 - A is IP, 1 - B is IP

    output wire [15:0] addr_out;
    output wire [7:0] data_out;

    wire a_oe_addr;
    wire a_oe_dl;
    wire a_oe_dh;
    wire a_cnt;
    wire a_we_l;
    wire a_we_h;

    wire b_oe_addr;
    wire b_oe_dl;
    wire b_oe_dh;
    wire b_cnt;
    wire b_we_l;
    wire b_we_h;

    wire n_selector;
    assign #35 n_selector = ~selector; // MOSFET invertor, 10k pull-up, 3.5 pF input capacitance

    // 74x32 OR gate
    assign #20 a_oe_dl = n_selector | oe_dl; // can only read DP;
    assign #20 a_oe_dh = n_selector | oe_dh; // can only read DP;
    assign #20 a_we_l = n_selector | we_l; // can only write to DP;
    assign #20 a_we_h = n_selector | we_h; // can only write to DP;
    assign #20 b_oe_dl = selector | oe_dl;
    assign #20 b_oe_dh = selector | oe_dh;
    assign #20 b_we_l = selector | we_l;
    assign #20 b_we_h = selector | we_h;

    selector_74153 sel_inst(
        .y1(a_oe_addr),
        .y2(b_oe_addr),
        .i1({2'b00, oe_addr_dp, oe_addr_ip}),
        .i2({2'b00, oe_addr_ip, oe_addr_dp}),
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
        .rst(rst),
        .di(di),
        .oe_addr(a_oe_addr),
        .oe_dl(a_oe_dl),
        .oe_dh(a_oe_dh),
        .cnt(a_cnt),
        .we_l(a_we_l),
        .we_h(a_we_h));

    pointer_reg reg_b(
        .addr_out(addr_out),
        .data_out(data_out),
        .clk(clk),
        .rst(rst),
        .di(di),
        .oe_addr(b_oe_addr),
        .oe_dl(b_oe_dl),
        .oe_dh(b_oe_dh),
        .cnt(b_cnt),
        .we_l(b_we_l),
        .we_h(b_we_h));
endmodule
