`timescale 1ns/1ns
module io(/*autoport*/
//output
             n_rdy,
             n_rom_cs,
             n_raml_cs,
             n_ramh_cs,
             n_kb_oe,
             kb_cp,
             cr_cp,
             lcd_e,
//input
             a,
             n_oe,
             n_we,
             cr);
input wire [15:0] a;
input wire n_oe;
input wire n_we;
output wire n_rdy;

output wire n_rom_cs;
output wire n_raml_cs;
output wire n_ramh_cs;

output wire n_kb_oe;
output wire kb_cp;
output wire cr_cp;
output wire lcd_e;

input wire [7:0] cr;

wire raml_ena = cr[0];
wire ram_a_ena = cr[3];
wire ram_b_ena = cr[4];
wire ram_c_ena = cr[5];
wire ram_d_ena = cr[6];
wire ram_e_ena = cr[7];

wire #10 n_a15 = ~(a[15] & a[15]); // 74x00
assign #10 n_rom_cs = a[15] | raml_ena; // 74x32
assign #10 n_raml_cs = ~(n_a15 & raml_ena); // 74x00

mux_74151 ram_mux(
     .n_g(n_a15),
     .d({1'b0, ram_e_ena, ram_d_ena, ram_c_ena, ram_b_ena, ram_a_ena, 2'b11}),
     .a(a[12]),
     .b(a[13]),
     .c(a[14]),
     .w(n_ramh_cs));

wire #12 n_io_cs = ~&a[15:8]; // 74x30

wire #20 n_kb_cs = n_io_cs | a[1] | a[2]; // 2x 74x32
assign #10 n_kb_oe = n_kb_cs | n_oe; // 74x32
assign #10 kb_cp = n_kb_cs | n_we; // 74x32

wire #10 n_a2 = ~a[2];
wire #10 n_a1 = ~a[1];

wire #20 n_cr_cs = n_io_cs | n_a2 | a[1]; // 2x 74x32
assign #20 cr_cp = n_cr_cs | n_we; // 74x32

wire #20 n_lcd_e = (a[2] | n_a1) | (n_io_cs | n_we); // 3x 74x32
assign #10 lcd_e = ~(n_lcd_e & n_lcd_e); // 74x00

// n_rdy is open drain pull-up
assign #10 n_rdy = 1'b0; // always open

endmodule
