`timescale 1ns/10ps
module vga_ctrl(/*autoport*/
//output
            a_sel,
            n_text_ram_cs,
            n_text_ram_oe,
            n_text_ram_we,
            n_d_to_text_oe,
            n_color_ram_cs,
            n_color_ram_oe,
            n_color_ram_we,
            n_d_to_color_oe,
            n_pixel_ena,
            n_h_rst,
            n_v_rst,
            hsync_out,
            n_hsync_out,
            vsync_out,
            n_rdy,
//input
            n_rst,
            a,
            n_we,
            n_oe,
            vy,
            hx,
            ena);
input wire n_rst;
input wire [15:0] a;
input wire n_we;
input wire n_oe;
output wire a_sel; // 0 - int, 1 - ext
output wire n_text_ram_cs;
output wire n_text_ram_oe;
output wire n_text_ram_we;
output wire n_d_to_text_oe;
output wire n_color_ram_cs;
output wire n_color_ram_oe;
output wire n_color_ram_we;
output wire n_d_to_color_oe;
output wire n_pixel_ena;
output wire n_h_rst;
output wire n_v_rst;
output wire hsync_out;
output wire n_hsync_out;
output wire vsync_out;
input wire [9:0] vy; // line number (total)
input wire [9:0] hx; // column number (total)
input wire ena;
output wire n_rdy;

/*
H: 8 back + 640 pixels + 16 front + 96 sync + 40 back    = 800
V: 480 lines + 10 front + 2 sync + 33 back      = 525
*/

// 752 = 10 1111 0000
// 656 = 10 1001 0000
wire #7 hx_6_0_lt_1110000 = ~(hx[6] & hx[5] & hx[4]); // 74lv10a
wire #5 hx_or_65 = hx[6] | hx[5]; // 74lv32a
wire #5 hx_or_654 = hx_or_65 | hx[4]; // 74lv32a
wire #5 hx_6_0_ge_0010000 = hx_or_654; // 74lv32a
wire #7 hsync_int = ~(hx[9] & hx[7] & hx_6_0_ge_0010000 & hx_6_0_lt_1110000); // 74lv20a

wire #10 n_hx2 = ~hx[2];
d_ff_7474 ff_hsync(
      .q(hsync_out),
      .n_q(n_hsync_out),
      .d(hsync_int),
      .cp(n_hx2),
      .n_cd(1'b1),
      .n_sd(n_rst));

// 640 = 10 1000 0000
wire #5 hx_or_87 = hx[8] | hx[7]; // 74lv32a
wire #5 hx_lt_640 = ~(hx[9] & hx_or_87); // 74lv00a
wire #5 n_pixel_ena_int = ~(vy_lt_480 & hx_lt_640); // 74lv00a

d_ff_7474 ff_n_pixel_ena(
      .q(n_pixel_ena),
      .d(n_pixel_ena_int),
      .cp(n_hx2),
      .n_cd(1'b1),
      .n_sd(n_rst));

wire #6 vy_8765 = vy[8] & vy[7] & vy[6] & vy[5]; // 74lv21a
wire #7 vy_nand_3 = ~(vy_8765 & vy[3] & vy[1]); // 74lv10a
wire #5 vy_or_42 = vy[4] | vy[2]; // 74lv32a
assign #5 vsync_out = vy_nand_3 | vy_or_42; // 74lv32a

// 480 = 01 1110 0000
// wire vy_lt_480 = vy < 480;
wire #5 vy_lt_480 = ~(vy_8765 | vy[9]); // 74lv00a

// assign n_v_rst = ~(vy == 525) & n_rst;
// 525 = 10 0000 1101
wire #7 vy_nand_9320 = ~(vy[9] & vy[3] & vy[2] & vy[0]); // 74lv20a // true if vy === 525, false if vy < 525
assign #6 n_v_rst = vy_nand_9320 & n_rst; // 74lv08a

wire #7 hx_nand_985 = ~(hx[9] & hx[8] & hx[5]); // 74lv10a
assign #6 n_h_rst = hx_nand_985 & n_rst; // 74lv08a // true if hx === 800, false if hx < 800

assign a_sel = n_pixel_ena_int;
wire #8 ram_busy = a_sel ^ 1'b1; // 74lv86a

wire #8 a_13_xor_12 = a[13] ^ a[12]; // 74lv86a
wire #7 n_ext_sel = ~(ena & a[15] & a[14] & a_13_xor_12); // 74lv20
assign #5 n_rdy = ram_busy | n_ext_sel; // 74lv32a
// ======================================================

assign n_text_ram_we = n_we | n_rdy | a[12];
assign n_color_ram_we = n_we | n_rdy | ~a[12];

// select when pixel area or when external write selected
assign n_text_ram_cs = a_sel & n_text_ram_we;
assign n_color_ram_cs = a_sel & n_color_ram_we;

// always output when pixel area
assign n_text_ram_oe = a_sel;
assign n_color_ram_oe = a_sel;

assign n_d_to_text_oe = n_text_ram_we;
assign n_d_to_color_oe = n_color_ram_we;


endmodule
