module pointer_reg(
//output
         addr_out,
         data_out,
//input
         clk,
         n_rst,
         di,
         n_oe_addr,
         n_oe_dl,
         n_oe_dh,
         cnt,
         n_we_l,
         n_we_h);
    input wire clk;
    input wire n_rst;
    input wire [7:0] di;
    input wire n_oe_addr;
    input wire n_oe_dl;
    input wire n_oe_dh;
    input wire cnt;
    input wire n_we_l;
    input wire n_we_h;

    output wire [15:0] addr_out;
    output wire [7:0] data_out;

    wire carry01, carry12, carry23;

    wire [7:0] lo;
    wire [7:0] hi;

    counter_74161 cnt_0(
            .clk(clk),
            .clr_n(n_rst),
            .enp(cnt),
            .ent(cnt),
            .load_n(n_we_l),
            .P(di[3:0]),
            .Q(lo[3:0]),
            .rco(carry01));

    counter_74161 cnt_1(
            .clk(clk),
            .clr_n(n_rst),
            .enp(cnt),
            .ent(carry01),
            .load_n(n_we_l),
            .P(di[7:4]),
            .Q(lo[7:4]),
            .rco(carry12));

    counter_74161 cnt_2(
            .clk(clk),
            .clr_n(n_rst),
            .enp(cnt),
            .ent(carry12),
            .load_n(n_we_h),
            .P(di[3:0]),
            .Q(hi[3:0]),
            .rco(carry23));

    counter_74161 cnt_3(
            .clk(clk),
            .clr_n(n_rst),
            .enp(cnt),
            .ent(carry23),
            .load_n(n_we_h),
            .P(di[7:4]),
            .Q(hi[7:4]));

    buffer_74244 buf_a_lo(
            .o(addr_out[7:0]),
            .i(lo),
            .n_oe1(n_oe_addr),
            .n_oe2(n_oe_addr));

    buffer_74244 buf_a_hi(
            .o(addr_out[15:8]),
            .i(hi),
            .n_oe1(n_oe_addr),
            .n_oe2(n_oe_addr));

    buffer_74244 buf_d_lo(
            .o(data_out),
            .i(lo),
            .n_oe1(n_oe_dl),
            .n_oe2(n_oe_dl));

    buffer_74244 buf_d_hi(
            .o(data_out),
            .i(hi),
            .n_oe1(n_oe_dh),
            .n_oe2(n_oe_dh));
endmodule
