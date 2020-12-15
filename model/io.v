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
             oport_cp,
             n_iport_oe,
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
output wire oport_cp;
output wire n_iport_oe;

input wire [7:0] cr;

wire raml_ena = cr[0];
wire ram_a_ena = cr[3];
wire ram_b_ena = cr[4];
wire ram_c_ena = cr[5];
wire ram_d_ena = cr[6];
wire ram_e_ena = cr[7];

wire #5 n_a15 = ~(a[15] & a[15]); // 74lv00a

assign #6 n_rom_cs = a[15] | raml_ena; // 74lv32a
assign #6 n_raml_cs = ~(n_a15 & raml_ena); // 74lv00a

mux_74151 ram_mux(
     .n_g(n_a15),
     .d({1'b0, ram_e_ena, ram_d_ena, ram_c_ena, ram_b_ena, ram_a_ena, 2'b11}),
     .a(a[12]),
     .b(a[13]),
     .c(a[14]),
     .w(n_ramh_cs));

wire #12 n_io_cs = ~&a[15:8]; // 74x30

wire n_kb_cs;
wire n_port_cs;
wire n_cr_cs;
wire [3:0] n_dec_o;
decoder_74139 dec_io(
    .n_o(n_dec_o),
    .a(a[2:1]),
    .n_e(n_io_cs)
);

assign n_kb_cs = n_dec_o[0];
assign n_port_cs = n_dec_o[1];
assign n_cr_cs = n_dec_o[2];

assign #6 n_kb_oe = n_kb_cs | n_oe; // 74lv32a
assign #6 kb_cp = n_kb_cs | n_we; // 74lv32a

assign #6 n_iport_oe = n_port_cs | n_oe; // 74lv32a
assign #6 oport_cp = n_port_cs | n_we; // 74lv32a

// cr: 10x
assign #6 cr_cp = n_cr_cs | n_we; // 74lv32a

// n_rdy is open drain pull-up
assign #10 n_rdy = 1'b0; // always open

endmodule
