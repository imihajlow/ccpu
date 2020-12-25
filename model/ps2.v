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
            clk_in,
            data_in,
            n_oe,
            n_we,
            n_sel,
            a);
input wire n_rst;
output wire n_clk_out;
output wire n_data_out;
input wire clk_in;
input wire data_in;

output wire rdy;
inout wire [7:0] d;
input wire n_oe;
input wire n_we;
input wire n_sel;
input wire a; // 0 - data, 1 - status

// =========================================
// Receiving part
wire recv_clk;
wire [15:0] recv_reg_q;
wire [15:0] recv_reg_d;
register_74273 reg_recv_lo(
    .q(recv_reg_q[7:0]),
    .d(recv_reg_d[7:0]),
    .n_mr(n_rst),
    .cp(recv_clk)
);
register_74273 reg_recv_hi(
    .q(recv_reg_q[15:8]),
    .d(recv_reg_d[15:8]),
    .n_mr(n_rst),
    .cp(recv_clk)
);

assign recv_reg_d[9:0] = recv_reg_q[10:1]; // shift in LSB first
assign recv_reg_d[10] = data_in;
assign recv_reg_d[15:11] = 5'h0; // unused

wire n_data_oe;
buffer_74244 buf_data_out(
    .o(d),
    .i(recv_reg_q[8:1]),
    .n_oe1(n_data_oe),
    .n_oe2(n_data_oe)
);

wire n_status_oe;
wire [7:0] status;
buffer_74244 buf_status_out(
    .o(d),
    .i(status),
    .n_oe1(n_status_oe),
    .n_oe2(n_status_oe)
);

wire #40 valid = ^recv_reg_q[9:1];
assign status = {6'h0, valid, has_data};

wire n_cnt_recv_rst;
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

wire #20 has_data = recv_cnt != 4'd0;
assign #20 n_cnt_recv_rst = n_rst & (n_we | n_sel | ~a); // write to status register causes reset

assign #10 n_data_oe = n_oe | n_sel | a;
assign #10 n_status_oe = n_oe | n_sel | ~a;

wire #20 n_recv_ena = recv_cnt == 4'd11;
wire n_recv_clk = clk_in;
assign #10 recv_clk = ~n_recv_clk | n_recv_ena;

wire #10 recv_rdy = (recv_cnt == 4'd0) | (recv_cnt == 4'd11);

// =========================================
// Sending part

assign #10 n_clk_out = n_recv_ena;
assign n_data_out = 0;

// wire #10 n_send_rst = n_rst & (send_cnt != 4'd11);
// wire send_ena;
// d_ff_7474 ff_send_ena(
//     .q(send_ena),
//     .d(1'b1),
//     .cp(send_reg_clk),
//     .n_cd(n_send_rst),
//     .n_sd(1'b1)
// );

// // send_req
// d_ff_7474 ff_send_req(
//     .q(send_req),
//     .d(1'b1),
//     .cp(send_reg_clk),
//     .n_cd(n_send_req_rst),
//     .n_sd(1'b1)
// );
// wire #102030 n_send_req_rst = ~send_reg_q; // RC + inverting Schmitt trigger
// // end send_req

// wire n_send_clk_out;
// wire #10 n_send_clk_out_rst = n_rst & ~n_data_out;
// d_ff_7474 ff_send_clk_out(
//     .n_q(n_send_clk_out),
//     .d(1'b1),
//     .cp(send_req),
//     .n_cd(n_send_clk_out_rst),
//     .n_sd(1'b1)
// );

// wire #10 send_clk = ~clk_in | ~send_ena;

// wire [3:0] send_cnt;
// counter_74161 cnt_send(
//     .clk(send_clk),
//     .clr_n(n_send_rst),
//     .enp(1'b1),
//     .ent(1'b1),
//     .load_n(1'b1),
//     .P(4'b0),
//     .Q(recv_cnt)
// );

// wire [7:0] send_reg_q;
// wire #10 send_reg_clk = n_sel | n_we | a;
// register_74273 reg_send(
//     .q(send_reg_q),
//     .d(d),
//     .n_mr(n_rst),
//     .cp(send_reg_clk)
// );

assign #10 rdy = n_sel | (a | recv_rdy);
endmodule
