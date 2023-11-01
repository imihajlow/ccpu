`timescale 1ns/1ns
module eth_mac_filter(
    input ss,
    input [7:0] d,
    input [3:0] a,
    input n_recv_buf_we,
    output n_inhibit
);
    // Two LSB of MAC should be 10
    // bits 7:5 of MAC are 111
    // bits 4:2 of MAC equal to inverted byte number
    // bits 1:0 of MAC are 10
    // MAC is FE:FA:F6:F2:EE:EA
    wire [2:0] #15 d_xor_a = d[4:2] ^ a[2:0]; // 74hc86
    wire #15 n_d0 = d[0] ^ 1'b1; // 74hc86
    wire #10 d_4320_mac = &d_xor_a & n_d0; // 74hc21
    wire #10 d_7651_set = &d[7:5] & d[1]; // 74hc21
    wire #10 d_4320_set = &d[4:2] & d[0]; // 74hc21

    wire #10 d_4320_ok = d_4320_mac | d_4320_set; // diode logic

    wire last_mac_ok;
    wire #10 next_mac_ok = d_7651_set & d_4320_ok & last_mac_ok & 1'b1; // 74hc21
    d_ff_7474 mac_accum(
        .q(last_mac_ok),
        .d(next_mac_ok),
        .cp(n_recv_buf_we),
        .n_sd(ss),
        .n_cd(1'b1)
    );

    wire #10 a_02 = a[0] & a[2]; // 74hc08
    wire mac_end;
    d_ff_7474 a_eq_6_latch(
        .q(mac_end),
        .d(1'b1),
        .cp(a_02),
        .n_cd(ss),
        .n_sd(1'b1)
    );

    d_ff_7474 mac_ok_latch(
        .q(n_inhibit),
        .d(last_mac_ok),
        .cp(mac_end),
        .n_sd(ss),
        .n_cd(1'b1)
    );

endmodule
