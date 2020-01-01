`timescale 1us/1ns
module test_pointer_pair();

    reg clk;
    reg n_rst;
    reg n_we_l;
    reg n_we_h;
    reg addr_dp;
    reg n_oe_dl;
    reg n_oe_dh;
    reg cnt;
    reg selector;
    reg [7:0] di;
    tri [7:0] data_out;
    tri [15:0] addr_out;

    pointer_pair inst(
        .addr_out(addr_out),
        .data_out(data_out),
        .clk(clk),
        .n_rst(n_rst),
        .di(di),
        .addr_dp(addr_dp),
        .n_oe_dl(n_oe_dl),
        .n_oe_dh(n_oe_dh),
        .cnt(cnt),
        .n_we_l(n_we_l),
        .n_we_h(n_we_h),
        .selector(selector));

    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    initial begin
        $dumpfile("test_pointer_pair.vcd");
        $dumpvars;
        $monitor("clk = %b, n_rst = %b, sel = %b, n_we_l = %b, n_we_h = %b, addr_dp = %b, n_oe_dl = %b, n_oe_dh = %b, di = %h, addr_out = %h, data_out = %h",
                 clk, n_rst, selector, n_we_l, n_we_h, addr_dp, n_oe_dl, n_oe_dh, di, addr_out, data_out);
        clk = 1'b0;
        n_rst = 1'b1;
        n_we_l = 1'b1;
        n_we_h = 1'b1;
        addr_dp = 1'b0;
        n_oe_dl = 1'b1;
        n_oe_dh = 1'b1;
        cnt = 1'b0;
        di = 8'hFE;
        selector = 1'b0;

        assert(1'bx !== 1'b1);
        assert(1'bz === 1'bz);

        $display("initial checks ok");

        #1
        assert(data_out === 8'hz);
        assert(addr_out === 16'h0000);
        #1 clk = 1;
        #1 addr_dp = 1'b0;
        #1
        assert(addr_out === 16'h0);
        assert(data_out === 8'hz);
        #1 clk = 0;
        n_we_l = 1'b0;
        #1
        assert(addr_out === 16'h0);
        #1 clk = 1;
        #1
        assert(addr_out === 16'h0000);
        assert(data_out === 8'hz);
        #1 n_oe_dl = 1'b0;
        #1
        assert(data_out === 8'hfe);
        #1 n_oe_dl = 1'b1;
        #1 n_oe_dh = 1'b0;
        #1
        assert(data_out === 8'h00);
        #1 n_we_l = 1'b1;

        // test count
        cnt = 1;
        n_oe_dh = 1;
        n_oe_dl = 1;
        #1 clk = 0;
        #1
        assert(addr_out === 16'h0000);
        #1 clk = 1;
        #1
        assert(addr_out === 16'h0001);
        #1 clk = 0;
        #1 clk = 1;
        #1
        assert(addr_out === 16'h0002);
        #1
        addr_dp = 1'b1;
        #1
        assert(addr_out === 16'h00fe);


        // test switch
        selector = 1'b1;
        #1
        assert(addr_out === 16'h0002);
        #1
        addr_dp = 1'b0;
        #1
        assert(addr_out === 16'h00fe);
        n_oe_dl = 1'b0;
        #1
        assert(data_out === 8'h02);
    end
endmodule
