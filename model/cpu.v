module cpu(clk, rst, a, d, oe, we);
    input clk;
    input rst;
    output [15:0] a;
    inout [7:0] d;
    output oe;
    output we;

    wire nclk = ~clk;

    wire [7:0] ir_out;
    wire ir_we;
    uni_reg reg_ir(
            .doa(ir_out),
            .clk(clk),
            .rst(rst),
            .we(ir_we),
            .oea(1'b0), // always enable one output
            .oeb(1'b1),
            .cnt(1'b0), // never count
            .di(d));

    wire [7:0] d_int = 8'bzzzzzzzz; // internal data bus
    wire [7:0] alu_a = 8'bz; // first ALU input
    wire [7:0] alu_b = 8'bz; // second ALU input

    wire a_we;
    wire a_to_d_oe;
    uni_reg reg_a(
            .doa(d),
            .dob(alu_a),
            .clk(nclk),
            .rst(rst),
            .we(a_we),
            .oea(a_to_d_oe),
            .oeb(1'b0), // always output to ALU
            .di(d_int));

    wire b_we;
    wire b_to_d_oe;
    wire b_to_alu_oe;
    uni_reg reg_b(
            .doa(d),
            .dob(alu_b),
            .clk(nclk),
            .rst(rst),
            .we(b_we),
            .oea(b_to_d_oe),
            .oeb(b_to_alu_oe),
            .di(d_int));

    wire [3:0] flags_in;
    wire [3:0] flags_out;
    wire flags_we;
    counter_74163 reg_flags(
            .Q(flags_out),
            .clk(nclk),
            .clr_n(rst),
            .enp(1'b0),
            .ent(1'b0),
            .load_n(flags_we),
            .P(flags_in));

    wire addr_dp;
    wire ip_to_addr_oe = addr_dp;
    wire dp_to_addr_oe = ~addr_dp;
    wire dph_to_alu_oe;
    wire dpl_to_alu_oe;
    wire ip_cnt;
    wire dpl_we;
    wire dph_we;
    wire p_selector;
    pointer_pair reg_p(
            .addr_out(a),
            .data_out(alu_b),
            .clk(nclk),
            .rst(rst),
            .di(d_int),
            .oe_addr_ip(ip_to_addr_oe),
            .oe_addr_dp(dp_to_addr_oe),
            .oe_dl(dpl_to_alu_oe),
            .oe_dh(dph_to_alu_oe),
            .cnt(ip_cnt),
            .we_l(dpl_we),
            .we_h(dph_we),
            .selector(p_selector));

    wire alu_oe;
    wire [3:0] alu_op;
    wire alu_invert;
    alu alu_inst(
        .a(alu_a),
        .b(alu_b),
        .op(alu_op),
        .oe(alu_oe),
        .invert(alu_invert),
        .result(d_int),
        .flags(flags_in),
        .carry_in(flags_out[1])
        );

    wire d_to_di_oe;
    assign d_int = d_to_di_oe ? 8'bz : d;

    reg p_switch;
    wire p_toggle;
    initial begin
        p_switch = 0;
    end

    always @(posedge nclk or negedge rst) begin
        if (~rst) begin
            p_switch <= 0;
        end else if (p_toggle) begin
            p_switch <= ~p_switch;
        end
    end

    assign p_selector = p_switch;

    wire zero_to_alu_oe;
    assign alu_b = zero_to_alu_oe ? 8'bz : 8'b0;

    control_unit cu(
                .mem_oe(oe),
                .mem_we(we),
                .d_to_di_oe(d_to_di_oe),
                .ir_we(ir_we),
                .ip_inc(ip_cnt),
                .addr_dp(addr_dp),
                .swap_p(p_toggle),
                .we_pl(dpl_we),
                .we_ph(dph_we),
                .we_a(a_we),
                .we_b(b_we),
                .oe_pl_alu(dpl_to_alu_oe),
                .oe_ph_alu(dph_to_alu_oe),
                .oe_b_alu(b_to_alu_oe),
                .oe_zero_alu(zero_to_alu_oe),
                .oe_a_d(a_to_d_oe),
                .oe_b_d(b_to_d_oe),
                .we_flags(flags_we),
                .alu_op(alu_op),
                .alu_oe(alu_oe),
                .alu_invert(alu_invert),
                .clk(clk),
                .rst(rst),
                .ir(ir_out),
                .flags(flags_out));
endmodule
