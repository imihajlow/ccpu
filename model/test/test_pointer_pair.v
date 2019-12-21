module test_pointer_pair();

    reg clk;
    reg rst;
    reg we_l;
    reg we_h;
    reg oe_addr_ip;
    reg oe_addr_dp;
    reg oe_dl;
    reg oe_dh;
    reg cnt;
    reg selector;
    reg [7:0] di;
    tri [7:0] data_out;
    tri [15:0] addr_out;

    pointer_pair inst(
        .addr_out(addr_out),
        .data_out(data_out),
        .clk(clk),
        .rst(rst),
        .di(di),
        .oe_addr_ip(oe_addr_ip),
        .oe_addr_dp(oe_addr_dp),
        .oe_dl(oe_dl),
        .oe_dh(oe_dh),
        .cnt(cnt),
        .we_l(we_l),
        .we_h(we_h),
        .selector(selector));

    task assert;
        input v;
        if (!v)
            $fatal;
    endtask

    initial begin
        $dumpfile("test_pointer_pair.vcd");
        $dumpvars;
        $monitor("clk = %b, rst = %b, sel = %b, we_l = %b, we_h = %b, oe_addr_ip = %b, oe_addr_dp = %b, oe_dl = %b, oe_dh = %b, di = %h, addr_out = %h, data_out = %h",
                 clk, rst, selector, we_l, we_h, oe_addr_ip, oe_addr_dp, oe_dl, oe_dh, di, addr_out, data_out);
        clk = 1'b0;
        rst = 1'b1;
        we_l = 1'b1;
        we_h = 1'b1;
        oe_addr_ip = 1'b1;
        oe_addr_dp = 1'b1;
        oe_dl = 1'b1;
        oe_dh = 1'b1;
        cnt = 1'b0;
        di = 8'hFE;
        selector = 1'b0;


        assert(data_out == 8'hz);
        assert(addr_out == 16'hz);
        #1 clk = 1;
        #1 oe_addr_ip = 1'b0;
        assert(addr_out == 16'h0);
        assert(data_out == 8'hz);
        #1 clk = 0;
        we_l = 1'b0;
        assert(addr_out == 16'h0);
        #1 clk = 1;
        #1
        assert(addr_out == 16'h0000);
        assert(data_out == 8'hz);
        #1 oe_dl = 1'b0;
        assert(data_out == 8'hfe);
        #1 oe_dl = 1'b1;
        #1 oe_dh = 1'b0;
        assert(data_out == 8'h00);
        #1 we_l = 1'b1;

        // test count
        cnt = 1;
        oe_dh = 1;
        oe_dl = 1;
        #1 clk = 0;
        assert(addr_out == 16'h0000);
        #1 clk = 1;
        #1
        assert(addr_out == 16'h0001);
        #1 clk = 0;
        #1 clk = 1;
        #1
        assert(addr_out == 16'h0002);
        #1 oe_addr_ip = 1'b1;
        oe_addr_dp = 1'b0;
        #1
        assert(addr_out == 16'h00fe);


        // test switch
        selector = 1'b1;
        #1
        assert(addr_out == 16'h0002);
        #1 oe_addr_ip = 1'b0;
        oe_addr_dp = 1'b1;
        #1
        assert(addr_out == 16'h00fe);
        oe_dl = 1'b0;
        #1
        assert(data_out == 8'h02);
    end
endmodule
