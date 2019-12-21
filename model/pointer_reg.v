module pointer_reg(
//output
         addr_out,
         data_out,
//input
         clk,
         rst,
         di,
         oe_addr,
         oe_dl,
         oe_dh,
         cnt,
         we_l,
         we_h);
    input wire clk;
    input wire rst;
    input wire [7:0] di;
    input wire oe_addr;
    input wire oe_dl;
    input wire oe_dh;
    input wire cnt;
    input wire we_l;
    input wire we_h;

    output wire [15:0] addr_out;
    output wire [7:0] data_out;

    wire carry;
    uni_reg reg_l(
            .doa(addr_out[7:0]),
            .dob(data_out),
            .rco(carry),
            .clk(clk),
            .rst(rst),
            .we(we_l),
            .oea(oe_addr),
            .oeb(oe_dl),
            .cnt(cnt),
            .di(di));
    uni_reg reg_h(
            .doa(addr_out[15:8]),
            .dob(data_out),
            .clk(clk),
            .rst(rst),
            .we(we_h),
            .oea(oe_addr),
            .oeb(oe_dh),
            .cnt(carry),
            .di(di));
endmodule
