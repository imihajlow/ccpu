`timescale 1ns/1ns
/*
5. read while receiving
    process 1:
        transmit frame with MAC ok
    process 2:
        check if none of the following leads to a bus contention:
            set a to size register address, set n_oe
            set a to buffer address, set n_oe
*/
module test_rs_5();
    localparam CR_ADDR = 16'hFB00;
    localparam RECV_LEN_LO_ADDR = 16'hFB02;
    localparam RECV_LEN_HI_ADDR = 16'hFB03;
    localparam CR_RECV_FULL_MASK = 8'h01;
    localparam CR_RECV_FULL_VAL = 8'h01;
    localparam CR_RECV_FULL_RESET = 8'hFE;

    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    initial begin
        $dumpfile("test_rs_5.vcd");
        $dumpvars;
    end

    reg [15:0] a;
    reg [7:0] d_in;
    reg d_ena;
    wire [7:0] d = d_ena ? d_in : 8'bz;
    reg n_oe;
    reg n_we;
    reg n_rst;
    wire n_rdy;

    reg n_ss;
    reg sck;
    reg mosi;

    eth_receiver_system inst(
        .n_rst(n_rst),
        .recv_sck(sck),
        .recv_mosi(mosi),
        .n_recv_ss(n_ss),
        .d(d),
        .a(a),
        .n_we(n_we),
        .n_oe(n_oe),
        .n_rdy(n_rdy)
    );

    initial begin
        d_ena = 1'b0;
        a = 16'h0000;
        d_in = 8'h00;
        n_oe = 1'b1;
        n_we = 1'b1;
        n_rst = 1'b0;
        n_ss = 1'b1;
        sck = 1'b0;
        mosi = 1'b0;
    end

    task write;
        input [15:0] addr;
        input [7:0] data;

        begin
            a = addr;
            d_in = data;
            d_ena = 1'b1;
            #500
            n_we = 1'b0;
            #500
            wait(~n_rdy);
            n_we = 1'b1;
            #500
            d_ena = 1'b0;
        end
    endtask

    task read_and_check;
        input [15:0] addr;
        input [7:0] data_mask;
        input [7:0] expected_data;

        begin
            a = addr;
            d_ena = 1'b0;
            #500
            n_oe = 1'b0;
            #500
            wait(~n_rdy);
            if ((d & data_mask) !== expected_data) begin
                $display("read at addr %0h: expected %0h, got %0h", addr, expected_data, d);
                #5
                $fatal;
            end
            n_oe = 1'b1;
            #500;
        end
    endtask

    task read_and_wait;
        input [15:0] addr;
        input [7:0] data_mask;
        input [7:0] expected_data;

        reg f;
        begin
            f = 1'b1;
            while (f) begin
                a = addr;
                d_ena = 1'b0;
                #500
                n_oe = 1'b0;
                #500
                wait(~n_rdy);
                if ((d & data_mask) === expected_data) begin
                    f = 1'b0;
                end
                n_oe = 1'b1;
                #500;
            end
            n_oe = 1'b1;
            #500;
        end
    endtask

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

    task start_frame;
        begin
            n_ss = 1'b0;
        end
    endtask

    task end_frame;
        begin
            #20
            sck = 1'b0;
            #200
            n_ss = 1'b1;
        end
    endtask

    reg frame_done;
    initial begin
        frame_done = 1'b0;
        #150
        n_rst = 1'b1;
        #150
        start_frame();
        transmit_byte(8'b111_111_10);
        transmit_byte(8'b111_110_10);
        transmit_byte(8'b111_101_10);
        transmit_byte(8'b111_100_10);
        transmit_byte(8'b111_011_10);
        transmit_byte(8'b111_010_10);
        transmit_byte(8'haa);
        transmit_byte(8'h55);
        transmit_byte(8'h73);
        transmit_byte(8'h87);
        end_frame();
        #200;
        frame_done = 1'b1;
    end

    integer i;
    initial begin
        wait(n_rst);
        #100
        while (~frame_done) begin
            a = CR_ADDR;
            #50
            n_oe = 1'b0;
            #50
            n_oe = 1'b1;
            a = RECV_LEN_LO_ADDR;
            #50
            n_oe = 1'b0;
            #50
            n_oe = 1'b1;
            a = RECV_LEN_HI_ADDR;
            #50
            n_oe = 1'b0;
            #50
            n_oe = 1'b1;
            a = 16'hf000;
            #50
            n_oe = 1'b0;
            #50
            n_oe = 1'b1;
            a = 16'hf003;
            #50
            n_oe = 1'b0;
            #50
            n_oe = 1'b1;
        end

        read_and_wait(CR_ADDR, CR_RECV_FULL_MASK, CR_RECV_FULL_VAL);

        read_and_check(RECV_LEN_LO_ADDR, 8'hff, 8'd9);
        read_and_check(RECV_LEN_HI_ADDR, 8'hff, 8'd0);
        read_and_check(16'hF000 + 'd0, 8'hff, 8'b111_111_10);
        read_and_check(16'hF000 + 'd1, 8'hff, 8'b111_110_10);
        read_and_check(16'hF000 + 'd2, 8'hff, 8'b111_101_10);
        read_and_check(16'hF000 + 'd3, 8'hff, 8'b111_100_10);
        read_and_check(16'hF000 + 'd4, 8'hff, 8'b111_011_10);
        read_and_check(16'hF000 + 'd5, 8'hff, 8'b111_010_10);
        read_and_check(16'hF000 + 'd6, 8'hff, 8'haa);
        read_and_check(16'hF000 + 'd7, 8'hff, 8'h55);
        read_and_check(16'hF000 + 'd8, 8'hff, 8'h73);
        read_and_check(16'hF000 + 'd9, 8'hff, 8'h87);
        #200
        $finish;
    end

    initial begin
        #150000
        $display("timeout");
        $fatal;
    end
endmodule
