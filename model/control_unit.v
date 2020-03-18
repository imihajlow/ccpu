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
    // LD:  1000__dd
    // ST:  1001___s
    // LDI: 1010__dd
    // Jc:  11000cff
    // JMP: 11001___

    // bits:
    // 7: other/ALU
    // 6: jump/other
    // 5: second cycle
    // 4: store or load

    wire n_clk;
    assign #10 n_clk = clk ^ 1'b1; // 74x86 XOR gate

    wire n_is_alu = ir[7];
    wire is_jmp = ir[6];
    wire is_2cy = ir[5];
    wire is_sto = ir[4];

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
    wire n_rst_supercycle;
    assign n_rst_supercycle = n_rst & n_is_alu & is_2cy;
    d_ff_7474 ff_supercycle(
        .q(supercycle),
        .n_q(n_supercycle),
        .d(n_supercycle),
        .cp(cycle),
        .n_cd(n_rst_supercycle),
        .n_sd(1'b1));

    wire swap_p; // swap IP and DP on negedge clk
    wire ff_p_selector_d;
    assign #10 ff_p_selector_d = swap_p ^ p_selector; // 74x86 XOR gate
    d_ff_7474 ff_p_selector(
        .q(p_selector),
        .d(ff_p_selector_d),
        .cp(n_clk),
        .n_cd(n_rst),
        .n_sd(1'b1));

    wire condition_result;
    wire flag_set;
    wire [1:0] index = ir[1:0];

    wire [3:0] n_decoded_flag;
    decoder_74139 dec_flag(
           .n_o(n_decoded_flag),
           .a(index),
           .n_e(1'b0));

    wire [3:0] cr_vec;
    assign #10 cr_vec = n_decoded_flag | flags; // 74x32 OR gate

    wire cr_01;
    wire cr_23;
    // 74x08 AND gate
    assign #10 cr_01 = cr_vec[0] & cr_vec[1];
    assign #10 cr_23 = cr_vec[2] & cr_vec[3];
    assign #10 flag_set = cr_01 & cr_23;
    assign #10 condition_result = flag_set ^ ir[2];

    // n_oe_mem is always low, except cycle 1 of ST
    assign n_oe_mem = n_is_alu & is_sto & cycle;

    // n_we_mem is always high, except high clk on cycle 1 of st
    assign n_we_mem = ~(n_oe_mem & clk);

    // n_oe_d_di is low in two cases:
    // - LD: cycle 1
    // - LDI: supercycle 1, cycle 0
    assign n_oe_d_di = ~n_is_alu | is_jmp | is_sto | ~((is_2cy & supercycle & n_cycle) | (~is_2cy & cycle));

    assign we_ir = n_cycle & n_supercycle;

    assign inc_ip = cycle;

    // addr_dp is 1 on cycle 1 of LD or ST
    assign addr_dp = cycle & n_is_alu & ~is_jmp & ~is_2cy;


    assign swap_p = n_is_alu & is_jmp & (condition_result | ir[3]) & cycle;

    wire n_we_x = ~((~n_is_alu & ir[2] & cycle) | (n_is_alu & ~is_jmp & ~is_sto & ~is_2cy & cycle) | (n_is_alu & is_2cy & supercycle & n_cycle));
    wire n_we_a;
    wire n_we_b;
    decoder_74139 dec_n_we_reg(
           .n_o({n_we_ph, n_we_pl, n_we_b, n_we_a}),
           .a(index),
           .n_e(n_we_x));
    assign we_a = ~n_we_a | (~n_is_alu & ~ir[2] & cycle);
    assign we_b = ~n_we_b;

    wire n_oe_reg_alu = n_is_alu | n_cycle;
    wire [3:0] n_decoded_oe_reg_alu;
    decoder_74139 dec_n_oe_reg_alu(
           .n_o(n_decoded_oe_reg_alu),
           .a(index),
           .n_e(n_oe_reg_alu));
    assign n_oe_pl_alu = n_decoded_oe_reg_alu[2];
    assign n_oe_ph_alu = n_decoded_oe_reg_alu[3];
    assign n_oe_b_alu = n_decoded_oe_reg_alu[1];

    // n_we_flags is low for ALU operations except MOV (1000)
    wire [3:0] alu_op = ir[6:3];
    assign n_we_flags = n_is_alu | (alu_op == 4'b1000) | n_cycle;

    assign n_oe_alu_di = n_is_alu | n_cycle;

    wire n_oe_reg_d = ~(n_is_alu & is_sto & cycle);
    wire [3:0] n_decoded_oe_reg_d;
    decoder_74139 dec_n_oe_reg_d(
           .n_o(n_decoded_oe_reg_d),
           .a({1'b0, index[0]}),
           .n_e(n_oe_reg_d));
    assign n_oe_a_d = n_decoded_oe_reg_d[0];
    assign n_oe_b_d = n_decoded_oe_reg_d[1];
endmodule
