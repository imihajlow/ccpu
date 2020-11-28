`timescale 1ns/1ns
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
    output wire n_oe_pl_alu, n_oe_ph_alu, n_oe_b_alu; // drive ALU B input with register values
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
    // LD:  100___dd
    // ST:  101____s
    // LDI: 110___dd
    // Jc:  111_0cff
    // JMP: 111_10__
    // NOP: 111_11__

    // bits:
    // 7: other/ALU
    // 6: jump/other
    // 5: second cycle
    // 4: store or load

    wire n_clk;
    assign #10 n_clk = ~clk; // 74x04 inverter

    wire n_is_alu = ir[7];

    wire cycle;
    wire n_cycle;
    d_ff_7474 ff_cycle(
        .q(cycle),
        .n_q(n_cycle),
        .d(n_cycle),
        .cp(clk),
        .n_cd(n_rst),
        .n_sd(1'b1));

    wire supercycle;
    wire n_supercycle;
    wire #10 n_rst_supercycle = n_rst & op_ldi; // 74x08 AND gate
    d_ff_7474 ff_supercycle(
        .q(supercycle),
        .n_q(n_supercycle),
        .d(n_supercycle),
        .cp(cycle),
        .n_cd(n_rst_supercycle),
        .n_sd(1'b1));

    wire swap_p; // swap IP and DP on negedge clk
    wire #10 ff_p_selector_d = swap_p ^ p_selector; // 74x86 XOR gate
    d_ff_7474 ff_p_selector(
        .q(p_selector),
        .d(ff_p_selector_d),
        .cp(n_clk),
        .n_cd(n_rst),
        .n_sd(1'b1));

    wire we_cycle;
    wire n_we_cycle;
    wire #10 n_clear_we_cycle = n_rst | n_clk; // 74x32 OR gate
    wire #10 n_set_we_cycle = n_rst | clk; // 74x32 OR gate
    d_ff_7474 ff_we_cycle(
        .q(we_cycle),
        .n_q(n_we_cycle),
        .d(n_we_cycle),
        .cp(n_clk),
        .n_cd(n_clear_we_cycle),
        .n_sd(n_set_we_cycle));

    wire [1:0] index = ir[1:0];

    wire [3:0] n_decoded_flag;
    decoder_74139 dec_flag(
           .n_o(n_decoded_flag),
           .a(index),
           .n_e(ir[3]));

    wire [3:0] #10 cr_vec = n_decoded_flag | flags; // 74x32 OR gate

    // 74x08 AND gate
    wire #10 cr_01 = cr_vec[0] & cr_vec[1];
    wire #10 cr_23 = cr_vec[2] & cr_vec[3];
    wire #10 flag_set = cr_01 & cr_23;
    wire #10 condition_result = flag_set ^ ir[2]; // 74x86 XOR gate

    wire #10 op_alu = ~n_is_alu; // 74x04 inverter
    wire n_op_ld;
    wire n_op_st;
    wire n_op_ldi;
    wire n_op_jmp;

    wire #10 op_ldi = ~n_op_ldi; // 74x04 inverter
    wire #10 op_jmp = ~n_op_jmp; // 74x04 inverter

    decoder_74139 dec_op(
        .n_o({n_op_jmp, n_op_ldi, n_op_st, n_op_ld}),
        .a(ir[6:5]),
        .n_e(op_alu)
        );

    // n_oe_mem is always low, except cycle 1 of ST
    assign #20 n_oe_mem = ~(n_op_st | n_cycle); // 74x32 OR + 74x00 NAND

    // n_we_mem is always high, except high clk on cycle 1 of st
    assign #10 n_we_mem = ~(n_oe_mem & we_cycle); // 74x00 NAND

    assign #10 we_ir = n_cycle & n_supercycle;

    // n_oe_d_di is low in two cases:
    // - LD: cycle 1
    // - LDI: supercycle 1, cycle 0
    // assign n_oe_d_di = (n_op_ld | n_cycle) & (n_op_ldi | ~(supercycle & n_cycle));
    wire #20 n_oe_d_di_a = (n_op_ld & cycle) | (n_op_ldi & n_cycle); // 2x 74x08 AND + 1x 74x32 OR
    wire #10 n_op_ld_and_n_supercycle = n_op_ld & n_supercycle; // 74x08 AND
    wire #10 n_oe_d_di_b = n_op_ld_and_n_supercycle | we_ir; // 74x32 OR
    assign #10 n_oe_d_di = n_oe_d_di_a | n_oe_d_di_b; // 74x32 OR


    assign inc_ip = cycle;

    // addr_dp is 1 on cycle 1 of LD or ST
    wire #10 op_ld_or_st = ~(n_op_ld & n_op_st); // 74x00 NAND
    assign #10 addr_dp = cycle & op_ld_or_st; // 74x08 AND

    wire #10 jmp_and_result = op_jmp & condition_result; // 74x08 AND
    assign #10 swap_p = jmp_and_result & cycle; // 74x08 AND

    assign #10 n_oe_alu_di = ~(op_alu & cycle); // 74x00 NAND
    wire [3:0] n_decoded_oe_reg_alu;
    decoder_74139 dec_n_oe_reg_alu(
           .n_o(n_decoded_oe_reg_alu),
           .a(index),
           .n_e(n_oe_alu_di));
    assign n_oe_pl_alu = n_decoded_oe_reg_alu[2];
    assign n_oe_ph_alu = n_decoded_oe_reg_alu[3];
    assign n_oe_b_alu = n_decoded_oe_reg_alu[1];

    wire #10 n_ir2 = ~ir[2]; // 74x04 inverter
    wire #10 n_oe_alu_di_or_n_ir2 = n_oe_alu_di | n_ir2; // 74x32 OR
    wire #10 n_oe_alu_di_or_ir2 = n_oe_alu_di | ir[2]; // 74x32 OR
    wire #10 n_we_x = n_oe_alu_di_or_n_ir2 & n_oe_d_di; // 74x08 AND
    wire n_we_a;
    wire n_we_b;
    decoder_74139 dec_n_we_reg(
           .n_o({n_we_ph, n_we_pl, n_we_b, n_we_a}),
           .a(index),
           .n_e(n_we_x));
    assign #10 we_a = ~(n_we_a & n_oe_alu_di_or_ir2); // 74x00 NAND
    assign #10 we_b = ~n_we_b; // 74x04 inverter

    wire #10 n_oe_reg_d = n_op_st | n_cycle; // 74x32 OR
    wire [3:0] n_decoded_oe_reg_d;
    decoder_74139 dec_n_oe_reg_d(
           .n_o(n_decoded_oe_reg_d),
           .a({1'b0, index[0]}),
           .n_e(n_oe_reg_d));
    assign n_oe_a_d = n_decoded_oe_reg_d[0];
    assign n_oe_b_d = n_decoded_oe_reg_d[1];

    // n_we_flags is low for ALU operations except MOV (1000)
    wire [3:0] alu_op = ir[6:3];
    wire [3:0] n_dec_mov_o;
    decoder_74139 dec_mov(
           .n_o(n_dec_mov_o),
           .a(alu_op[3:2]),
           .n_e(alu_op[1]));
    wire #10 n_is_mov = n_dec_mov_o[2] | alu_op[0]; // 74x32 OR
    wire #10 is_mov_or_n_cycle = ~(n_is_mov & cycle); // 74x00 NAND
    assign #10 n_we_flags = n_is_alu | is_mov_or_n_cycle; // 74x32 OR


endmodule
