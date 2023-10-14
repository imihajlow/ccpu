`timescale 1ns/1ns
module eth_mac_filter(
    input n_rst,
    input sck,
    input sda,
    input n_ss,
    input [7:0] d,
    input [3:0] a,
    input n_we,
    output n_inhibit
);
    // MAC should be of form x2-xx-xx-xx-xx-xx
    // bits 7:5 of MAC are 111
    // bits 4:2 of MAC equal to inverted byte number
    // bits 1:0 of MAC are 10
    wire #10 d_765_set = &d[7:5];
    wire #10 d_43210_set = &d[4:0];
    wire [2:0] #15 d_xor_a = d[4:2] ^ a[2:0];
    wire #10 n_d0 = ~d[0];
    wire #10 d_43210_mac = &d_xor_a & d[1] & n_d0;
    wire #10 mac_ok = d_765_set & (d_43210_mac | d_43210_set);

    wire last_mac_ok;
    wire #10 next_mac_ok = mac_ok & last_mac_ok;
    wire #10 ss = ~n_ss;
    d_ff_7474 mac_accum(
        .q(last_mac_ok),
        .d(next_mac_ok),
        .cp(n_we),
        .n_sd(ss),
        .n_cd(1'b1)
    );

    wire #10 a_02 = a[0] & a[2];
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
        // .n_q(n_we),
        .d(last_mac_ok),
        .cp(mac_end),
        .n_sd(ss),
        .n_cd(1'b1)
    );

endmodule
