module test_pointer_reg();

    reg clk;
    reg rst;
    reg we_l;
    reg we_h;
    reg oe_addr;
    reg oe_dl;
    reg oe_dh;
    reg cnt;
    reg [7:0] di;
    tri [7:0] data_out;
    tri [15:0] addr_out;

    pointer_reg inst(
        .addr_out(addr_out),
        .data_out(data_out),
        .clk(clk),
        .rst(rst),
        .di(di),
        .oe_addr(oe_addr),
        .oe_dl(oe_dl),
        .oe_dh(oe_dh),
        .cnt(cnt),
        .we_l(we_l),
        .we_h(we_h));

    task assert;
        input v;
        if (!v)
            $fatal;
    endtask

    initial begin
        $dumpfile("test_pointer_reg.vcd");
        $dumpvars;
        $monitor("clk = %b, rst = %b, we_l = %b, we_h = %b, oe_addr = %b, oe_dl = %b, oe_dh = %b, di = %h, addr_out = %h, data_out = %h",
                 clk, rst, we_l, we_h, oe_addr, oe_dl, oe_dh, di, addr_out, data_out);
        clk = 1'b0;
        rst = 1'b1;
        we_l = 1'b1;
        we_h = 1'b1;
        oe_addr = 1'b1;
        oe_dl = 1'b1;
        oe_dh = 1'b1;
        cnt = 1'b0;
        di = 8'hFE;


        assert(data_out == 8'hz);
        assert(addr_out == 16'hz);
        #1 clk = 1;
        #1 oe_addr = 1'b0;
        assert(addr_out == 16'h0);
        assert(data_out == 8'hz);
        #1 clk = 0;
        we_l = 1'b0;
        assert(addr_out == 16'h0);
        #1 clk = 1;
        #1
        assert(addr_out == 16'h00fe);
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
        assert(addr_out == 16'h00fe);
        #1 clk = 1;
        #1
        assert(addr_out == 16'h00ff);
        #1 clk = 0;
        #1 clk = 1;
        #1
        assert(addr_out == 16'h0100);
    end
endmodule
