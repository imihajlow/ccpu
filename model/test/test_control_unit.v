module test_control_unit();
    task assert;
        input v;
        if (!v)
            $fatal;
    endtask

    wire mem_oe;
    wire mem_we;
    wire d_to_di_oe;
    wire ir_we;
    wire ip_inc;
    wire addr_dp;
    wire swap_p;
    wire we_pl;
    wire we_ph;
    wire we_a;
    wire we_b;
    wire oe_pl_alu;
    wire oe_ph_alu;
    wire oe_b_alu;
    wire oe_a_d;
    wire oe_b_d;
    wire we_flags;
    wire [2:0] alu_op;
    wire alu_oe;

    task assert_short_circuit;
    begin
        if (3'b0 + oe_pl_alu + oe_ph_alu + oe_b_alu < 2) begin
            $display("ALU B input short circuit");
            $fatal;
        end
        if (3'b0 + oe_a_d + oe_b_d + mem_oe < 2) begin
            $display("D short circuit");
            $fatal;
        end
        if (~alu_oe & ~d_to_di_oe) begin
            $display("DI short circuit");
            $fatal;
        end
    end
    endtask

    reg clk = 1'b0;
    reg rst = 1'b1;
    reg [7:0] ir;
    reg [3:0] flags;

    control_unit inst(
            .mem_oe(mem_oe),
            .mem_we(mem_we),
            .d_to_di_oe(d_to_di_oe),
            .ir_we(ir_we),
            .ip_inc(ip_inc),
            .addr_dp(addr_dp),
            .swap_p(swap_p),
            .we_pl(we_pl),
            .we_ph(we_ph),
            .we_a(we_a),
            .we_b(we_b),
            .oe_pl_alu(oe_pl_alu),
            .oe_ph_alu(oe_ph_alu),
            .oe_b_alu(oe_b_alu),
            .oe_a_d(oe_a_d),
            .oe_b_d(oe_b_d),
            .we_flags(we_flags),
            .alu_op(alu_op),
            .alu_oe(alu_oe),
            .clk(clk),
            .rst(rst),
            .ir(ir),
            .flags(flags));

    integer i;

    initial begin
        $dumpfile("test_control_unit.vcd");
        $dumpvars;

        clk = 1'b0;
        rst = 1'b0;
        flags = 4'bxxxx;

        ir = 8'bxxxxxxxx;

        #1
        assert_short_circuit();

        #1 rst = 1'b1;
        #1
        assert_short_circuit();

        // test all ALU ops
        for (i = 0; i < 8; i = i + 1) begin
            // first cycle
            #1 clk = 1'b1;
            // ALU B, PL, i
            ir = {1'b0, i[2:0], 2'b10, 2'b01};
            #1
            assert(mem_oe == 1'b0);
            assert(mem_we == 1'b1);
            assert(d_to_di_oe == 1'b1);
            assert(ir_we == 1'b0);
            assert(ip_inc == 1'b1);
            assert(addr_dp == 1'b0);
            assert(swap_p == 1'b0);
            assert(we_ph == 1'b1);
            assert(we_pl == 1'b1);
            assert(we_a == 1'b1);
            assert(we_b == 1'b0);
            assert(oe_pl_alu == 1'b0);
            assert(oe_ph_alu == 1'b1);
            assert(oe_b_alu == 1'b1);
            assert(oe_a_d == 1'b1);
            assert(oe_b_d == 1'b1);
            assert(we_flags == 1'b0);
            assert(alu_op == i);
            assert(alu_oe == 1'b0);
            assert_short_circuit();

            #1 clk = 1'b0;
            #1
            assert(mem_oe == 1'b0);
            assert(mem_we == 1'b1);
            assert(d_to_di_oe == 1'b1);
            assert(ir_we == 1'b0);
            assert(ip_inc == 1'b1);
            assert(addr_dp == 1'b0);
            // assert(swap_p == 1'b0);
            // assert(we_ph == 1'b1);
            // assert(we_pl == 1'b1);
            // assert(we_a == 1'b1);
            // assert(we_b == 1'b0);
            // assert(oe_pl_alu == 1'b1);
            // assert(oe_ph_alu == 1'b1);
            // assert(oe_b_alu == 1'b0);
            // assert(oe_a_d == 1'b1);
            // assert(oe_b_d == 1'b1);
            // assert(we_flags == 1'b0);
            // assert(alu_op == 3'b101);
            // assert(alu_oe == 1'b0);
            assert_short_circuit();

            // second cycle: everything should stay the same
            #1 clk = 1'b1;
            #1
            assert(mem_oe == 1'b0);
            assert(mem_we == 1'b1);
            assert(d_to_di_oe == 1'b1);
            assert(ir_we == 1'b0);
            assert(ip_inc == 1'b1);
            assert(addr_dp == 1'b0);
            assert(swap_p == 1'b0);
            assert(we_ph == 1'b1);
            assert(we_pl == 1'b1);
            assert(we_a == 1'b1);
            assert(we_b == 1'b0);
            assert(oe_pl_alu == 1'b0);
            assert(oe_ph_alu == 1'b1);
            assert(oe_b_alu == 1'b1);
            assert(oe_a_d == 1'b1);
            assert(oe_b_d == 1'b1);
            assert(we_flags == 1'b0);
            assert(alu_op == i);
            assert(alu_oe == 1'b0);
            assert_short_circuit();

            #1 clk = 1'b0;
            #1
            assert(mem_oe == 1'b0);
            assert(mem_we == 1'b1);
            assert(d_to_di_oe == 1'b1);
            assert(ir_we == 1'b0);
            assert(ip_inc == 1'b1);
            assert(addr_dp == 1'b0);
            // assert(swap_p == 1'b0);
            // assert(we_ph == 1'b1);
            // assert(we_pl == 1'b1);
            // assert(we_a == 1'b1);
            // assert(we_b == 1'b0);
            // assert(oe_pl_alu == 1'b1);
            // assert(oe_ph_alu == 1'b1);
            // assert(oe_b_alu == 1'b0);
            // assert(oe_a_d == 1'b1);
            // assert(oe_b_d == 1'b1);
            // assert(we_flags == 1'b0);
            // assert(alu_op == 3'b101);
            // assert(alu_oe == 1'b0);
            assert_short_circuit();
        end

        // JMP
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b11001xxx;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b0);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b0);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();


        // Jc - condition true
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b11000001;
        flags = 4'b0110;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b0);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b0);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // Jc - condition true - inversed
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b11000101;
        flags = 4'b0001;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b0);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b1);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b0);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // Jc - condition false
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b11000000;
        flags = 4'b0000;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b0);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b0);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // Jc - condition false - inversed
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b11000100;
        flags = 4'b0001;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b0);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        // assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b0);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // LD pl
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b1000xx10;
        flags = 4'bxxxx;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        assert(d_to_di_oe == 1'b0);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b1);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b0);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(we_ph == 1'b1);
        // assert(we_pl == 1'b1);
        // assert(we_a == 1'b1);
        // assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        assert(d_to_di_oe == 1'b0);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b1);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b0);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(we_ph == 1'b1);
        // assert(we_pl == 1'b1);
        // assert(we_a == 1'b1);
        // assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // ST b
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b1001xxx1;
        flags = 4'bxxxx;
        #1
        assert(mem_oe == 1'b1);
        assert(mem_we == 1'b0);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b1);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b0);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(we_ph == 1'b1);
        // assert(we_pl == 1'b1);
        // assert(we_a == 1'b1);
        // assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // second cycle - everything the same
        #1 clk = 1'b1;
        #1
        assert(mem_oe == 1'b1);
        assert(mem_we == 1'b0);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b1);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b0);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(we_ph == 1'b1);
        // assert(we_pl == 1'b1);
        // assert(we_a == 1'b1);
        // assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        assert(oe_a_d == 1'b1);
        assert(oe_b_d == 1'b1);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // LDI a
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b1010xx00;
        flags = 4'bxxxx;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        // assert(oe_a_d == 1'b1);
        // assert(oe_b_d == 1'b0);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b1);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(we_ph == 1'b1);
        // assert(we_pl == 1'b1);
        // assert(we_a == 1'b1);
        // assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        // assert(oe_a_d == 1'b1);
        // assert(oe_b_d == 1'b1);
        // assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // second cycle
        #1
        clk = 1'b1;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        assert(d_to_di_oe == 1'b0);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b0);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        // assert(oe_a_d == 1'b1);
        // assert(oe_b_d == 1'b0);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(we_ph == 1'b1);
        // assert(we_pl == 1'b1);
        // assert(we_a == 1'b1);
        // assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        // assert(oe_a_d == 1'b1);
        // assert(oe_b_d == 1'b1);
        // assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // once again LDI ph
        // first cycle
        #1
        clk = 1'b1;
        ir = 8'b1010xx11;
        flags = 4'bxxxx;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b1);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        // assert(oe_a_d == 1'b1);
        // assert(oe_b_d == 1'b0);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b1);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(we_ph == 1'b1);
        // assert(we_pl == 1'b1);
        // assert(we_a == 1'b1);
        // assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        // assert(oe_a_d == 1'b1);
        // assert(oe_b_d == 1'b1);
        // assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();

        // second cycle
        #1
        clk = 1'b1;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        assert(d_to_di_oe == 1'b0);
        // assert(ir_we == 1'b0);
        assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        assert(swap_p == 1'b0);
        assert(we_ph == 1'b0);
        assert(we_pl == 1'b1);
        assert(we_a == 1'b1);
        assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        // assert(oe_a_d == 1'b1);
        // assert(oe_b_d == 1'b0);
        assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b1);
        assert_short_circuit();

        #1 clk = 1'b0;
        #1
        assert(mem_oe == 1'b0);
        assert(mem_we == 1'b1);
        // assert(d_to_di_oe == 1'b1);
        assert(ir_we == 1'b0);
        // assert(ip_inc == 1'b1);
        assert(addr_dp == 1'b0);
        // assert(swap_p == 1'b0);
        // assert(we_ph == 1'b1);
        // assert(we_pl == 1'b1);
        // assert(we_a == 1'b1);
        // assert(we_b == 1'b1);
        // assert(oe_pl_alu == 1'b1);
        // assert(oe_ph_alu == 1'b1);
        // assert(oe_b_alu == 1'b1);
        // assert(oe_a_d == 1'b1);
        // assert(oe_b_d == 1'b1);
        // assert(we_flags == 1'b1);
        // assert(alu_op == 3'b101);
        // assert(alu_oe == 1'b0);
        assert_short_circuit();
    end
endmodule
