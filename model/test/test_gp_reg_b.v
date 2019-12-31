`timescale 1us/1ns
module test_gp_reg_b();
    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    wire [7:0] doa;
    wire [7:0] dob;
    reg [7:0] di;
    reg w_clk;
    reg n_rst;
    reg n_oe_a;
    reg n_oe_b;

    gp_reg_b inst(
            .doa(doa),
            .dob(dob),
            .di(di),
            .w_clk(w_clk),
            .n_rst(n_rst),
            .n_oe_a(n_oe_a),
            .n_oe_b(n_oe_b));

    initial begin
        $dumpfile("test_gp_reg.vcd");
        $dumpvars;

        di = 8'hc3;
        w_clk = 1'b0;
        n_rst = 1'b0;
        n_oe_a = 1'b1;
        n_oe_b = 1'b1;

        #1
        assert(doa === 8'hzz);
        assert(dob === 8'hzz);

        n_oe_a = 1'b0;
        #1
        assert(doa === 8'h00);
        assert(dob === 8'hzz);

        n_oe_b = 1'b0;
        #1
        assert(doa === 8'h00);
        assert(dob === 8'h00);

        n_oe_a = 1'b1;
        #1
        assert(doa === 8'hzz);
        assert(dob === 8'h00);

        n_rst = 1'b1;
        #1
        assert(doa === 8'hzz);
        assert(dob === 8'h00);

        w_clk = 1'b1;
        #1
        assert(doa === 8'hzz);
        assert(dob === 8'hc3);

        di = 8'ha5;
        #1
        assert(doa === 8'hzz);
        assert(dob === 8'hc3);

        w_clk = 1'b0;
        #1
        assert(doa === 8'hzz);
        assert(dob === 8'hc3);

        n_oe_a = 1'b0;
        #1
        assert(doa === 8'hc3);
        assert(dob === 8'hc3);

        n_rst = 1'b0;
        #1
        assert(doa === 8'h00);
        assert(dob === 8'h00);
    end
endmodule
