`timescale 1ns/10ps
module vga_ctrl(/*autoport*/
//output
            n_ccol_rst,
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
output wire n_ccol_rst;
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
H: 96 sync + 48 back + 640 pixels + 16 front
V: 480 lines + 10 front + 2 sync + 33 back
*/

assign hsync_out = hx < 96;
assign vsync_out = (vy >= 480 + 10) & (vy < 480 + 10 + 2);

assign n_v_rst = ~(vy == 480 + 10 + 2 + 33) & n_rst;
assign n_h_rst = ~(hx == 96 + 48 + 640 + 16) & n_rst;
assign n_pixel_ena = ~((vy < 480) & (hx >= 96 + 48) & (hx < 96 + 48 + 640));
assign v_cnt_ena = hx == 96 + 48 + 640 + 16 - 1;
assign n_ccol_rst = ~(hx[9:2] == (96 + 40) / 4);

wire ram_busy = (vy < 480) & (hx >= 96 + 40) & (hx < 96 + 40 + 640);
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
