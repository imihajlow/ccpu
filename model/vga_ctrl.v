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
            hx);
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
output wire n_rdy;

/*
H: 8 back + 640 pixels + 16 front + 96 sync + 40 back    = 800
V: 480 lines + 10 front + 2 sync + 33 back      = 525
*/

// 752 = 10 1111 0000
// 656 = 10 1001 0000
wire #10 hx_6_0_lt_1110000 = ~(hx[6] & hx[5] & hx[4]); // 74x10
wire #10 hx_or_65 = hx[6] | hx[5]; // 74x32
wire #10 hx_or_654 = hx_or_65 | hx[4]; // 74x32
wire #10 hx_6_0_ge_0010000 = hx_or_654; // 74x32
wire #10 hsync_int = ~(hx[9] & hx[7] & hx_6_0_ge_0010000 & hx_6_0_lt_1110000); // 74x20

wire #10 n_hx2 = ~hx[2];
d_ff_7474 ff_hsync(
      .q(hsync_out),
      .n_q(n_hsync_out),
      .d(hsync_int),
      .cp(n_hx2),
      .n_cd(1'b1),
      .n_sd(n_rst));

// 640 = 10 1000 0000
wire #10 hx_or_87 = hx[8] | hx[7]; // 74x32
wire #10 hx_lt_640 = ~(hx[9] & hx_or_87); // 74x00
wire #10 n_pixel_ena_int = ~(vy_lt_480 & hx_lt_640); // 74x00

d_ff_7474 ff_n_pixel_ena(
      .q(n_pixel_ena),
      .d(n_pixel_ena_int),
      .cp(n_hx2),
      .n_cd(1'b1),
      .n_sd(n_rst));

wire #10 vy_8765 = vy[8] & vy[7] & vy[6] & vy[5]; // 74x21
wire #10 vy_nand_3 = ~(vy_8765 & vy[3] & vy[1]); // 74x10
wire #10 vy_or_42 = vy[4] | vy[2]; // 74x32
assign #10 vsync_out = vy_nand_3 | vy_or_42; // 74x32

// 480 = 01 1110 0000
// wire vy_lt_480 = vy < 480;
wire #10 vy_lt_480 = ~(vy_8765 | vy[9]); // 74x00

// assign n_v_rst = ~(vy == 525) & n_rst;
// 525 = 10 0000 1101
wire #10 vy_nand_9320 = ~(vy[9] & vy[3] & vy[2] & vy[0]); // 74x20 // true if vy === 525, false if vy < 525
assign #10 n_v_rst = vy_nand_9320 & n_rst; // 74x08

wire #10 hx_nand_985 = ~(hx[9] & hx[8] & hx[5]); // 74x10
assign #10 n_h_rst = hx_nand_985 & n_rst; // 74x08 // true if hx === 800, false if hx < 800

// ======================================================
assign a_sel = n_pixel_ena_int;
wire ram_busy = ~a_sel;

wire ext_selected = a[15:13] == 3'b111;
assign n_text_ram_we = n_we | ~ext_selected | a[12] | ram_busy;
assign n_color_ram_we = n_we | ~ext_selected | ~a[12] | ram_busy;

// select when pixel area or when external write selected
assign n_text_ram_cs = ~ram_busy & n_text_ram_we;
assign n_color_ram_cs = ~ram_busy & n_color_ram_we;

// always output when pixel area
assign n_text_ram_oe = a_sel;
assign n_color_ram_oe = a_sel;

assign n_d_to_text_oe = n_text_ram_we;
assign n_d_to_color_oe = n_color_ram_we;

assign n_rdy = ram_busy | ~ext_selected;

endmodule
