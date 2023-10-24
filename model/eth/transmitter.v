`timescale 1ns/1ns
module eth_transmitter(
    input n_rst,
    output tx_sck,
    output tx_mosi,
    inout [7:0] d,
    input [15:0] a,
    input n_we,
    input n_oe,
    output n_rdy
);
    reg tx_cp_in; // 20 MHz
    initial begin
        tx_cp_in = 1'b0;
        forever #25 tx_cp_in = ~tx_cp_in;
    end
    assign n_rdy = 1'b0;

    wire [9:0] tx_a;
    wire [7:0] tx_d;
    wire n_tx_buf_oe;
    wire n_tx_buf_we;
    async_ram #(.A_WIDTH(11), .INITIAL_VALUE(38)) tx_buf_ram(
        .a({1'b0, tx_a}),
        .d(tx_d),
        .n_cs(1'b0),
        .n_oe(n_tx_buf_oe),
        .n_we(n_tx_buf_we)
    );

    wire n_tx_hold;
    wire tx_hold;

    wire [3:0] tx_cnt;
    wire n_tx_byte_clk;
    counter_74161 half_bit_counter(
       .clk(tx_cp_in),
       .clr_n(n_tx_hold),
       .enp(1'b1),
       .ent(1'b1),
       .load_n(1'b1),
       .P(4'b0),
       .Q(tx_cnt),
       .rco(n_tx_byte_clk)
    );

    wire [11:0] tx_byte_cnt;
    counter_744040 byte_counter(
        .clk(n_tx_byte_clk),
        .clr(tx_hold),
        .q(tx_byte_cnt)
    );

    wire tx_a_sel;
    mux_74157 tx_a_mux_0(
        .i0(a[3:0]),
        .i1(tx_byte_cnt[3:0]),
        .s(tx_a_sel),
        .n_e(1'b0),
        .z(tx_a[3:0])
    );
    mux_74157 tx_a_mux_4(
        .i0(a[7:4]),
        .i1(tx_byte_cnt[7:4]),
        .s(tx_a_sel),
        .n_e(1'b0),
        .z(tx_a[7:4])
    );
    wire [3:0] tx_a_mux_8_z;
    mux_74157 tx_a_mux_8(
        .i0({2'b00, a[9:8]}),
        .i1({2'b00, tx_byte_cnt[9:8]}),
        .s(tx_a_sel),
        .n_e(1'b0),
        .z(tx_a_mux_8_z)
    );
    assign tx_a[9:8] = tx_a_mux_8_z[1:0];

    wire n_tx_d_oe;
    buffer_74244 buf_d_to_tx_d(
        .i(d),
        .o(tx_d),
        .n_oe1(n_tx_d_oe),
        .n_oe2(n_tx_d_oe)
    );


    wire [7:0] tx_buf_in;
    genvar i;
    generate
        for (i = 0; i != 8; i = i + 1) begin
            assign tx_buf_in[7 - i] = tx_d[i];
        end
    endgenerate

    wire [7:0] tx_buf_d;
    register_74273 reg_tx_buf(
          .q(tx_buf_d),
          .d(tx_buf_in),
          .n_mr(1'b1),
          .cp(tx_cnt[3])
    );

    wire n_tx_shift_pl;
    wire tx_shift_cp;
    wire tx_shift_q7;
    shift_74165 tx_shift(
        .q7(tx_shift_q7),
        // .n_q7(),
        .ds(1'b0),
        .d(tx_buf_d),
        .n_pl(n_tx_shift_pl),
        .cp(tx_shift_cp),
        .n_ce(1'b0)
    );

    wire tx_oe;

    d_ff_7474 ff_shift(
        .q(tx_mosi),
        .d(tx_shift_q7),
        .cp(tx_cnt[0]),
        .n_cd(tx_oe),
        .n_sd(1'b1)
    );

    assign #10 tx_sck = tx_oe & tx_cnt[0];

    d_ff_7474 ff_tx_oe(
        .q(tx_oe),
        .d(1'b1),
        .cp(tx_byte_cnt[0]),
        .n_cd(n_tx_hold),
        .n_sd(1'b1)
    );

    // =====
    assign #10 n_tx_shift_pl = |tx_cnt;
    assign #10 tx_shift_cp = ~tx_cnt[0];

    assign #10 n_tx_buf_oe = ~n_tx_buf_we;
    assign #10 n_tx_buf_we = n_a_buf_sel | n_we;
    assign tx_a_sel = n_tx_buf_we;

    wire #10 n_tx_hold_set = n_rst & ~tx_byte_cnt[10];
    d_ff_7474 ff_hold(
        .q(tx_hold),
        .n_q(n_tx_hold),
        .d(1'b0),
        .cp(n_tx_req),
        .n_cd(1'b1),
        .n_sd(n_tx_hold_set)
    );

    assign n_tx_d_oe = n_tx_buf_we;


    // == copied from receiver system - common part
    wire #10 n_a10 = ~a[10]; // 74hc04
    wire #10 a_cdef_set = &a[15:12]; // 74hc21
    wire #10 a_89nab_set = n_a10 & a[11] & a[9] & a[8]; // 74hc21
    wire #10 n_a_fbxx = ~(a_89nab_set & a_cdef_set); // 74hc04 + diode logic
    wire #10 n_reg_oe_ena = n_oe | n_a_fbxx; // 74hc32
    wire [3:0] n_reg_oe;
    decoder_74139 decoder_reg_oe(
           .n_o(n_reg_oe),
           .a(a[1:0]),
           .n_e(n_reg_oe_ena)
    );
    wire n_oe_cr_to_d = n_reg_oe[0];

    wire [3:0] n_v_cr_we;
    decoder_74139 decoder_cr_we(
           .n_o(n_v_cr_we),
           .a({n_a_fbxx, a[0]}),
           .n_e(n_we)
    );
    wire n_tx_req = n_v_cr_we[1];

    wire #10 n_a11 = ~a[11]; // 74hc04
    wire #10 n_a_buf_sel = ~(n_a11 & a_cdef_set); // 74hc04 + diode logic

endmodule
