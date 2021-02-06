`timescale 1ns/1ns
// SPI mode 0, as needed for the memory card
module spi(/*autoport*/
//inout
            d,
//output
            clk,
            mosi,
            n_rdy,
//input
            n_rst,
            miso,
            n_oe,
            n_we,
            n_sel);
input wire n_rst;
output wire clk;
output wire mosi;
input wire miso;

output wire n_rdy;
inout wire [7:0] d;
input wire n_oe;
input wire n_we;
input wire n_sel;

reg int_clk;
always begin
    int_clk = 1'b0;
    forever #1200 int_clk = ~int_clk;
end

wire #7 n_int_clk = ~int_clk; // 74lv14a

wire [7:0] reg_send_q;
wire #7 reg_send_cp = n_sel | n_we; // 74lv32a
register_74273 reg_send(
    .q(reg_send_q),
    .d(d),
    .n_mr(n_rst),
    .cp(reg_send_cp)
);

wire [3:0] count;
wire [7:0] mux_d;
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin
        assign mux_d[i] = reg_send_q[7-i];
    end
endgenerate
mux_74151 mux_send(
    .n_g(1'b0),
    .d(mux_d),
    .a(count[0]),
    .b(count[1]),
    .c(count[2]),
    .y(mosi)
);

wire #7 n_clk = n_int_clk | n_clk_ena; // 74lv32a
wire #7 n_count3 = ~count[3]; // 74lv14a
wire #7 n_int_rst = n_count3 & n_rst; // 74lv08a
counter_74161 counter_send(
  .clk(n_clk),
  .clr_n(n_int_rst),
  .enp(1'b1),
  .ent(1'b1),
  .load_n(1'b1),
  .P(4'b0000),
  .Q(count)
);

wire [7:0] reg_recv_q;
register_74273 reg_recv(
    .q(reg_recv_q),
    .d({reg_recv_q[6:0], miso}),
    .n_mr(n_rst),
    .cp(clk)
);

wire #7 n_oe_to_d = n_sel | n_oe; // 74lv32a
buffer_74244 buf_out(
    .o(d),
    .i(reg_recv_q),
    .n_oe1(n_oe_to_d),
    .n_oe2(n_oe_to_d)
);

wire n_rdy_int;
wire rdy_int;
d_ff_7474 ff_rdy(
    .q(n_rdy_int),
    .n_q(rdy_int),
    .d(1'b1),
    .cp(reg_send_cp),
    .n_cd(n_int_rst),
    .n_sd(1'b1)
);

wire clk_ena;
wire n_clk_ena;
d_ff_7474 ff_clk_ena(
    .q(clk_ena),
    .n_q(n_clk_ena),
    .d(n_rdy_int),
    .cp(n_int_clk),
    .n_cd(n_int_rst),
    .n_sd(1'b1)
);
assign #7 clk = ~n_clk;

wire #7 rdy = rdy_int | n_sel; // 74lv32a
assign #10 n_rdy = ~rdy; // P-MOSFET
endmodule
