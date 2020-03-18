`timescale 1ms/1ns
module test_cpu();
    localparam FINISH_ADDR = 16'h1000;
    localparam RESULT_ADDR = 16'h0100;
    localparam SAMPLE_ADDR = 16'h0200;
    localparam RESULT_SIZE = 2;
    reg clk;
    reg n_rst;
    wire [15:0] a;
    wire [7:0] d;
    wire n_oe;
    wire n_we;

    cpu inst(
        .clk_in(clk),
        .n_rst(n_rst),
        .a(a),
        .d(d),
        .n_oe(n_oe),
        .n_we(n_we),
        .n_rdy(1'b0));

    reg [7:0] ram [0:65535];

    wire [7:0] ram_out = ram[a];

    assign #0.075 d = n_oe ? 8'bzzzzzzzz : ram_out;

    always @(posedge n_we) begin
        ram[a] <= d;
        $display("write [%h] <= %h", a, d);
    end

    task dump_memory();
        integer i;
        for (i = 0; i < 512; i = i + 16) begin
            $display("%h: %h %h %h %h %h %h %h %h  %h %h %h %h %h %h %h %h", i,
                ram[i],
                ram[i + 1],
                ram[i + 2],
                ram[i + 3],
                ram[i + 4],
                ram[i + 5],
                ram[i + 6],
                ram[i + 7],
                ram[i + 8],
                ram[i + 9],
                ram[i + 10],
                ram[i + 11],
                ram[i + 12],
                ram[i + 13],
                ram[i + 14],
                ram[i + 15]);
        end
    endtask

    integer i;
    integer j;
    initial begin
        $dumpfile("test_cpu.vcd");
        $dumpvars;
        $readmemh("test_cpu.hex", ram);
        n_rst = 1'b0;
        clk = 1'b1;
        dump_memory();

        #1 n_rst = 1'b1;

        for (i = 0; i < 5000; i = i + 2) begin
            #1
            if (~n_oe & (a === FINISH_ADDR)) begin
                $display("Finish address reached");
                dump_memory();

                for (j = 0; j < RESULT_SIZE; j = j + 1) begin
                    if (ram[RESULT_ADDR + j] !== ram[SAMPLE_ADDR + j]) begin
                        $display("Result mismatch");
                        $fatal;
                    end
                end
                $display("Result check OK");
                $finish;
            end
            clk = 1'b0;
            #1 clk = 1'b1;
        end
        #1

        $display("Time limit reached");
        dump_memory();
        $fatal;
    end
endmodule
