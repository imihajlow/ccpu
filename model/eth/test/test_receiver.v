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
    reg sda;
    reg n_rst;

    wire [7:0] d;
    wire [10:0] a;
    wire n_we;
    wire n_cs;

    eth_receiver inst(
        .n_rst(n_rst),
        .sck(sck),
        .sda(sda),
        .d(d),
        .a(a),
        .n_we(n_we),
        .n_cs(n_cs)
    );

    initial begin
        sck = 1'b0;
        sda = 1'b0;
        n_rst = 1'b0;
        #200
        n_rst = 1'b1;
    end

    task transmit_byte;
        input [7:0] val;

        integer i;
        begin
            for (i = 0; i != 8; i = i + 1) begin
                sda = val[i];
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
        transmit_byte(8'h10);
        transmit_byte(8'hd5);
        transmit_byte(8'h20);
        transmit_byte(8'hff);
        transmit_byte(8'h00);
        transmit_byte(8'ha5);
        transmit_byte(8'h73);
        #20
        sck = 1'b0;
        #100;
    end

    initial begin
        wait(~n_rst);
        wait(n_rst);

        wait(~(n_we | n_cs));
        wait(n_we);
        assert(a === 11'd0);
        assert(d === 8'h10);

        wait(~(n_we | n_cs));
        wait(n_we);
        assert(a === 11'd1);
        assert(d === 8'hd5);

        wait(~(n_we | n_cs));
        wait(n_we);
        assert(a === 11'd2);
        assert(d === 8'h20);

        wait(~(n_we | n_cs));
        wait(n_we);
        assert(a === 11'd3);
        assert(d === 8'hff);

        wait(~(n_we | n_cs));
        wait(n_we);
        assert(a === 11'd4);
        assert(d === 8'h00);

        wait(~(n_we | n_cs));
        wait(n_we);
        assert(a === 11'd5);
        assert(d === 8'ha5);

        wait(~(n_we | n_cs));
        wait(n_we);
        assert(a === 11'd6);
        assert(d === 8'h73);

        #1000
        $finish;
    end

    initial begin
        #10000
        $display("timeout");
        $fatal;
    end
endmodule
