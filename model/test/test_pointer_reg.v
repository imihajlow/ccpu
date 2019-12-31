`timescale 1us/1ns
module test_pointer_reg();

    reg clk;
    reg n_rst;
    reg n_we_l;
    reg n_we_h;
    reg n_oe_addr;
    reg n_oe_dl;
    reg n_oe_dh;
    reg cnt;
    reg [7:0] di;
    tri [7:0] data_out;
    tri [15:0] addr_out;

    pointer_reg inst(
        .addr_out(addr_out),
        .data_out(data_out),
        .clk(clk),
        .n_rst(n_rst),
        .di(di),
        .n_oe_addr(n_oe_addr),
        .n_oe_dl(n_oe_dl),
        .n_oe_dh(n_oe_dh),
        .cnt(cnt),
        .n_we_l(n_we_l),
        .n_we_h(n_we_h));

    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    initial begin
        $dumpfile("test_pointer_reg.vcd");
        $dumpvars;
        $monitor("clk = %b, n_rst = %b, n_we_l = %b, n_we_h = %b, n_oe_addr = %b, n_oe_dl = %b, n_oe_dh = %b, di = %h, addr_out = %h, data_out = %h",
                 clk, n_rst, n_we_l, n_we_h, n_oe_addr, n_oe_dl, n_oe_dh, di, addr_out, data_out);
        clk = 1'b0;
        n_rst = 1'b1;
        n_we_l = 1'b1;
        n_we_h = 1'b1;
        n_oe_addr = 1'b1;
        n_oe_dl = 1'b1;
        n_oe_dh = 1'b1;
        cnt = 1'b0;
        di = 8'hFE;


        #1
        assert(data_out === 8'hz);
        assert(addr_out === 16'hz);
        #1 clk = 1;
        #1 n_oe_addr = 1'b0;
        #1
        assert(addr_out === 16'h0);
        assert(data_out === 8'hz);
        #1 clk = 0;
        n_we_l = 1'b0;
        #1
        assert(addr_out === 16'h0);
        #1 clk = 1;
        #1
        assert(addr_out === 16'h00fe);
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
        assert(addr_out === 16'h00fe);
        #1 clk = 1;
        #1
        assert(addr_out === 16'h00ff);
        #1 clk = 0;
        #1 clk = 1;
        #1
        assert(addr_out === 16'h0100);
    end
endmodule
