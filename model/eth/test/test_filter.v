`timescale 1ns/1ns
module test_filter();
    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    initial begin
        $dumpfile("test_filter.vcd");
        $dumpvars;
    end

    reg sck;
    reg mosi;
    reg n_ss;
    reg n_rst;
    reg recv_ena;

    wire [7:0] d;
    wire [10:0] a;
    wire n_recv_buf_we;

    eth_receiver recv_inst(
        .n_rst(n_rst),
        .sck(sck),
        .mosi(mosi),
        .ena(recv_ena),
        .recv_d(d),
        .recv_byte_cnt(a),
        .n_recv_buf_we(n_recv_buf_we)
    );


    wire n_inhibit;
    eth_mac_filter filter_inst(
        .n_ss(n_ss),
        .d(d),
        .a(a[3:0]),
        .n_recv_buf_we(n_recv_buf_we),
        .n_inhibit(n_inhibit)
    );

    initial begin
        sck = 1'b0;
        mosi = 1'b0;
        n_ss = 1'b1;
        n_rst = 1'b0;
        recv_ena = 1'b1;
        #200
        n_rst = 1'b1;
    end

    task transmit_byte;
        input [7:0] val;

        integer i;
        begin
            for (i = 0; i != 8; i = i + 1) begin
                mosi = val[i];
                #20
                sck = 1'b0;
                #30
                sck = 1'b1;
                #50;
            end
        end
    endtask

    initial begin
        #300
        // frame 1 - MAC OK
        n_ss = 1'b0;
        transmit_byte(8'b111_111_10);
        transmit_byte(8'b111_110_10);
        transmit_byte(8'b111_101_10);
        transmit_byte(8'b111_100_10);
        transmit_byte(8'b111_011_10);
        transmit_byte(8'b111_010_10);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        #300
        sck = 1'b0;
        n_ss = 1'b1;
        #1000;

        // frame 2 - wrong MAC - one of bits [7:5] is 0
        n_ss = 1'b0;
        transmit_byte(8'b111_111_10);
        transmit_byte(8'b110_110_10);
        transmit_byte(8'b111_101_10);
        transmit_byte(8'b111_100_10);
        transmit_byte(8'b111_011_10);
        transmit_byte(8'b111_010_10);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        #300
        sck = 1'b0;
        n_ss = 1'b1;
        #1000;

        // frame 3 - MAC broadcast
        n_ss = 1'b0;
        transmit_byte(8'hff);
        transmit_byte(8'hff);
        transmit_byte(8'hff);
        transmit_byte(8'hff);
        transmit_byte(8'hff);
        transmit_byte(8'hff);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        #300
        sck = 1'b0;
        n_ss = 1'b1;
        #1000;

        // frame 4 - wrong MAC - one of bits [4:2] is wrong
        n_ss = 1'b0;
        transmit_byte(8'b111_111_10);
        transmit_byte(8'b110_110_10);
        transmit_byte(8'b111_101_10);
        transmit_byte(8'b111_100_10);
        transmit_byte(8'b111_010_10);
        transmit_byte(8'b111_010_10);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        #300
        sck = 1'b0;
        n_ss = 1'b1;
        #1000;

        // frame 5 - wrong MAC - one of bits [1:0] is wrong
        n_ss = 1'b0;
        transmit_byte(8'b111_111_10);
        transmit_byte(8'b111_110_10);
        transmit_byte(8'b111_101_11);
        transmit_byte(8'b111_100_10);
        transmit_byte(8'b111_011_10);
        transmit_byte(8'b111_010_10);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        transmit_byte(8'h77);
        transmit_byte(8'h88);
        #300
        sck = 1'b0;
        n_ss = 1'b1;
        #1000;
    end

    initial begin
        wait(~n_rst);
        wait(n_rst);

        // frame 1 - MAC OK
        wait(~n_ss);
        wait(n_ss | ~n_inhibit);
        assert(n_inhibit === 1'b1);
        assert(n_ss === 1'b1);

        // frame 2 - wrong MAC
        wait(~n_ss);
        wait(n_ss | ~n_inhibit);
        assert(n_inhibit === 1'b0);
        assert(n_ss === 1'b0);
        wait(n_ss);
        #100
        assert(n_inhibit === 1'b1);

        // frame 1 - MAC OK
        wait(~n_ss);
        wait(n_ss | ~n_inhibit);
        assert(n_inhibit === 1'b1);
        assert(n_ss === 1'b1);

        // frame 4 - wrong MAC
        wait(~n_ss);
        wait(n_ss | ~n_inhibit);
        assert(n_inhibit === 1'b0);
        assert(n_ss === 1'b0);
        wait(n_ss);
        #100
        assert(n_inhibit === 1'b1);

        // frame 5 - wrong MAC
        wait(~n_ss);
        wait(n_ss | ~n_inhibit);
        assert(n_inhibit === 1'b0);
        assert(n_ss === 1'b0);
        wait(n_ss);
        #100
        assert(n_inhibit === 1'b1);

        #1000
        $finish;
    end

    initial begin
        #150000
        $display("timeout");
        $fatal;
    end
endmodule
