module control_unit(
//output
            mem_oe,
            mem_we,
            d_to_di_oe,
            ir_we,
            ip_inc,
            addr_dp,
            swap_p,
            we_pl,
            we_ph,
            we_a,
            we_b,
            oe_pl_alu,
            oe_ph_alu,
            oe_b_alu,
            oe_zero_alu,
            oe_a_d,
            oe_b_d,
            we_flags,
            alu_op,
            alu_oe,
            alu_invert,
//input
            clk,
            rst,
            ir,
            flags);
    input wire clk; // clock
    input wire rst; // reset
    input wire [7:0] ir; // current instruction
    input wire [3:0] flags; // stored ALU flags

    output wire mem_oe; // CPU output
    output wire mem_we; // CPU output

    output wire d_to_di_oe; // output the D bus into the DI bus
    output wire ir_we; // latch D into IR on posedge clk

    output wire ip_inc; // increment IP on negedge clk
    output wire addr_dp; // 0 - drive Address with IP, 1 - with DP
    output wire swap_p; // swap IP and DP on negedge clk

    output wire we_pl, we_ph, we_a, we_b; // latch registers from DI on negedge clk
    output wire oe_pl_alu, oe_ph_alu, oe_b_alu, oe_zero_alu; // drive ALU B input with register values
    output wire oe_a_d, oe_b_d; // drive external D bus with a or b

    output wire we_flags; // latch flags on negedge clk
    output wire [3:0] alu_op;
    output wire alu_oe; // ALU output to DI is enabled
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
    // ST:  1001___s
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
    wire st = ir[7:4] == 4'b1001;
    wire alu = ir[7] == 1'b0;
    wire ldi = ir[7:4] == 4'b1010;
    wire jc = ir[7:4] == 4'b1100;

    reg cycle;
    wire n_reset_cycle = ir_is_2cy;
    initial begin
        cycle = 1'b0;
    end

    always @(posedge clk or negedge rst or negedge n_reset_cycle) begin
        if (~rst) begin
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

    always @(negedge clk or negedge rst) begin
        if (~rst) begin
            ir_we_reg <= 1'b0;
        end else if (ir_is_2cy) begin
            ir_we_reg <= ~ir_we_reg;
        end
    end

    // mem_oe is high when op is ST and clk is high
    assign mem_oe = ir_is_sto & clk;
    assign mem_we = ~mem_oe;

    assign d_to_di_oe = ir_is_alu | ir_is_jmp | ir_is_sto | (ir_is_2cy & ~cycle);

    assign ir_we = ir_we_reg;

    assign ip_inc = 1'b1;

    // (ir == st || ir == ld) & clk
    assign addr_dp = (ir[7:5] == 3'b100) & clk;

    wire [1:0] dst = ir[1:0];
    wire [3:0] dst_decoded = 4'b1 << dst;
    wire src_d = ir[0];

    wire we_dst = ir_is_jmp | ir_is_sto | (ir_is_2cy & ~cycle) | (ir_is_alu & ~ir[2]);
    wire oe_src_alu = ~ir_is_alu;
    wire oe_src_d = ~(ir_is_sto & clk);

    wire we_a_dst;
    wire we_a_alua = ~ir_is_alu | ir[2];
    assign {we_ph, we_pl, we_b, we_a_dst} = we_dst ? 4'b1111 : ~dst_decoded;
    assign we_a = we_a_dst & we_a_alua;

    assign {oe_ph_alu, oe_pl_alu, oe_b_alu, oe_zero_alu} = oe_src_alu ? 3'b1111 : ~dst_decoded;
    assign {oe_b_d, oe_a_d} = oe_src_d ? 2'b11 : (src_d ? 2'b01 : 2'b10);

    assign we_flags = ~ir_is_alu;

    wire [1:0] flag = ir[1:0];
    wire condition_result = (ir[2] ^ |(flags & (4'b1 << flag))) | ir[3];
    assign swap_p = ir_is_jmp & (ir[3] | condition_result);

    assign alu_op = ir[6:3];
    assign alu_oe = ~ir_is_alu;
    assign alu_invert = ir_is_alu & ir[2];
endmodule
