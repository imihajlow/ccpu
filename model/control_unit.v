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
            oe_a_d,
            oe_b_d,
            we_flags,
            alu_op,
            alu_oe,
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
    output wire oe_pl_alu, oe_ph_alu, oe_b_alu; // drive ALU B input with register values
    output wire oe_a_d, oe_b_d; // drive external D bus with a or b

    output wire we_flags; // latch flags on negedge clk
    output wire [2:0] alu_op;
    output wire alu_oe; // ALU output to DI is enabled

    // Instructions:
    // LD x:        [DP] -> x
    // ST x:        x -> [DP]
    // ALU x, op:   x = ALU(A, x, op)
    // LDI x:       IP++, [IP] -> x
    // Jc:          if c swap(IP, DP)
    // JMP:         swap(IP, DP)

    // LD:  0010__xx
    // ST:  0011___x
    // ALU: 000oooxx
    // LDI: 1010__xx
    // Jc:  011_0cff
    // JMP: 011_1cff

    // bits:
    // 7: 2/1 cycle
    // 6: condition/register
    // 5: DI driven by D/ALU
    // 4: LD or ST (LD, ST, LDI)

    wire ld = ir[7:4] == 4'b0010;
    wire st = ir[7:4] == 4'b0011;
    wire alu = ir[7:5] == 3'b000;
    wire ldi = ir[7:4] == 4'b1010;
    wire jc = ir[7:6] == 2'b01;

    reg cycle;
    wire reset_cycle = ~ir[7];
    initial begin
        cycle = 1'b0;
    end

    always @(negedge clk or negedge rst) begin
        if (~rst) begin
            cycle <= 1'b0;
        end else if (reset_cycle) begin
            cycle <= 1'b0;
        end else begin
            cycle <= ~cycle;
        end
    end


    // mem_oe is high when op is ST and clk is high
    assign mem_oe = st & clk;
    assign mem_we = ~mem_oe;

    assign d_to_di_oe = ~(ld | (ir[7] & cycle));

    assign ir_we = cycle;

    assign ip_inc = 1'b1;

    // (ir == st || ir == ld) & clk
    assign addr_dp = (ir[7:5] == 3'b001) & clk;

    wire [3:0] decoded_x = ~(1 << ir[1:0]);
    wire we_x = jc | st | (ldi & (~cycle | ~clk));
    wire oe_x_alu = ir[5];
    wire oe_x_d = ~(st & clk);
    assign {we_ph, we_pl, we_b, we_a} = we_x ? 4'b1111 : decoded_x;
    assign {oe_ph_alu, oe_pl_alu, oe_b_alu} = oe_x_alu ? 3'b111 : decoded_x[3:1];
    assign {oe_b_d, oe_a_d} = oe_x_d ? 2'b11 : (ir[0] ? 2'b01 : 2'b10);

    assign we_flags = ~alu;

    wire [1:0] flag = ir[1:0];
    wire condition_result = (ir[2] ^ |(flags & (4'b1 << flag))) | ir[3];
    assign swap_p = jc & condition_result;

    assign alu_op = ir[4:2];
    assign alu_oe = ~alu;
endmodule
