`timescale 1ns/1ns
module eth_receiver(
    input n_rst,
    input sck,
    input sda,
    output [7:0] d,
    output [10:0] a,
    output n_we,
    output n_cs
);
    wire [3:0] bit_count;
    counter_74161 bit_counter(
        .clk(sck),
        .clr_n(n_rst),
        .enp(1'b1),
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
        .cp(sck),
        .n_cd(n_rst),
        .n_sd(1'b1)
    );

    wire #8 rst = ~n_rst;
    wire [11:0] byte_count;
    counter_744040 byte_counter(
        .clk(byte_clk),
        .clr(rst),
        .q(byte_count)
    );

    wire [7:0] data;
    shift_74164 data_input(
          .q(data),
          .cp(sck),
          .n_mr(n_rst),
          .dsa(sda),
          .dsb(sda)
    );
    genvar i;
    generate
        for (i = 0; i != 8; i = i + 1) begin
            assign d[i] = data[7 - i];
        end
    endgenerate

    assign n_cs = 1'b0;
    assign #10 n_bit_count_2 = ~bit_count[2];

    wire we;
    d_ff_7474 we_latch(
        .q(we),
        .n_q(n_we),
        .d(1'b1),
        .cp(n_bit_count_2),
        .n_sd(1'b1),
        .n_cd(sck)
    );

    assign a = byte_count[10:0];
endmodule
