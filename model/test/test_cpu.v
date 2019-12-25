module test_cpu();

    reg clk;
    reg rst;
    wire [15:0] a;
    wire [7:0] d;
    wire oe;
    wire we;

    cpu inst(
        .clk(clk),
        .rst(rst),
        .a(a),
        .d(d),
        .oe(oe),
        .we(we));

    reg [7:0] ram [0:15];

    wire [7:0] ram_out = ram[a[3:0]];

    assign d = oe ? 8'bzzzzzzzz : ram_out;

    always @(we, a, d) begin
        if (~we) begin
            ram[a[3:0]] <= d;
        end
    end

    integer i;
    initial begin
        $dumpfile("test_cpu.vcd");
        $dumpvars;
        $readmemb("ram.in", ram);
        rst = 1'b0;
        clk = 1'b0;

        #1 rst = 1'b1;

        for (i = 0; i < 120; i = i + 2) begin
            #1 clk = 1'b1;
            #1 clk = 1'b0;
        end
        #1

        for (i = 0; i < 16; i = i + 1) begin
            $display("%h %b", i, ram[i]);
        end
    end
endmodule
