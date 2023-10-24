`timescale 1ns/1ns
module test_transmitter();
    localparam BUF_ADDR = 16'hF000;
    localparam CR_ADDR = 16'hFB00;
    localparam TX_RST_ADDR = 16'hFB01;
    localparam CR_TX_RDY_MASK = 8'h02;
    localparam CR_TX_RDY_VAL = 8'h02;

    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    task write;
        input [15:0] addr;
        input [7:0] data;

        begin
            a = addr;
            d_in = data;
            d_ena = 1'b1;
            #471
            n_we = 1'b0;
            #522
            wait(~n_rdy);
            n_we = 1'b1;
            #534
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
            #507
            n_oe = 1'b0;
            #505
            wait(~n_rdy);
            if ((d & data_mask) !== expected_data) begin
                $display("read at addr %0h: expected %0h, got %0h", addr, expected_data, d);
                #5
                $fatal;
            end
            n_oe = 1'b1;
            #504;
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
                #503
                n_oe = 1'b0;
                #499
                wait(~n_rdy);
                if ((d & data_mask) === expected_data) begin
                    f = 1'b0;
                end
                n_oe = 1'b1;
                #502;
            end
            n_oe = 1'b1;
            #500;
        end
    endtask

    task recv_and_check;
        input [7:0] expected_data;

        reg [7:0] x;
        integer i;
        begin
            x = 8'b0;
            for (i = 0; i != 8; i = i + 1) begin
                wait(tx_sck);
                wait(~tx_sck);
                x = {tx_mosi, x[7:1]};
            end
            if (x !== expected_data) begin
                $display("recv failed: expected %0h, got %0h", expected_data, x);
                #5
                $fatal;
            end else begin
                // $display("recv %0h ok", x);
            end
        end
    endtask

    function [7:0] get_tx_data;
        input [15:0] addr;
        begin
            get_tx_data =  (addr[7:0] + 16'd1) * 16'd239 + addr[9:2] * 16'd113;
        end
    endfunction

    initial begin
        $dumpfile("test_transmitter.vcd");
        $dumpvars;
    end

    reg n_rst;
    reg [7:0] d_in;
    reg d_ena;
    wire [7:0] d = d_ena ? d_in : 8'bz;
    reg [15:0] a;
    reg n_we;
    reg n_oe;
    wire n_rdy;
    wire tx_sck;
    wire tx_mosi;
    eth_transmitter inst(
        .n_rst(n_rst),
        .tx_sck(tx_sck),
        .tx_mosi(tx_mosi),
        .d(d),
        .a(a),
        .n_we(n_we),
        .n_oe(n_oe),
        .n_rdy(n_rdy)
    );

    integer i;
    initial begin
        n_rst = 1'b0;
        n_we = 1'b1;
        n_oe = 1'b1;
        #1013
        n_rst = 1'b1;
        #101
        for (i = 16'hf000; i != 16'hf400; i = i + 1) begin
            write(i[15:0], get_tx_data(i[15:0]));
        end
        write(TX_RST_ADDR, 8'b0);
    end


    integer j;
    reg wait_for_extra_sck;
    initial begin
        wait(~n_rst);
        wait(n_rst);
        #50
        for (j = 0; j != 1024; j = j + 1) begin
            recv_and_check(get_tx_data(j[15:0]));
        end
        wait_for_extra_sck = 1'b1;
        #50000
        $finish;
    end

    initial begin
        wait_for_extra_sck = 1'b0;
        wait(wait_for_extra_sck);
        wait(tx_sck);
        $display("unexpected sck transition after receiving all data");
        $fatal;
    end

    initial begin
        #2500000
        $display("timeout");
        $fatal;
    end

endmodule
