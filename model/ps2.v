`timescale 1ns/1ns
module ps2(/*autoport*/
//inout
            d,
//output
            n_clk_out,
            n_data_out,
            rdy,
//input
            n_rst,
            n_clk_in,
            n_data_in,
            n_oe,
            n_we,
            n_sel,
            a);
input wire n_rst;
output wire n_clk_out;
output wire n_data_out;
input wire n_clk_in;
input wire n_data_in;

output wire rdy;
inout wire [7:0] d;
input wire n_oe;
input wire n_we;
input wire n_sel;
input wire a; // 0 - data, 1 - status

wire #10 data_in = ~n_data_in; // 74lv14a
// =========================================
// Receiving part
wire recv_clk;
wire #7 recv_shift_clk = recv_clk & n_has_data; // 74lv08a
wire [15:0] recv_reg_q;
wire [15:0] recv_reg_d;
register_74273 reg_recv_lo(
    .q(recv_reg_q[7:0]),
    .d(recv_reg_d[7:0]),
    .n_mr(n_rst),
    .cp(recv_shift_clk)
);
register_74273 reg_recv_hi(
    .q(recv_reg_q[15:8]),
    .d(recv_reg_d[15:8]),
    .n_mr(n_rst),
    .cp(recv_shift_clk)
);

assign recv_reg_d[9:0] = recv_reg_q[10:1]; // shift in LSB first
assign recv_reg_d[10] = data_in;
assign recv_reg_d[15:11] = 5'h1f; // unused

wire [7:0] recv_byte = recv_reg_q[8:1];
wire recv_par = recv_reg_q[9];

wire #7 n_data_oe = n_oe | n_data_sel; // 74lv32a
buffer_74244 buf_data_out(
    .o(d),
    .i(recv_byte),
    .n_oe1(n_data_oe),
    .n_oe2(n_data_oe)
);

wire #7 n_recv_ovf = ~(recv_cnt[0] & recv_cnt[1] & recv_cnt[3]); // 0 when recv_cnt reaches 11 // 74lv10a
wire recv_full_clk = n_recv_ovf;
wire #7 cnt_recv_rst = ~(n_rst & recv_full_clk & n_send_ena); // 74lv10a
wire #5 n_cnt_recv_rst = ~cnt_recv_rst; // 74lv04a
wire [3:0] recv_cnt;
counter_74161 cnt_recv(
    .clk(recv_clk),
    .clr_n(n_cnt_recv_rst),
    .enp(1'b1),
    .ent(1'b1),
    .load_n(1'b1),
    .P(4'b0),
    .Q(recv_cnt)
);

wire #7 n_status_we = n_status_sel | n_we; // 74lv32a
wire #7 n_recv_rst = n_rst & n_status_we; // 74lv08a

wire has_data;
wire n_has_data;
d_ff_7474 ff_recv_has_data(
    .q(has_data),
    .n_q(n_has_data),
    .d(1'b1),
    .cp(recv_full_clk),
    .n_cd(n_recv_rst),
    .n_sd(1'b1)
);

wire n_recv_clk_out = has_data;
wire recv_clk_out = n_has_data;

assign recv_clk = n_clk_in;

wire #7 recv_cnt_or_01 = recv_cnt[0] | recv_cnt[1]; // 74lv32a
wire #7 recv_cnt_or_23 = recv_cnt[2] | recv_cnt[3]; // 74lv32a
wire #7 n_recv_rdy = recv_cnt_or_01 | recv_cnt_or_23; // 74lv32a

// =========================================
// Sending part

wire #7 n_send_ovf = ~(send_cnt[0] & send_cnt[1] & send_cnt[3]); // 0 when send_cnt reaches 11 // 74lv10a
wire #7 n_send_rst = n_rst & n_send_ovf; // 74lv08a
wire send_ena;
wire n_send_ena;
wire #7 send_ena_clk = n_data_sel | n_we; // 74lv32a
d_ff_7474 ff_send_ena(
    .q(send_ena),
    .n_q(n_send_ena),
    .d(1'b1),
    .cp(send_ena_clk),
    .n_cd(n_send_rst),
    .n_sd(1'b1)
);

// send_req
wire send_req;
wire n_send_req;
wire n_send_req_rst;
d_ff_7474 ff_send_req(
    .q(send_req),
    .n_q(n_send_req),
    .d(1'b1),
    .cp(send_ena),
    .n_cd(n_send_req_rst),
    .n_sd(1'b1)
);
wire #102030 n_send_req_delayed = ~send_req; // RC + inverting Schmitt trigger
assign #7 n_send_req_rst = n_rst & n_send_req_delayed; // 74lv08a
// end send_req

wire #7 n_send_clk_out_rst = data_out & n_rst; // 74lv08a
wire send_clk_out;
wire n_send_clk_out;
d_ff_7474 ff_send_clk_out(
    .q(n_send_clk_out),
    .n_q(send_clk_out),
    .d(1'b1),
    .cp(send_req),
    .n_cd(n_send_clk_out_rst),
    .n_sd(1'b1)
);

wire data_out_ena;
wire n_data_out_ena;
d_ff_7474 ff_data_out_ena(
    .q(data_out_ena),
    .n_q(n_data_out_ena),
    .d(1'b1),
    .cp(n_send_req),
    .n_cd(n_send_rst),
    .n_sd(1'b1)
);

wire send_clk_ena;
wire n_send_clk_ena;
wire #1000 send_clk_ena_clk = ~send_clk_out; // RC + Schmitt inverter
d_ff_7474 ff_send_clk_ena(
    .q(send_clk_ena),
    .n_q(n_send_clk_ena),
    .d(1'b1),
    .cp(send_clk_ena_clk),
    .n_cd(n_send_rst),
    .n_sd(1'b1)
);

wire #7 n_send_clk = n_clk_in | n_send_clk_ena; // 74lv08a

wire send_rdy;
wire n_send_rdy;
d_ff_7474 ff_send_rdy(
    .q(n_send_rdy),
    .n_q(send_rdy),
    .d(1'b1),
    .cp(send_ena_clk),
    .n_cd(n_send_rst),
    .n_sd(1'b1)
);

wire [3:0] send_cnt;
counter_74161 cnt_send(
    .clk(n_send_clk),
    .clr_n(n_send_rst),
    .enp(1'b1),
    .ent(1'b1),
    .load_n(1'b1),
    .P(4'b1111),
    .Q(send_cnt)
);

wire [15:0] send_data;
wire send_data_out_lo;
wire n_send_data_out_lo;
mux_74151 mux_send_lo(
    .n_g(send_cnt[3]),
    .d(send_data[7:0]),
    .a(send_cnt[0]),
    .b(send_cnt[1]),
    .c(send_cnt[2]),
    .y(send_data_out_lo),
    .w(n_send_data_out_lo));

wire #5 n_send_cnt3 = ~send_cnt[3]; // 74lv04a
wire send_data_out_hi;
wire n_send_data_out_hi;
mux_74151 mux_send_hi(
    .n_g(~send_cnt[3]),
    .d(send_data[15:8]),
    .a(send_cnt[0]),
    .b(send_cnt[1]),
    .c(send_cnt[2]),
    .y(send_data_out_hi),
    .w(n_send_data_out_hi));
assign send_data[0] = 1'b0;
parity_74280 par_send(
    .i({send_data[8:1], 1'b0}),
    .pe(send_data[9])
);
assign send_data[15:10] = 6'b111111;

register_74273 reg_send(
    .q(send_data[8:1]),
    .d(d),
    .n_mr(n_rst),
    .cp(send_ena_clk)
);

wire #5 send_ack_clk = ~n_send_ovf; // 74lv04a
wire send_ack;
wire n_send_ack;
d_ff_7474 ff_send_ack(
    .q(send_ack),
    .n_q(n_send_ack),
    .d(data_in),
    .cp(send_ack_clk),
    .n_sd(n_rst),
    .n_cd(1'b1)
);

wire #7 n_send_data_out = n_send_data_out_lo & n_send_data_out_hi; // 74lv08a

// =========================================
// Common part

wire #7 n_data_sel = n_sel | a; // 74lv32a
wire #7 n_a = ~a; // 74lv04a
wire #7 n_status_sel = n_sel | n_a; // 74lv32a

assign #7 n_data_out = n_send_data_out & data_out_ena; // 74lv08a

wire #7 n_ena_recv_clk = send_ena | n_recv_clk_out; // 74lv32a
wire #7 n_ena_send_clk = n_send_ena | n_send_clk_out; // 74lv32a
assign #7 n_clk_out = n_ena_send_clk & n_ena_recv_clk; // 74lv08a
wire #5 data_out = ~n_data_out; // 74lv04a

wire #7 n_common_rdy = n_recv_rdy | n_send_rdy; // 74lv32a
wire #7 common_rdy = ~n_common_rdy; // 74lv04a
assign #7 rdy = n_sel | common_rdy; // 74lv32a

wire #7 n_status_oe = n_oe | n_status_sel; // 74lv32a
wire [7:0] status;
buffer_74244 buf_status_out(
    .o(d),
    .i(status),
    .n_oe1(n_status_oe),
    .n_oe2(n_status_oe)
);

wire recv_valid;
parity_74280 par_recv(
    .i({recv_par, recv_byte}),
    .po(recv_valid)
);
assign status = {5'h0, send_ack, recv_valid, has_data};

endmodule
