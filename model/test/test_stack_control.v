`timescale 1us/1ns
module test_stack_control();

    reg n_we;
    reg n_oe;
    reg [15:0] a;
    reg [7:0] d;
    reg n_rst;

    wire n_load_0;
    wire n_load_1;
    wire up_0;
    wire up_1;
    wire down_0;
    wire down_1;
    wire n_oe_d_0;
    wire n_oe_d_1;
    wire n_oe_ia_0;
    wire n_oe_ia_1;
    wire n_ce_bank;

    stack_control inst(
        .n_we(n_we),
        .n_oe(n_oe),
        .a(a),
        .d(d),
        .n_rst(n_rst),
        .n_load_0(n_load_0),
        .n_load_1(n_load_1),
        .up_0(up_0),
        .up_1(up_1),
        .down_0(down_0),
        .down_1(down_1),
        .n_oe_d_0(n_oe_d_0),
        .n_oe_d_1(n_oe_d_1),
        .n_oe_ia_0(n_oe_ia_0),
        .n_oe_ia_1(n_oe_ia_1),
        .n_ce_bank(n_ce_bank)
    );

    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    integer i, j;

    initial begin
        $dumpfile("test_stack_control.vcd");
        $dumpvars;

        n_we = 1'b1;
        n_oe = 1'b1;
        a = 16'h0000;
        d = 8'h00;
        n_rst = 1'b0;
        #1

        assert(n_load_0 === 1'b1);
        assert(n_load_1 === 1'b1);
        assert(up_0 === 1'b1);
        assert(up_1 === 1'b1);
        assert(down_0 === 1'b1);
        assert(down_1 === 1'b1);
        assert(n_oe_d_0 === 1'b1);
        assert(n_oe_d_1 === 1'b1);
        assert(n_oe_ia_0 === a[12]);
        assert(n_oe_ia_1 === ~a[12]);
        assert(n_ce_bank === 1'b1);

        n_rst = 1'b1;
        #1
        assert(n_load_0 === 1'b1);
        assert(n_load_1 === 1'b1);
        assert(up_0 === 1'b1);
        assert(up_1 === 1'b1);
        assert(down_0 === 1'b1);
        assert(down_1 === 1'b1);
        assert(n_oe_d_0 === 1'b1);
        assert(n_oe_d_1 === 1'b1);
        assert(n_oe_ia_0 === a[12]);
        assert(n_oe_ia_1 === ~a[12]);
        assert(n_ce_bank === 1'b1);

        // by default stack is disabled, check that
        a = 16'hC000;
        #1
        assert(n_load_0 === 1'b1);
        assert(n_load_1 === 1'b1);
        assert(up_0 === 1'b1);
        assert(up_1 === 1'b1);
        assert(down_0 === 1'b1);
        assert(down_1 === 1'b1);
        assert(n_oe_d_0 === 1'b1);
        assert(n_oe_d_1 === 1'b1);
        assert(n_oe_ia_0 === a[12]);
        assert(n_oe_ia_1 === ~a[12]);
        assert(n_ce_bank === 1'b1);

        for (i = 0; i != 2; i = i + 1) begin
            // counters read 
            a = 16'hFC00;
            #1
            assert(n_load_0 === 1'b1);
            assert(n_load_1 === 1'b1);
            assert(up_0 === 1'b1);
            assert(up_1 === 1'b1);
            assert(down_0 === 1'b1);
            assert(down_1 === 1'b1);
            assert(n_oe_d_0 === 1'b1);
            assert(n_oe_d_1 === 1'b1);
            assert(n_oe_ia_0 === a[12]);
            assert(n_oe_ia_1 === ~a[12]);
            assert(n_ce_bank === 1'b1);

            n_oe = 1'b0;
            #1
            assert(n_load_0 === 1'b1);
            assert(n_load_1 === 1'b1);
            assert(up_0 === 1'b1);
            assert(up_1 === 1'b1);
            assert(down_0 === 1'b1);
            assert(down_1 === 1'b1);
            assert(n_oe_d_0 === 1'b0);
            assert(n_oe_d_1 === 1'b1);
            assert(n_oe_ia_0 === a[12]);
            assert(n_oe_ia_1 === ~a[12]);
            assert(n_ce_bank === 1'b1);

            n_oe = 1'b1;
            n_we = 1'b0;
            #1
            assert(n_load_0 === 1'b0);
            assert(n_load_1 === 1'b1);
            assert(up_0 === 1'b1);
            assert(up_1 === 1'b1);
            assert(down_0 === 1'b1);
            assert(down_1 === 1'b1);
            assert(n_oe_d_0 === 1'b1);
            assert(n_oe_d_1 === 1'b1);
            assert(n_oe_ia_0 === a[12]);
            assert(n_oe_ia_1 === ~a[12]);
            assert(n_ce_bank === 1'b1);

            a = 16'hFC01;
            n_we = 1'b1;
            n_oe = 1'b1;
            #1
            assert(n_load_0 === 1'b1);
            assert(n_load_1 === 1'b1);
            assert(up_0 === 1'b1);
            assert(up_1 === 1'b1);
            assert(down_0 === 1'b1);
            assert(down_1 === 1'b1);
            assert(n_oe_d_0 === 1'b1);
            assert(n_oe_d_1 === 1'b1);
            assert(n_oe_ia_0 === a[12]);
            assert(n_oe_ia_1 === ~a[12]);
            assert(n_ce_bank === 1'b1);

            n_oe = 1'b0;
            #1
            assert(n_load_0 === 1'b1);
            assert(n_load_1 === 1'b1);
            assert(up_0 === 1'b1);
            assert(up_1 === 1'b1);
            assert(down_0 === 1'b1);
            assert(down_1 === 1'b1);
            assert(n_oe_d_0 === 1'b1);
            assert(n_oe_d_1 === 1'b0);
            assert(n_oe_ia_0 === a[12]);
            assert(n_oe_ia_1 === ~a[12]);
            assert(n_ce_bank === 1'b1);

            n_oe = 1'b1;
            n_we = 1'b0;
            #1
            assert(n_load_0 === 1'b1);
            assert(n_load_1 === 1'b0);
            assert(up_0 === 1'b1);
            assert(up_1 === 1'b1);
            assert(down_0 === 1'b1);
            assert(down_1 === 1'b1);
            assert(n_oe_d_0 === 1'b1);
            assert(n_oe_d_1 === 1'b1);
            assert(n_oe_ia_0 === a[12]);
            assert(n_oe_ia_1 === ~a[12]);
            assert(n_ce_bank === 1'b1);

            // increment/decrement
            for (j = 0; j != 4; j = j + 1) begin
                a = 16'hFC02;
                n_we = 1'b1;
                n_oe = 1'b1;
                d = j[7:0];
                #1
                assert(n_load_0 === 1'b1);
                assert(n_load_1 === 1'b1);
                assert(up_0 === 1'b1);
                assert(up_1 === 1'b1);
                assert(down_0 === 1'b1);
                assert(down_1 === 1'b1);
                assert(n_oe_d_0 === 1'b1);
                assert(n_oe_d_1 === 1'b1);
                assert(n_oe_ia_0 === a[12]);
                assert(n_oe_ia_1 === ~a[12]);
                assert(n_ce_bank === 1'b1);

                n_we = 1'b0;
                #1
                assert(n_load_0 === 1'b1);
                assert(n_load_1 === 1'b1);
                assert(up_0 === j[0]);
                assert(up_1 === j[1]);
                assert(down_0 === j[2]);
                assert(down_1 === j[3]);
                assert(n_oe_d_0 === 1'b1);
                assert(n_oe_d_1 === 1'b1);
                assert(n_oe_ia_0 === a[12]);
                assert(n_oe_ia_1 === ~a[12]);
                assert(n_ce_bank === 1'b1);

                n_we = 1'b1;
                #1;
            end

            // enable
            n_oe = 1'b1;
            n_we = 1'b0;
            a = 16'hFC03;
            d = 8'h01;
            #1
            assert(n_load_0 === 1'b1);
            assert(n_load_1 === 1'b1);
            assert(up_0 === 1'b1);
            assert(up_1 === 1'b1);
            assert(down_0 === 1'b1);
            assert(down_1 === 1'b1);
            assert(n_oe_d_0 === 1'b1);
            assert(n_oe_d_1 === 1'b1);
            assert(n_oe_ia_0 === a[12]);
            assert(n_oe_ia_1 === ~a[12]);
            assert(n_ce_bank === 1'b1);

            n_we = 1'b1;
            #1
            assert(n_load_0 === 1'b1);
            assert(n_load_1 === 1'b1);
            assert(up_0 === 1'b1);
            assert(up_1 === 1'b1);
            assert(down_0 === 1'b1);
            assert(down_1 === 1'b1);
            assert(n_oe_d_0 === 1'b1);
            assert(n_oe_d_1 === 1'b1);
            assert(n_oe_ia_0 === a[12]);
            assert(n_oe_ia_1 === ~a[12]);
            assert(n_ce_bank === 1'b1);
        end

        // enabled: check bank ce
        a = 16'hC000;
        n_oe = 1'b1;
        n_we = 1'b1;
        #1
        assert(n_load_0 === 1'b1);
        assert(n_load_1 === 1'b1);
        assert(up_0 === 1'b1);
        assert(up_1 === 1'b1);
        assert(down_0 === 1'b1);
        assert(down_1 === 1'b1);
        assert(n_oe_d_0 === 1'b1);
        assert(n_oe_d_1 === 1'b1);
        assert(n_oe_ia_0 === a[12]);
        assert(n_oe_ia_1 === ~a[12]);
        assert(n_ce_bank === 1'b0);
    end
endmodule
