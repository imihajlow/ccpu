`timescale 1ns/1ns
module stack_control(
    n_we,
    n_oe,
    a,
    d,
    n_rst,
    n_load_0,
    n_load_1,
    up_0,
    up_1,
    down_0,
    down_1,
    n_oe_d_0,
    n_oe_d_1,
    n_oe_ia_0,
    n_oe_ia_1,
    n_oe_bank,
    n_we_bank
);
input wire n_we;
input wire n_oe;
input wire [15:0] a;
input wire [7:0] d;
input wire n_rst;

output wire n_load_0;
output wire n_load_1;
output wire up_0;
output wire up_1;
output wire down_0;
output wire down_1;
output wire n_oe_d_0;
output wire n_oe_d_1;
output wire n_oe_ia_0;
output wire n_oe_ia_1;
output wire n_oe_bank;
output wire n_we_bank;

// 0xFC00 - SP0 value
// 0xFC01 - SP1 value
// 0xFC02 - inc/dec: writing 0 to corresponding bit:
//          bit 0 - increment SP0
//          bit 1 - increment SP1
//          bit 2 - decrement SP0
//          bit 3 - decrement SP1
// 0xFC03 - enabel: write bit 0 to enable/disable stack controller

wire #10 nand_a_10_15 = ~&a[15:10];
wire [3:0] dec_hi_o;
decoder_74139 dec_hi(
    .n_o(dec_hi_o),
    .a(a[9:8]),
    .n_e(nand_a_10_15)
);
wire n_sel_control = dec_hi_o[0];

wire [3:0] n_sel;
decoder_74139 dec_lo(
    .n_o(n_sel),
    .a(a[1:0]),
    .n_e(n_sel_control)
);

wire ena;
wire n_ena;
wire #10 ff_ena_cp = n_sel[3] | n_we;
d_ff_7474 ff_ena(
    .q(ena),
    .n_q(n_ena),

    .d(d[0]),
    .cp(ff_ena_cp),
    .n_cd(n_rst),
    .n_sd(1'b1)
);

assign #10 n_load_0 = n_sel[0] | n_we;
assign #10 n_load_1 = n_sel[1] | n_we;
assign #10 n_oe_d_0 = n_sel[0] | n_oe;
assign #10 n_oe_d_1 = n_sel[1] | n_oe;

assign #10 up_0 = n_sel[2] | n_we | d[0];
assign #10 up_1 = n_sel[2] | n_we | d[1];
assign #10 down_0 = n_sel[2] | n_we | d[2];
assign #10 down_1 = n_sel[2] | n_we | d[3];

assign #10 n_oe_ia_0 = a[11];
assign #10 n_oe_ia_1 = ~a[11];

wire n_sf_sel = a[15:12] != 4'b1100;

assign #10 n_oe_bank = n_ena | n_sf_sel | n_oe;
assign #10 n_we_bank = n_ena | n_sf_sel | n_we;
endmodule