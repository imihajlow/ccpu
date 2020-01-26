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
    // ST:  1011___s
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

    wire cycle;
    wire n_reset_cycle;
    wire n_cycle;
    wire ff_cycle_n_cd;
    assign #10 ff_cycle_n_cd = n_rst & n_reset_cycle; // 74x08 AND gate
    d_ff_7474 ff_cycle(
        .q(cycle),
        .n_q(n_cycle),
        .d(n_cycle),
        .cp(clk),
        .n_cd(ff_cycle_n_cd),
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

    wire s1, s2;
    wire s1_d, s2_d;
    d_ff_7474 ff_s1(
        .q(s1),
        .d(s1_d),
        .cp(clk),
        .n_cd(n_rst),
        .n_sd(1'b1));

    d_ff_7474 ff_s2(
        .q(s2),
        .d(s2_d),
        .cp(clk),
        .n_cd(n_rst),
        .n_sd(1'b1));

    wire condition_result;
    wire [1:0] flag = ir[1:0];

    wire [3:0] n_decoded_flag;
    decoder_74139 dec_flag(
           .n_o(n_decoded_flag),
           .a(flag),
           .n_e(1'b0));

    wire [3:0] cr_vec;
    assign #10 cr_vec = n_decoded_flag | flags; // 74x32 OR gate

    wire cr_01;
    wire cr_23;
    // 74x08 AND gate
    assign #10 cr_01 = cr_vec[0] & cr_vec[1];
    assign #10 cr_23 = cr_vec[2] & cr_vec[3];
    assign #10 condition_result = cr_01 & cr_23;

    wire [14:0] rom_addr = {1'b0, s2, s1, n_mem_rdy, cycle, condition_result, clk, ir};
    wire [7:0] d_a;
    rom_28c256 #(.FILENAME("cu_a.mem")) rom_a(
        .a(rom_addr),
        .d(d_a),
        .n_oe(1'b0),
        .n_cs(1'b0)
        );
    assign {we_ir, addr_dp, inc_ip, n_oe_d_di, n_we_mem, n_oe_mem} = d_a[5:0];

    wire [7:0] d_b;
    rom_28c256 #(.FILENAME("cu_b.mem")) rom_b(
        .a(rom_addr),
        .d(d_b),
        .n_oe(1'b0),
        .n_cs(1'b0)
        );
    assign {s2_d, s1_d, n_we_flags, n_oe_b_d, n_oe_a_d, n_oe_b_alu, n_oe_ph_alu, n_oe_pl_alu} = d_b[6:0];

    wire [7:0] d_c;
    rom_28c256 #(.FILENAME("cu_c.mem")) rom_c(
        .a(rom_addr),
        .d(d_c),
        .n_oe(1'b0),
        .n_cs(1'b0)
        );
    assign {we_b, we_a, n_we_ph, n_we_pl, swap_p, n_reset_cycle, n_oe_alu_di} = d_c[6:0];
endmodule
