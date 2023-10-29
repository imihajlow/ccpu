`timescale 1ns/1ns
module eth_receiver_system(
    input n_rst,
    input recv_sck,
    input recv_mosi,
    input n_recv_ss,
    inout [7:0] d,
    input [15:0] a,
    input n_we,
    input n_oe,
    output n_rdy
);

    wire [10:0] recv_a;
    wire [7:0] recv_d;
    wire [7:0] recv_byte;
    wire [10:0] recv_byte_cnt;

    wire n_recv_buf_oe;
    wire n_recv_buf_we;
    async_ram #(.A_WIDTH(11), .INITIAL_VALUE(38)) recv_buf_ram(
        .a(recv_a),
        .d(recv_d),
        .n_cs(1'b0),
        .n_oe(n_recv_buf_oe),
        .n_we(n_recv_buf_we)
    );

    wire n_recv_d_oe;
    buffer_74244 buf_recv_d_to_d(
        .i(recv_d),
        .o(d),
        .n_oe1(n_recv_d_oe),
        .n_oe2(n_recv_d_oe)
    );

    buffer_74244 buf_recv_byte_to_recv_d(
        .i(recv_byte),
        .o(recv_d),
        .n_oe1(n_recv_ss),
        .n_oe2(n_recv_ss)
    );

    wire recv_a_sel;
    mux_74157 recv_a_mux_0(
        .i0(a[3:0]),
        .i1(recv_byte_cnt[3:0]),
        .s(recv_a_sel),
        .n_e(1'b0),
        .z(recv_a[3:0])
    );
    mux_74157 recv_a_mux_4(
        .i0(a[7:4]),
        .i1(recv_byte_cnt[7:4]),
        .s(recv_a_sel),
        .n_e(1'b0),
        .z(recv_a[7:4])
    );
    wire [3:0] recv_a_mux_8_z;
    mux_74157 recv_a_mux_8(
        .i0({1'b0, a[10:8]}),
        .i1({1'b0, recv_byte_cnt[10:8]}),
        .s(recv_a_sel),
        .n_e(1'b0),
        .z(recv_a_mux_8_z)
    );
    assign recv_a[10:8] = recv_a_mux_8_z[2:0];

    wire n_recv_rst;
    wire recv_sck_ena;
    eth_receiver receiver(
        .n_rst(n_recv_rst),
        .sck(recv_sck),
        .mosi(recv_mosi),
        .ena(recv_sck_ena),
        .recv_d(recv_byte),
        .recv_byte_cnt(recv_byte_cnt),
        .n_recv_buf_we(n_recv_buf_we)
    );

    wire n_recv_byte_cnt_lo_oe;
    buffer_74244 buf_byte_cnt_lo_to_d(
        .i(recv_byte_cnt[7:0]),
        .o(d),
        .n_oe1(n_recv_byte_cnt_lo_oe),
        .n_oe2(n_recv_byte_cnt_lo_oe)
    );
    wire n_recv_byte_cnt_hi_oe;
    buffer_74244 buf_byte_cnt_hi_to_d(
        .i({5'h0, recv_byte_cnt[10:8]}),
        .o(d),
        .n_oe1(n_recv_byte_cnt_hi_oe),
        .n_oe2(n_recv_byte_cnt_hi_oe)
    );

    wire n_inhibit;
    eth_mac_filter filter(
        .ss(recv_ss),
        .d(recv_byte),
        .a(recv_byte_cnt[3:0]),
        .n_recv_buf_we(n_recv_buf_we),
        .n_inhibit(n_inhibit)
    );

    assign #10 n_recv_rst = n_clr_frame_received & n_inhibit; // 74hc08


    wire #10 recv_ss = ~n_recv_ss; // 74hc04
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
    assign n_recv_byte_cnt_lo_oe = n_reg_oe[2];
    assign n_recv_byte_cnt_hi_oe = n_reg_oe[3];

    wire [3:0] n_v_cr_we;
    decoder_74139 decoder_cr_we(
           .n_o(n_v_cr_we),
           .a({n_a_fbxx, a[0]}),
           .n_e(n_we)
    );
    wire n_rearm_req = n_v_cr_we[0];

    wire #10 n_a11 = ~a[11]; // 74hc04
    wire #10 n_a_buf_sel = ~(n_a11 & a_cdef_set); // 74hc04 + diode logic

    wire buf_full;
    wire rearm_sched;
    d_ff_7474 latch_rearm(
        .q(rearm_sched),
        .d(1'b0),
        .cp(1'b0),
        .n_cd(recv_ss),
        .n_sd(n_rearm_req)
    );
    wire #10 n_rearm_sched = ~rearm_sched; // 74hc04
    wire #10 n_rearm = recv_ss | n_rearm_sched; // 74hc32
    wire #10 n_clr_frame_received = n_rst & n_rearm; // 74hc08

    d_ff_7474 latch_frame_received(
        .q(buf_full),
        .n_q(recv_sck_ena),
        .d(n_inhibit),
        .cp(n_recv_ss),
        .n_cd(n_clr_frame_received),
        .n_sd(1'b1)
    );
    buffer_74244 buf_cr_to_d(
        .i({7'b0, buf_full}),
        .o(d),
        .n_oe1(n_oe_cr_to_d),
        .n_oe2(n_oe_cr_to_d)
    );

    assign #10 recv_a_sel = recv_sck_ena & recv_ss; // 74hc08
    assign #10 n_recv_d_oe = n_a_buf_sel | n_oe; // 74hc32
    assign #10 n_recv_buf_oe = n_recv_d_oe | recv_a_sel; // 74hc32

    // =====

    assign n_rdy = 1'b0;

    // Bus contention checks
    wire [2:0] d_oe_count = n_recv_d_oe + n_oe_cr_to_d + n_recv_byte_cnt_lo_oe + n_recv_byte_cnt_hi_oe;
    always @(d_oe_count or n_rst) begin
        if (n_rst) begin
            if (d_oe_count < 3) begin
                $display("d bus contention");
                #10
                $fatal;
            end
        end
    end

    wire [1:0] recv_d_oe_count = n_recv_buf_oe + n_recv_ss;
    always @(recv_d_oe_count or n_rst) begin
        if (n_rst) begin
            if (recv_d_oe_count < 1) begin
                $display("recv_d bus contention");
                #10
                $fatal;
            end
        end
    end

    always @(n_recv_buf_oe or n_recv_buf_we) begin
        if (~(n_recv_buf_oe | n_recv_buf_we)) begin
            $display("both WE and OE asserted at once");
            #10
            $fatal;
        end
    end
endmodule
