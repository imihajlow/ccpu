`timescale 1us/1ns
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
    wire p_selector;
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

    task check_short_circuit;
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
    reg n_mem_rdy;

    control_unit inst(
            .n_oe_mem(n_oe_mem),
            .n_we_mem(n_we_mem),
            .n_oe_d_di(n_oe_d_di),
            .we_ir(we_ir),
            .inc_ip(inc_ip),
            .addr_dp(addr_dp),
            .p_selector(p_selector),
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
            .flags(flags),
            .n_mem_rdy(n_mem_rdy));

    integer j, k, attempt;

    initial begin
        $dumpfile("test_control_unit.vcd");
        $dumpvars;

        clk = 1'b0;
        n_rst = 1'b0;
        flags = 4'b0000;
        n_mem_rdy = 1'b0;

        ir = 8'b00000000;

        #1
        check_short_circuit();

        #1 n_rst = 1'b1;
        #1
        check_short_circuit();

        for (k = 0; k < 4; k = k + 1) begin
            // ALU0
            // test all ALU ops
            for (j = 0; j < 16; j = j + 1) begin
                for (attempt = 0; attempt < 2; attempt = attempt + 1) begin
                    // first cycle
                    #1 clk = 1'b0;
                    // ALU A, src, i
                    ir = {1'b0, j[3:0], 1'b0, k[1:0]};
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b1);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b1);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == ~(k == 3));
                    assert(n_oe_pl_alu == ~(k == 2));
                    assert(n_oe_b_alu == ~(k == 1));
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == (j == 8));
                    assert(n_oe_alu_di == 1'b0);
                    check_short_circuit();

                    #1 clk = 1'b0;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b1);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == ~(k == 3));
                    assert(n_oe_pl_alu == ~(k == 2));
                    assert(n_oe_b_alu == ~(k == 1));
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == (j == 8));
                    assert(n_oe_alu_di == 1'b0);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b1);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();
                end
            end

            // ALU1
            // test all ALU ops
            for (j = 0; j < 16; j = j + 1) begin
                for (attempt = 0; attempt < 2; attempt = attempt + 1) begin
                    // first cycle
                    #1 clk = 1'b0;
                    // ALU A, src, i
                    ir = {1'b0, j[3:0], 1'b1, k[1:0]};
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b1);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == ~(k == 3));
                    assert(n_we_pl == ~(k == 2));
                    assert(we_a == (k == 0));
                    assert(we_b == (k == 1));
                    assert(n_oe_ph_alu == ~(k == 3));
                    assert(n_oe_pl_alu == ~(k == 2));
                    assert(n_oe_b_alu == ~(k == 1));
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == (j == 8));
                    assert(n_oe_alu_di == 1'b0);
                    check_short_circuit();

                    #1 clk = 1'b0;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == ~(k == 3));
                    assert(n_we_pl == ~(k == 2));
                    assert(we_a == (k == 0));
                    assert(we_b == (k == 1));
                    assert(n_oe_ph_alu == ~(k == 3));
                    assert(n_oe_pl_alu == ~(k == 2));
                    assert(n_oe_b_alu == ~(k == 1));
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == (j == 8));
                    assert(n_oe_alu_di == 1'b0);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b1);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();
                end
            end
        end

        #1
        // LD
        for (k = 0; k < 4; k = k + 1) begin
            for (attempt = 0; attempt < 2; attempt = attempt + 1) begin
                // first cycle
                #1 clk = 1'b0;
                // ALU A, src, i
                ir = {4'b1000, 2'b00, k[1:0]};
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b0);
                assert(addr_dp == 1'b0);
                assert(p_selector == 1'b0);
                assert(n_we_ph == 1'b1);
                assert(n_we_pl == 1'b1);
                assert(we_a == 1'b0);
                assert(we_b == 1'b0);
                assert(n_oe_ph_alu == 1'b1);
                assert(n_oe_pl_alu == 1'b1);
                assert(n_oe_b_alu == 1'b1);
                assert(n_oe_a_d == 1'b1);
                assert(n_oe_b_d == 1'b1);
                assert(n_we_flags == 1'b1);
                assert(n_oe_alu_di == 1'b1);
                check_short_circuit();

                #1 clk = 1'b1;
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b0);
                assert(we_ir == 1'b0);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b1);
                assert(p_selector == 1'b0);
                assert(n_we_ph == ~(k == 3));
                assert(n_we_pl == ~(k == 2));
                assert(we_a == (k == 0));
                assert(we_b == (k == 1));
                assert(n_oe_ph_alu == 1'b1);
                assert(n_oe_pl_alu == 1'b1);
                assert(n_oe_b_alu == 1'b1);
                assert(n_oe_a_d == 1'b1);
                assert(n_oe_b_d == 1'b1);
                assert(n_we_flags == 1'b1);
                assert(n_oe_alu_di == 1'b1);
                check_short_circuit();

                #1 clk = 1'b0;
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b0);
                assert(we_ir == 1'b0);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b1);
                assert(p_selector == 1'b0);
                assert(n_we_ph == ~(k == 3));
                assert(n_we_pl == ~(k == 2));
                assert(we_a == (k == 0));
                assert(we_b == (k == 1));
                assert(n_oe_ph_alu == 1'b1);
                assert(n_oe_pl_alu == 1'b1);
                assert(n_oe_b_alu == 1'b1);
                assert(n_oe_a_d == 1'b1);
                assert(n_oe_b_d == 1'b1);
                assert(n_we_flags == 1'b1);
                assert(n_oe_alu_di == 1'b1);
                check_short_circuit();

                #1 clk = 1'b1;
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b0);
                assert(addr_dp == 1'b0);
                assert(p_selector == 1'b0);
                assert(n_we_ph == 1'b1);
                assert(n_we_pl == 1'b1);
                assert(we_a == 1'b0);
                assert(we_b == 1'b0);
                assert(n_oe_ph_alu == 1'b1);
                assert(n_oe_pl_alu == 1'b1);
                assert(n_oe_b_alu == 1'b1);
                assert(n_oe_a_d == 1'b1);
                assert(n_oe_b_d == 1'b1);
                assert(n_we_flags == 1'b1);
                assert(n_oe_alu_di == 1'b1);
                check_short_circuit();
            end
        end

        #1
        // ST
        for (k = 0; k < 2; k = k + 1) begin
            for (attempt = 0; attempt < 2; attempt = attempt + 1) begin
                // first cycle
                #1 clk = 1'b0;
                // ALU A, src, i
                ir = {4'b1001, 3'b000, k[0]};
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b0);
                assert(addr_dp == 1'b0);
                assert(p_selector == 1'b0);
                assert(n_we_ph == 1'b1);
                assert(n_we_pl == 1'b1);
                assert(we_a == 1'b0);
                assert(we_b == 1'b0);
                assert(n_oe_ph_alu == 1'b1);
                assert(n_oe_pl_alu == 1'b1);
                assert(n_oe_b_alu == 1'b1);
                assert(n_oe_a_d == 1'b1);
                assert(n_oe_b_d == 1'b1);
                assert(n_we_flags == 1'b1);
                assert(n_oe_alu_di == 1'b1);
                check_short_circuit();

                #1 clk = 1'b1;
                #1
                assert(n_oe_mem == 1'b1);
                assert(n_we_mem == 1'b0);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b0);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b1);
                assert(p_selector == 1'b0);
                assert(n_we_ph == 1'b1);
                assert(n_we_pl == 1'b1);
                assert(we_a == 1'b0);
                assert(we_b == 1'b0);
                assert(n_oe_ph_alu == 1'b1);
                assert(n_oe_pl_alu == 1'b1);
                assert(n_oe_b_alu == 1'b1);
                assert(n_oe_a_d == ~(k == 0));
                assert(n_oe_b_d == ~(k == 1));
                assert(n_we_flags == 1'b1);
                assert(n_oe_alu_di == 1'b1);
                check_short_circuit();

                #1 clk = 1'b0;
                #1
                assert(n_oe_mem == 1'b1);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b0);
                assert(inc_ip == 1'b1);
                assert(addr_dp == 1'b1);
                assert(p_selector == 1'b0);
                assert(n_we_ph == 1'b1);
                assert(n_we_pl == 1'b1);
                assert(we_a == 1'b0);
                assert(we_b == 1'b0);
                assert(n_oe_ph_alu == 1'b1);
                assert(n_oe_pl_alu == 1'b1);
                assert(n_oe_b_alu == 1'b1);
                assert(n_oe_a_d == ~(k == 0));
                assert(n_oe_b_d == ~(k == 1));
                assert(n_we_flags == 1'b1);
                assert(n_oe_alu_di == 1'b1);
                check_short_circuit();

                #1 clk = 1'b1;
                #1
                assert(n_oe_mem == 1'b0);
                assert(n_we_mem == 1'b1);
                assert(n_oe_d_di == 1'b1);
                assert(we_ir == 1'b1);
                assert(inc_ip == 1'b0);
                assert(addr_dp == 1'b0);
                assert(p_selector == 1'b0);
                assert(n_we_ph == 1'b1);
                assert(n_we_pl == 1'b1);
                assert(we_a == 1'b0);
                assert(we_b == 1'b0);
                assert(n_oe_ph_alu == 1'b1);
                assert(n_oe_pl_alu == 1'b1);
                assert(n_oe_b_alu == 1'b1);
                assert(n_oe_a_d == 1'b1);
                assert(n_oe_b_d == 1'b1);
                assert(n_we_flags == 1'b1);
                assert(n_oe_alu_di == 1'b1);
                check_short_circuit();
            end
        end

        #1
        // JMP
        for (attempt = 0; attempt < 2; attempt = attempt + 1) begin
            // first cycle
            #1 clk = 1'b0;
            // JMP
            ir = 8'b11001000;
            #1
            assert(n_oe_mem == 1'b0);
            assert(n_we_mem == 1'b1);
            assert(n_oe_d_di == 1'b1);
            assert(we_ir == 1'b1);
            assert(inc_ip == 1'b0);
            assert(addr_dp == 1'b0);
            assert(p_selector == attempt[0]);
            assert(n_we_ph == 1'b1);
            assert(n_we_pl == 1'b1);
            assert(we_a == 1'b0);
            assert(we_b == 1'b0);
            assert(n_oe_ph_alu == 1'b1);
            assert(n_oe_pl_alu == 1'b1);
            assert(n_oe_b_alu == 1'b1);
            assert(n_oe_a_d == 1'b1);
            assert(n_oe_b_d == 1'b1);
            assert(n_we_flags == 1'b1);
            assert(n_oe_alu_di == 1'b1);
            check_short_circuit();

            #1 clk = 1'b1;
            #1
            assert(n_oe_mem == 1'b0);
            assert(n_we_mem == 1'b1);
            assert(n_oe_d_di == 1'b1);
            assert(we_ir == 1'b0);
            assert(inc_ip == 1'b1);
            assert(addr_dp == 1'b0);
            assert(p_selector == attempt[0]);
            assert(n_we_ph == 1'b1);
            assert(n_we_pl == 1'b1);
            assert(we_a == 1'b0);
            assert(we_b == 1'b0);
            assert(n_oe_ph_alu == 1'b1);
            assert(n_oe_pl_alu == 1'b1);
            assert(n_oe_b_alu == 1'b1);
            assert(n_oe_a_d == 1'b1);
            assert(n_oe_b_d == 1'b1);
            assert(n_we_flags == 1'b1);
            assert(n_oe_alu_di == 1'b1);
            check_short_circuit();

            #1 clk = 1'b0;
            #1
            assert(n_oe_mem == 1'b0);
            assert(n_we_mem == 1'b1);
            assert(n_oe_d_di == 1'b1);
            assert(we_ir == 1'b0);
            assert(inc_ip == 1'b1);
            assert(addr_dp == 1'b0);
            assert(p_selector == ~attempt[0]);
            assert(n_we_ph == 1'b1);
            assert(n_we_pl == 1'b1);
            assert(we_a == 1'b0);
            assert(we_b == 1'b0);
            assert(n_oe_ph_alu == 1'b1);
            assert(n_oe_pl_alu == 1'b1);
            assert(n_oe_b_alu == 1'b1);
            assert(n_oe_a_d == 1'b1);
            assert(n_oe_b_d == 1'b1);
            assert(n_we_flags == 1'b1);
            assert(n_oe_alu_di == 1'b1);
            check_short_circuit();

            #1 clk = 1'b1;
            #1
            assert(n_oe_mem == 1'b0);
            assert(n_we_mem == 1'b1);
            assert(n_oe_d_di == 1'b1);
            assert(we_ir == 1'b1);
            assert(inc_ip == 1'b0);
            assert(addr_dp == 1'b0);
            assert(p_selector == ~attempt[0]);
            assert(n_we_ph == 1'b1);
            assert(n_we_pl == 1'b1);
            assert(we_a == 1'b0);
            assert(we_b == 1'b0);
            assert(n_oe_ph_alu == 1'b1);
            assert(n_oe_pl_alu == 1'b1);
            assert(n_oe_b_alu == 1'b1);
            assert(n_oe_a_d == 1'b1);
            assert(n_oe_b_d == 1'b1);
            assert(n_we_flags == 1'b1);
            assert(n_oe_alu_di == 1'b1);
            check_short_circuit();
        end

        // JC
        for (j = 0; j < 16; j = j + 1) begin
            flags = j[3:0];
            for (k = 0; k < 4; k = k + 1) begin
                for (attempt = 0; attempt < 2; attempt = attempt + 1) begin
                    // first cycle
                    #1 clk = 1'b0;
                    ir = {5'b11000, ~flags[k], k[1:0]}; // condition should be met
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b1);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == attempt[0]);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == attempt[0]);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b0;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == ~attempt[0]);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b1);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == ~attempt[0]);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();
                end
                for (attempt = 0; attempt < 2; attempt = attempt + 1) begin
                    // first cycle
                    #1 clk = 1'b0;
                    ir = {5'b11000, flags[k], k[1:0]}; // condition should not be met
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b1);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b0;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b1);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();
                end
            end
        end

        // LDI
        for (j = 0; j < 4; j = j + 1) begin
            for (attempt = 0; attempt < 2; attempt = attempt + 1) begin
                    #1 clk = 1'b0;
                    ir = {6'b101000, j[1:0]};
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b1);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b0;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b0);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == (j != 3));
                    assert(n_we_pl == (j != 2));
                    assert(we_a == (j == 0));
                    assert(we_b == (j == 1));
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    // ---

                    #1 clk = 1'b0;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b0);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == (j != 3));
                    assert(n_we_pl == (j != 2));
                    assert(we_a == (j == 0));
                    assert(we_b == (j == 1));
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b0;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b0);
                    assert(inc_ip == 1'b1);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();

                    #1 clk = 1'b1;
                    #1
                    assert(n_oe_mem == 1'b0);
                    assert(n_we_mem == 1'b1);
                    assert(n_oe_d_di == 1'b1);
                    assert(we_ir == 1'b1);
                    assert(inc_ip == 1'b0);
                    assert(addr_dp == 1'b0);
                    assert(p_selector == 1'b0);
                    assert(n_we_ph == 1'b1);
                    assert(n_we_pl == 1'b1);
                    assert(we_a == 1'b0);
                    assert(we_b == 1'b0);
                    assert(n_oe_ph_alu == 1'b1);
                    assert(n_oe_pl_alu == 1'b1);
                    assert(n_oe_b_alu == 1'b1);
                    assert(n_oe_a_d == 1'b1);
                    assert(n_oe_b_d == 1'b1);
                    assert(n_we_flags == 1'b1);
                    assert(n_oe_alu_di == 1'b1);
                    check_short_circuit();
            end
        end
        // check all possible values of IR
        for (j = 0; j < 256; j = j + 1) begin
            for (attempt = 0; attempt < 8; attempt = attempt + 1) begin
                ir = j[7:0];
                clk = 1'b0;
                #1
                check_short_circuit();
                clk = 1'b1;
                #1
                check_short_circuit();
            end
        end
    end
endmodule
