module test_control_unit();
    task assert;
        input v;
        if (v !== 1'b1)
            $fatal;
    endtask

    wire n_oe_mem;
    wire n_we_mem;
    wire n_oe_d_di;
    wire we_ir;
    wire inc_ip;
    wire addr_dp;
    wire swap_p;
    wire n_we_pl;
    wire n_we_ph;
    wire we_a;
    wire we_b;
    wire n_oe_pl_alu;
    wire n_oe_ph_alu;
    wire n_oe_b_alu;
    wire n_oe_a_d;
    wire n_oe_b_d;
    wire n_we_flags;
    wire n_oe_alu_di;

    task assert_short_circuit;
    begin
        if (3'b0 + n_oe_pl_alu + n_oe_ph_alu + n_oe_b_alu < 2) begin
            $display("ALU B input short circuit");
            $fatal;
        end
        if (3'b0 + n_oe_a_d + n_oe_b_d + n_oe_mem < 2) begin
            $display("D short circuit");
            $fatal;
        end
        if (~n_oe_alu_di & ~n_oe_d_di) begin
            $display("DI short circuit");
            $fatal;
        end
    end
    endtask

    reg clk = 1'b0;
    reg n_rst = 1'b1;
    reg [7:0] ir;
    reg [3:0] flags;

    control_unit inst(
            .n_oe_mem(n_oe_mem),
            .n_we_mem(n_we_mem),
            .n_oe_d_di(n_oe_d_di),
            .we_ir(we_ir),
            .inc_ip(inc_ip),
            .addr_dp(addr_dp),
            .swap_p(swap_p),
            .n_we_pl(n_we_pl),
            .n_we_ph(n_we_ph),
            .we_a(we_a),
            .we_b(we_b),
            .n_oe_pl_alu(n_oe_pl_alu),
            .n_oe_ph_alu(n_oe_ph_alu),
            .n_oe_b_alu(n_oe_b_alu),
            .n_oe_a_d(n_oe_a_d),
            .n_oe_b_d(n_oe_b_d),
            .n_we_flags(n_we_flags),
            .n_oe_alu_di(n_oe_alu_di),
            .clk(clk),
            .n_rst(n_rst),
            .ir(ir),
            .flags(flags));

    integer i_op, i_src;

    initial begin
        $dumpfile("test_control_unit.vcd");
        $dumpvars;

        clk = 1'b0;
        n_rst = 1'b0;
        flags = 4'bxxxx;

        ir = 8'bxxxxxxxx;

        #1
        assert_short_circuit();

        #1 n_rst = 1'b1;
        #1
        assert_short_circuit();

        for (i_src = 0; i_src < 4; i_src = i_src + 1) begin
            // ALU0
            // test all ALU ops
            for (i_op = 0; i_op < 16; i_op = i_op + 1) begin
                // first cycle
                #1 clk = 1'b1;
                // ALU A, src, i
                ir = {1'b0, i_op[3:0], 1'b0, i_src[1:0]};
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b0);
                assert(swap_p == 1'b0);
                assert(n_we_ph == 1'b1);
                assert(n_we_pl == 1'b1);
                assert(we_a == 1'b1);
                assert(we_b == 1'b0);
                assert(n_oe_ph_alu == ~(i_src == 3));
                assert(n_oe_pl_alu == ~(i_src == 2));
                assert(n_oe_b_alu == ~(i_src == 1));
                assert(n_oe_a_d == 1'b1);
                assert(n_oe_b_d == 1'b1);
                assert(n_we_flags == 1'b0);
                assert(n_oe_alu_di == 1'b0);
                assert_short_circuit();

                #1 clk = 1'b0;
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b0);
                // assert(swap_p == 1'b0);
                // assert(n_we_ph == 1'b1);
                // assert(n_we_pl == 1'b1);
                // assert(we_a == 1'b0);
                // assert(we_b == 1'b1);
                // assert(n_oe_pl_alu == 1'b1);
                // assert(n_oe_ph_alu == 1'b1);
                // assert(n_oe_b_alu == 1'b0);
                // assert(n_oe_a_d == 1'b1);
                // assert(n_oe_b_d == 1'b1);
                // assert(n_we_flags == 1'b0);
                // assert(n_oe_alu_di == 1'b0);
                assert_short_circuit();

                // second cycle: everything should stay the same
                #1 clk = 1'b1;
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b0);
                assert(swap_p == 1'b0);
                assert(n_we_ph == 1'b1);
                assert(n_we_pl == 1'b1);
                assert(we_a == 1'b1);
                assert(we_b == 1'b0);
                assert(n_oe_ph_alu == ~(i_src == 3));
                assert(n_oe_pl_alu == ~(i_src == 2));
                assert(n_oe_b_alu == ~(i_src == 1));
                assert(n_oe_a_d == 1'b1);
                assert(n_oe_b_d == 1'b1);
                assert(n_we_flags == 1'b0);
                assert(n_oe_alu_di == 1'b0);
                assert_short_circuit();

                #1 clk = 1'b0;
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b0);
                // assert(swap_p == 1'b0);
                // assert(n_we_ph == 1'b1);
                // assert(n_we_pl == 1'b1);
                // assert(we_a == 1'b0);
                // assert(we_b == 1'b1);
                // assert(n_oe_pl_alu == 1'b1);
                // assert(n_oe_ph_alu == 1'b1);
                // assert(n_oe_b_alu == 1'b0);
                // assert(n_oe_a_d == 1'b1);
                // assert(n_oe_b_d == 1'b1);
                // assert(n_we_flags == 1'b0);
                // assert(n_oe_alu_di == 1'b0);
                assert_short_circuit();
            end

            // ALU1
            // test all ALU ops
            for (i_op = 0; i_op < 16; i_op = i_op + 1) begin
                // first cycle
                #1 clk = 1'b1;
                // ALU src, A, i
                ir = {1'b0, i_op[3:0], 1'b1, i_src[1:0]};
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b0);
                assert(swap_p == 1'b0);
                assert(n_we_ph == ~(i_src == 3));
                assert(n_we_pl == ~(i_src == 2));
                assert(we_b == (i_src == 1));
                assert(we_a == (i_src == 0));
                assert(n_oe_ph_alu == ~(i_src == 3));
                assert(n_oe_pl_alu == ~(i_src == 2));
                assert(n_oe_b_alu == ~(i_src == 1));
                assert(n_oe_a_d == 1'b1);
                assert(n_oe_b_d == 1'b1);
                assert(n_we_flags == 1'b0);
                assert(n_oe_alu_di == 1'b0);
                assert_short_circuit();

                #1 clk = 1'b0;
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b0);
                // assert(swap_p == 1'b0);
                // assert(n_we_ph == 1'b1);
                // assert(n_we_pl == 1'b1);
                // assert(we_a == 1'b0);
                // assert(we_b == 1'b1);
                // assert(n_oe_pl_alu == 1'b1);
                // assert(n_oe_ph_alu == 1'b1);
                // assert(n_oe_b_alu == 1'b0);
                // assert(n_oe_a_d == 1'b1);
                // assert(n_oe_b_d == 1'b1);
                // assert(n_we_flags == 1'b0);
                // assert(n_oe_alu_di == 1'b0);
                assert_short_circuit();

                // second cycle: everything should stay the same
                #1 clk = 1'b1;
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b0);
                assert(swap_p == 1'b0);
                assert(n_we_ph == ~(i_src == 3));
                assert(n_we_pl == ~(i_src == 2));
                assert(we_b == (i_src == 1));
                assert(we_a == (i_src == 0));
                assert(n_oe_ph_alu == ~(i_src == 3));
                assert(n_oe_pl_alu == ~(i_src == 2));
                assert(n_oe_b_alu == ~(i_src == 1));
                assert(n_oe_a_d == 1'b1);
                assert(n_oe_b_d == 1'b1);
                assert(n_we_flags == 1'b0);
                assert(n_oe_alu_di == 1'b0);
                assert_short_circuit();

                #1 clk = 1'b0;
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b0);
                // assert(swap_p == 1'b0);
                // assert(n_we_ph == 1'b1);
                // assert(n_we_pl == 1'b1);
                // assert(we_a == 1'b0);
                // assert(we_b == 1'b1);
                // assert(n_oe_pl_alu == 1'b1);
                // assert(n_oe_ph_alu == 1'b1);
                // assert(n_oe_b_alu == 1'b0);
                // assert(n_oe_a_d == 1'b1);
                // assert(n_oe_b_d == 1'b1);
                // assert(n_we_flags == 1'b0);
                // assert(n_oe_alu_di == 1'b0);
                assert_short_circuit();
            end
        end

        // JMP
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b11001xxx;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b0);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b0);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();


        // Jc - condition true
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b11000001;
        flags = 4'b0110;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b0);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b0);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // Jc - condition true - inversed
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b11000101;
        flags = 4'b0001;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b0);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b0);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // Jc - condition false
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b11000000;
        flags = 4'b0000;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b0);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b0);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // Jc - condition false - inversed
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b11000100;
        flags = 4'b0001;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b0);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b0);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // LD pl
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b1000xx10;
        flags = 4'bxxxx;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b0);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b1);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b0);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(n_we_ph == 1'b1);
        // assert(n_we_pl == 1'b1);
        // assert(we_a == 1'b0);
        // assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b0);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b1);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b0);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        // assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(n_we_ph == 1'b1);
        // assert(n_we_pl == 1'b1);
        // assert(we_a == 1'b0);
        // assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // ST b
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b1011xxx1;
        flags = 4'bxxxx;
        #1
        assert(n_oe_mem == 1'b1);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        assert(inc_ip == 1'b0);
        assert(addr_dp == 1'b1);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b1);
        assert(n_we_mem == 1'b0);
        assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b0);
        assert(inc_ip == 1'b0);
        assert(addr_dp == 1'b1);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b0);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // second cycle
        #1 clk = 1'b1;
        #1
        assert(n_oe_mem == 1'b1);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b0);
        assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b1);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b0);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        assert(n_oe_a_d == 1'b1);
        assert(n_oe_b_d == 1'b1);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // LDI a
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b1010xx00;
        flags = 4'bxxxx;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        // assert(n_oe_a_d == 1'b1);
        // assert(n_oe_b_d == 1'b0);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b0);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(n_we_ph == 1'b1);
        // assert(n_we_pl == 1'b1);
        // assert(we_a == 1'b0);
        // assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        // assert(n_oe_a_d == 1'b1);
        // assert(n_oe_b_d == 1'b1);
        // assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // second cycle
        #1
        clk = 1'b1;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b0);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        // assert(n_oe_a_d == 1'b1);
        // assert(n_oe_b_d == 1'b0);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b0);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        // assert(n_oe_a_d == 1'b1);
        // assert(n_oe_b_d == 1'b1);
        // assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // once again LDI ph
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b1010xx11;
        flags = 4'bxxxx;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b1);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b1);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        // assert(n_oe_a_d == 1'b1);
        // assert(n_oe_b_d == 1'b0);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b1);
        assert(we_ir == 1'b0);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(n_we_ph == 1'b1);
        // assert(n_we_pl == 1'b1);
        // assert(we_a == 1'b0);
        // assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        // assert(n_oe_a_d == 1'b1);
        // assert(n_oe_b_d == 1'b1);
        // assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();

        // second cycle
        #1
        clk = 1'b1;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b0);
        // assert(we_ir == 1'b1);
        assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b0);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        // assert(n_oe_a_d == 1'b1);
        // assert(n_oe_b_d == 1'b0);
        assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(n_oe_mem == 1'b0);
        assert(n_we_mem == 1'b1);
        assert(n_oe_d_di == 1'b0);
        assert(we_ir == 1'b1);
        // assert(inc_ip == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(n_we_ph == 1'b0);
        assert(n_we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b0);
        // assert(n_oe_pl_alu == 1'b1);
        // assert(n_oe_ph_alu == 1'b1);
        // assert(n_oe_b_alu == 1'b1);
        // assert(n_oe_a_d == 1'b1);
        // assert(n_oe_b_d == 1'b1);
        // assert(n_we_flags == 1'b1);
        // assert(n_oe_alu_di == 1'b0);
        assert_short_circuit();
    end
endmodule
