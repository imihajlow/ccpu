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

    pointer_reg reg_a(
        .addr_out(addr_out),
        .data_out(data_out),
        .clk(clk),
        .rst(rst),
        .di(di),
        .oe_addr(~selector ? oe_addr_ip : oe_addr_dp),
        .oe_dl(~selector ? 1'b1 : oe_dl),   // can only read DP
        .oe_dh(~selector ? 1'b1 : oe_dh),   // can only read DP
        .cnt(~selector ? cnt : 1'b0),       // can only count IP
        .we_l(~selector ? 1'b1 : we_l),     // can only write to DP
        .we_h(~selector ? 1'b1 : we_h));

    pointer_reg reg_b(
        .addr_out(addr_out),
        .data_out(data_out),
        .clk(clk),
        .rst(rst),
        .di(di),
        .oe_addr(~selector ? oe_addr_dp : oe_addr_ip),
        .oe_dl(~selector ? oe_dl : 1'b1),
        .oe_dh(~selector ? oe_dh : 1'b1),
        .cnt(~selector ? 1'b0 : cnt),
        .we_l(~selector ? we_l : 1'b1),
        .we_h(~selector ? we_h : 1'b1));
endmodule
