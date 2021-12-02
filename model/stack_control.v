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
    n_ce_bank,
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
output wire n_ce_bank;

// 0xFC00 - SP0 value
// 0xFC01 - SP1 value
// 0xFC02 - inc/dec: writing 0 to corresponding bit:
//          bit 0 - increment SP0
//          bit 1 - increment SP1
//          bit 2 - decrement SP0
//          bit 3 - decrement SP1
// 0xFC03 - enable: write bit 0 to enable/disable stack controller

wire #10 n_a11 = ~a[11]; // 74HC00
wire #10 n_a12 = ~a[12]; // 74HC00
wire #10 nand_a_14_15 = ~&a[15:14]; // 74HC00
wire #10 nand_a_10_11 = ~&a[11:10]; // 74HC00
wire #10 xor_a_12_13 = ^a[13:12]; // 74x1G86

wire #10 nandxor = nand_a_14_15 | xor_a_12_13; // 74HC32
wire #10 nand_a_10_12 = nand_a_10_11 | n_a12; // 74HC32
wire #10 nand_a_10_15 = nandxor | nand_a_10_12; // 74HC32
// n_sf_sel = a[15:12] != 4'hC
wire #10 n_sf_sel = nandxor | a[12]; // 74HC32

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
wire #10 ff_ena_cp = n_sel[3] | n_we; // 74HC32
d_ff_7474 ff_ena(
    .q(ena),
    .n_q(n_ena),

    .d(d[0]),
    .cp(ff_ena_cp),
    .n_cd(n_rst),
    .n_sd(1'b1)
);

assign #10 n_load_0 = n_sel[0] | n_we; // 74HC32
assign #10 n_load_1 = n_sel[1] | n_we; // 74HC32
assign #10 n_oe_d_0 = n_sel[0] | n_oe; // 74HC32
assign #10 n_oe_d_1 = n_sel[1] | n_oe; // 74HC32

wire #10 n_incdec_we = n_sel[2] | n_we; // 74HC32
assign #10 up_0 = n_incdec_we | d[0]; // 74HC32
assign #10 up_1 = n_incdec_we | d[1]; // 74HC32
assign #10 down_0 = n_incdec_we | d[2]; // 74HC32
assign #10 down_1 = n_incdec_we | d[3]; // 74HC32

assign n_oe_ia_0 = a[11];
assign #10 n_oe_ia_1 = n_a11;

assign #10 n_ce_bank = n_sf_sel | n_ena;
endmodule