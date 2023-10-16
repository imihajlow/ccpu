`timescale 1ns/1ns
module test_receiver();
    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    initial begin
        $dumpfile("test_receiver.vcd");
        $dumpvars;
    end

    reg sck;
    reg mosi;
    reg n_rst;
    reg ena;

    wire [7:0] d;
    wire [10:0] a;
    wire n_recv_buf_we;

    eth_receiver inst(
        .n_rst(n_rst),
        .sck(sck),
        .mosi(mosi),
        .ena(ena),
        .recv_d(d),
        .recv_a(a),
        .n_recv_buf_we(n_recv_buf_we)
    );

    initial begin
        sck = 1'b0;
        mosi = 1'b0;
        n_rst = 1'b0;
        ena = 1'b1;
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
        // Enable receiver
        ena = 1'b1;
        #300
        transmit_byte(8'h10);
        transmit_byte(8'hd5);
        transmit_byte(8'h20);
        transmit_byte(8'hff);
        transmit_byte(8'h00);
        transmit_byte(8'ha5);
        transmit_byte(8'h73);
        #20
        sck = 1'b0;

        // Reset
        #100;
        n_rst = 1'b0;
        #100;
        n_rst = 1'b1;

        // Disable receiver
        #200
        ena = 1'b0;
        #200
        transmit_byte(8'h10);
        transmit_byte(8'hd5);
        transmit_byte(8'h20);
        transmit_byte(8'hff);
        #20
        sck = 1'b0;

        // Enable again
        #300;
        ena = 1'b1;
        #100
        transmit_byte(8'hff);
        transmit_byte(8'h00);
        transmit_byte(8'ha5);
        transmit_byte(8'h73);
        #20
        sck = 1'b0;

        #300;
    end

    initial begin
        wait(~n_rst);
        wait(n_rst);

        wait(~n_recv_buf_we);
        wait(n_recv_buf_we);
        assert(a === 11'd0);
        assert(d === 8'h10);

        wait(~n_recv_buf_we);
        wait(n_recv_buf_we);
        assert(a === 11'd1);
        assert(d === 8'hd5);

        wait(~n_recv_buf_we);
        wait(n_recv_buf_we);
        assert(a === 11'd2);
        assert(d === 8'h20);

        wait(~n_recv_buf_we);
        wait(n_recv_buf_we);
        assert(a === 11'd3);
        assert(d === 8'hff);

        wait(~n_recv_buf_we);
        wait(n_recv_buf_we);
        assert(a === 11'd4);
        assert(d === 8'h00);

        wait(~n_recv_buf_we);
        wait(n_recv_buf_we);
        assert(a === 11'd5);
        assert(d === 8'ha5);

        wait(~n_recv_buf_we);
        wait(n_recv_buf_we);
        assert(a === 11'd6);
        assert(d === 8'h73);

        // wait reset
        wait(~n_rst);
        wait(n_rst);
        wait(~ena);
        #100
        assert(n_recv_buf_we);
        // wait enable
        wait(ena | ~n_recv_buf_we);
        assert(n_recv_buf_we);
        assert(ena);

        wait(~n_recv_buf_we);
        wait(n_recv_buf_we);
        assert(a === 11'd0);
        assert(d === 8'hff);

        wait(~n_recv_buf_we);
        wait(n_recv_buf_we);
        assert(a === 11'd1);
        assert(d === 8'h00);

        wait(~n_recv_buf_we);
        wait(n_recv_buf_we);
        assert(a === 11'd2);
        assert(d === 8'ha5);

        wait(~n_recv_buf_we);
        wait(n_recv_buf_we);
        assert(a === 11'd3);
        assert(d === 8'h73);

        #1000
        $finish;
    end

    initial begin
        #100000
        $display("timeout");
        $fatal;
    end
endmodule
