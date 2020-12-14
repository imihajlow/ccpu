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

wire #5 n_a15 = ~a[15]; // 74lv04a
wire #5 n_a2 = ~a[2]; // 74lv04a
wire #5 n_a1 = ~a[1]; // 74lv04a
wire #5 n_raml_ena= ~raml_ena; // 74lv04a

assign #6 n_rom_cs = a[15] | raml_ena; // 74lv32a
assign #6 n_raml_cs = a[15] | n_raml_ena; // 74lv32a

mux_74151 ram_mux(
     .n_g(n_a15),
     .d({1'b0, ram_e_ena, ram_d_ena, ram_c_ena, ram_b_ena, ram_a_ena, 2'b11}),
     .a(a[12]),
     .b(a[13]),
     .c(a[14]),
     .w(n_ramh_cs));

wire #12 n_io_cs = ~&a[15:8]; // 74x30

wire #6 a_or_12 = a[1] | a[2]; // 74lv32a
wire #6 n_kb_cs = n_io_cs | a_or_12; // 74lv32a
assign #6 n_kb_oe = n_kb_cs | n_oe; // 74lv32a
assign #6 kb_cp = n_kb_cs | n_we; // 74lv32a

wire #6 a_or_1n2 = n_a2 | a[1]; // 74lv32a
wire #6 n_cr_cs = n_io_cs | a_or_1n2; // 74lv32a
assign #6 cr_cp = n_cr_cs | n_we; // 74lv32a

wire #18 n_lcd_e = (a[2] | n_a1) | (n_io_cs | n_we); // 3x 74lv32a
assign #10 lcd_e = ~n_lcd_e; // 74lv04a

// n_rdy is open drain pull-up
assign #10 n_rdy = 1'b0; // always open

endmodule
