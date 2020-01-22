module control_unit(
//output
            n_oe_mem,
            n_we_mem,
            n_oe_d_di,
            we_ir,
            inc_ip,
            addr_dp,
            p_selector,
            n_we_pl,
            n_we_ph,
            we_a,
            we_b,
            n_oe_pl_alu,
            n_oe_ph_alu,
            n_oe_b_alu,
            n_oe_zero_alu,
            n_oe_a_d,
            n_oe_b_d,
            n_we_flags,
            n_oe_alu_di,
//input
            clk,
            n_rst,
            ir,
            flags,
            n_mem_rdy);
    input wire clk; // clock
    input wire n_rst; // reset
    input wire [7:0] ir; // current instruction
    input wire [3:0] flags; // stored ALU flags
    input wire n_mem_rdy; // for the future

    output wire n_oe_mem; // CPU output
    output wire n_we_mem; // CPU output

    output wire n_oe_d_di; // output the D bus into the DI bus, active low
    output wire we_ir; // latch D into IR on posedge clk, active high

    output wire inc_ip; // increment IP on negedge clk
    output wire addr_dp; // 0 - drive Address with IP, 1 - with DP
    output wire p_selector; // swap IP and DP

    output wire n_we_pl, n_we_ph; // latch registers from DI on negedge clk, active low
    output wire we_a, we_b; // latch registers from DI on negedge clk, active high
    output wire n_oe_pl_alu, n_oe_ph_alu, n_oe_b_alu, n_oe_zero_alu; // drive ALU B input with register values
    output wire n_oe_a_d, n_oe_b_d; // drive external D bus with a or b

    output wire n_we_flags; // latch flags on negedge clk
    output wire n_oe_alu_di; // ALU output to DI is enabled

    // Instructions:
    // LD d:         [DP] -> d
    // ST s:         s -> [DP]
    // ALU A, d, op:   A = ALU(A, d, op)
    // ALU d, A, op:   d = ALU(d, A, op)
    // LDI d:        IP++, [IP] -> d
    // Jc:           if c swap(IP, DP)
    // JMP:          swap(IP, DP)

    // ALU0:0oooo0dd
    // ALU1:0oooo1dd
    // LD:  1000__dd
    // ST:  1011___s
    // LDI: 1010__dd
    // Jc:  11000cff
    // JMP: 11001___

    // bits:
    // 7: other/ALU
    // 6: jump/other
    // 5: second cycle
    // 4: store or load
    wire ir_is_alu = ~ir[7];
    wire ir_is_jmp = ir[7] & ir[6];
    wire ir_is_2cy = ir[7] & ir[5];
    wire ir_is_sto = ir[7] & ir[4];

    wire ld = ir[7:4] == 4'b1000;
    wire st = ir[7:4] == 4'b1011;
    wire alu = ir[7] == 1'b0;
    wire ldi = ir[7:4] == 4'b1010;
    wire jc = ir[7:4] == 4'b1100;

    wire n_clk = ~clk;

    wire cycle;
    wire n_reset_cycle = ir_is_2cy;
    wire n_cycle;
    d_ff_7474 ff_cycle(
        .q(cycle),
        .n_q(n_cycle),
        .d(n_cycle),
        .cp(clk),
        .n_cd(n_rst & n_reset_cycle),
        .n_sd(1'b1));

    wire n_we_ir;
    d_ff_7474 ff_we_ir(
        .q(n_we_ir),
        .n_q(we_ir),
        .d(ir_is_2cy ^ n_we_ir),
        .cp(n_clk),
        .n_cd(n_rst),
        .n_sd(1'b1));

    wire swap_p; // swap IP and DP on negedge clk
    d_ff_7474 ff_p_selector(
        .q(p_selector),
        .d(swap_p ^ p_selector),
        .cp(n_clk),
        .n_cd(n_rst),
        .n_sd(1'b1));

    assign n_oe_mem = st & (~cycle | clk);
    assign n_we_mem = ~(st & ~cycle & n_clk);

    assign n_oe_d_di = ~((ldi & cycle) | ld);

    assign inc_ip = ~st | cycle;

    assign addr_dp = (ld & clk) | (st & (~cycle | clk));

    wire [1:0] dst = ir[1:0];
    wire [3:0] dst_decoded = 4'b1 << dst;
    wire src_d = ir[0];

    wire we_dst = ir_is_jmp | ir_is_sto | (ldi & ~cycle) | (ir_is_alu & ~ir[2]);
    wire oe_src_alu = ~ir_is_alu;
    wire oe_src_d = ~(st & n_we_ir);

    wire n_we_a_dst;
    wire we_a_alua = ~ir_is_alu | ir[2];
    wire n_we_b;
    assign {n_we_ph, n_we_pl, n_we_b, n_we_a_dst} = we_dst ? 4'b1111 : ~dst_decoded;
    assign we_b = ~n_we_b;
    assign we_a = ~(n_we_a_dst & we_a_alua);

    assign {n_oe_ph_alu, n_oe_pl_alu, n_oe_b_alu, n_oe_zero_alu} = oe_src_alu ? 4'b1111 : ~dst_decoded;
    assign {n_oe_b_d, n_oe_a_d} = oe_src_d ? 2'b11 : (src_d ? 2'b01 : 2'b10);

    assign n_we_flags = ~ir_is_alu;

    wire [1:0] flag = ir[1:0];
    wire condition_result = (ir[2] ^ |(flags & (4'b1 << flag))) | ir[3];
    assign swap_p = ir_is_jmp & (ir[3] | condition_result);

    assign n_oe_alu_di = ~ir_is_alu;
endmodule
