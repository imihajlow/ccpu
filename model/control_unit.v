module control_unit(
//output
            n_mem_oe,
            n_mem_we,
            n_d_to_di_oe,
            ir_we,
            ip_inc,
            addr_dp,
            swap_p,
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
            n_alu_oe,
            alu_invert,
//input
            clk,
            n_rst,
            ir,
            flags);
    input wire clk; // clock
    input wire n_rst; // reset
    input wire [7:0] ir; // current instruction
    input wire [3:0] flags; // stored ALU flags

    output wire n_mem_oe; // CPU output
    output wire n_mem_we; // CPU output

    output wire n_d_to_di_oe; // output the D bus into the DI bus, active low
    output wire ir_we; // latch D into IR on posedge clk, active high

    output wire ip_inc; // increment IP on negedge clk
    output wire addr_dp; // 0 - drive Address with IP, 1 - with DP
    output wire swap_p; // swap IP and DP on negedge clk

    output wire n_we_pl, n_we_ph; // latch registers from DI on negedge clk, active low
    output wire we_a, we_b; // latch registers from DI on negedge clk, active high
    output wire n_oe_pl_alu, n_oe_ph_alu, n_oe_b_alu, n_oe_zero_alu; // drive ALU B input with register values
    output wire n_oe_a_d, n_oe_b_d; // drive external D bus with a or b

    output wire n_we_flags; // latch flags on negedge clk
    output wire n_alu_oe; // ALU output to DI is enabled
    output wire alu_invert;

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

    reg cycle;
    wire n_reset_cycle = ir_is_2cy;
    initial begin
        cycle = 1'b0;
    end

    always @(posedge clk or negedge n_rst or negedge n_reset_cycle) begin
        if (~n_rst) begin
            cycle <= 1'b0;
        end else if (~n_reset_cycle) begin
            cycle <= 1'b0;
        end else begin
            cycle <= ~cycle;
        end
    end

    reg ir_we_reg;
    initial begin
        ir_we_reg = 1'b0;
    end

    always @(negedge clk or negedge n_rst) begin
        if (~n_rst) begin
            ir_we_reg <= 1'b0;
        end else if (ir_is_2cy) begin
            ir_we_reg <= ~ir_we_reg;
        end
    end

    assign n_mem_oe = st & (~cycle | clk);
    assign n_mem_we = ~(st & ~cycle & ~clk);

    assign n_d_to_di_oe = ~((ldi & cycle) | ld);

    assign ir_we = ~ir_we_reg;

    assign ip_inc = ~st | cycle;

    assign addr_dp = (ld & clk) | (st & (~cycle | clk));

    wire [1:0] dst = ir[1:0];
    wire [3:0] dst_decoded = 4'b1 << dst;
    wire src_d = ir[0];

    wire we_dst = ir_is_jmp | ir_is_sto | (ldi & ~cycle) | (ir_is_alu & ~ir[2]);
    wire oe_src_alu = ~ir_is_alu;
    wire oe_src_d = ~(st & ir_we_reg);

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

    assign n_alu_oe = ~ir_is_alu;
    assign alu_invert = ir_is_alu & ir[2];
endmodule
