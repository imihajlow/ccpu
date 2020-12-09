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
            v_cnt_ena,
            hsync_out,
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
output wire v_cnt_ena;
output wire hsync_out;
output wire vsync_out;
input wire [9:0] vy; // line number (total)
input wire [9:0] hx; // column number (total)
output wire n_rdy;

/*
H: 8 back + 640 pixels + 16 front + 96 sync + 40 back    = 800
V: 480 lines + 10 front + 2 sync + 33 back      = 525
*/

// assign hsync_out = ~((hx >= 8 + 640 + 16) & (hx < 8 + 640 + 16 + 96));
// assign hsync_out = ~((hx >= 664) & (hx < 760));
// 760 = 10 1111 1000
// 664 = 10 1001 1000
wire hx_6_0_lt_1111000 = ~(hx[6] & hx[5] & hx[4] & hx[3]);
wire hx_6_0_ge_0011000 = hx[6] | hx[5] | (hx[4] & hx[3]);
assign hsync_out = ~(hx[9] & hx[7] & hx_6_0_ge_0011000 & hx_6_0_lt_1111000);

wire vy_8765 = vy[8] & vy[7] & vy[6] & vy[5];

assign vsync_out = ~(vy_8765 & vy[3] & vy[1]) | vy[4] | vy[2]; // bit 9 is don't care: vy won't reach that value

// assign n_v_rst = ~(vy == 525) & n_rst;
// 525 = 10 0000 1101
assign n_v_rst = ~(vy[9] & vy[3] & vy[2] & vy[0]) & n_rst; // true if vy === 525, false if vy < 525

assign n_h_rst = ~(hx[9] & hx[8] & hx[5]) & n_rst; // true if hx === 800, false if hx < 800

// 480 = 01 1110 0000
// wire vy_lt_480 = vy < 480;
wire vy_lt_480 = ~(vy_8765 | vy[9]);

// assign n_pixel_ena = ~(vy_lt_480 & (hx < 648) & (hx >= 8));
// 648 = 10 1000 1000
// 8 = 00 0000 1000
wire hx_86543 = hx[8] | hx[6] | hx[5] | hx[4] | hx[3];
wire hx_lt_648 = ~(hx[9] & (hx[8] | hx[7]) & hx_86543);
wire hx_gt_8 = hx[9] | hx[7] | hx_86543;
assign n_pixel_ena = ~(vy_lt_480 & hx_lt_648 & hx_gt_8);

assign v_cnt_ena = hx === 8 + 640 + 16;

wire ram_busy = vy_lt_480 & (hx < 640);
assign a_sel = ~ram_busy;

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
