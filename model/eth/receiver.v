`timescale 1ns/1ns
module eth_receiver(
    input n_rst,
    input sck,
    input mosi,
    input ena,
    output [7:0] recv_d,
    output [10:0] recv_byte_cnt,
    output n_recv_buf_we
);
    wire #10 sck_f = sck & ena; // 74hc08

    wire [3:0] bit_count;
    counter_74161 bit_counter(
        .clk(sck_f),
        .clr_n(n_rst),
        .enp(1'b1), // TODO enp goes down when clk is low (not allowed according to datasheet)
        .ent(1'b1),
        .load_n(1'b1),
        .P(4'b0000),
        .Q(bit_count)
    );

    wire byte_clk;
    wire n_byte_clk;
    d_ff_7474 byte_clk_delay(
        .q(byte_clk),
        .n_q(n_byte_clk),
        .d(bit_count[2]),
        .cp(sck_f),
        .n_cd(n_rst),
        .n_sd(1'b1)
    );

    wire #8 rst = ~n_rst; // 74hc04
    wire [11:0] byte_count;
    counter_744040 byte_counter(
        .clk(byte_clk),
        .clr(rst),
        .q(byte_count)
    );

    wire [7:0] data;
    shift_74164 data_input(
          .q(data),
          .cp(sck_f),
          .n_mr(n_rst),
          .dsa(mosi),
          .dsb(mosi)
    );
    genvar i;
    generate
        for (i = 0; i != 8; i = i + 1) begin
            assign recv_d[i] = data[7 - i];
        end
    endgenerate

    assign #10 n_bit_count_2 = ~bit_count[2]; // 74hc04

    wire we;
    d_ff_7474 we_latch(
        .q(we),
        .n_q(n_recv_buf_we),
        .d(1'b1),
        .cp(n_bit_count_2),
        .n_sd(1'b1),
        .n_cd(sck_f)
    );

    assign recv_byte_cnt = byte_count[10:0];
endmodule
