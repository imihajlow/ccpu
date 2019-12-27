module test_cpu();
    localparam FINISH_ADDR = 16'h1000;
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

    reg [7:0] ram [0:65535];

    wire [7:0] ram_out = ram[a];

    assign d = oe ? 8'bzzzzzzzz : ram_out;

    always @(we, a, d) begin
        if (~we) begin
            ram[a] <= d;
            $display("write [%h] <= %h", a, d);
        end
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
    initial begin
        $dumpfile("test_cpu.vcd");
        $dumpvars;
        $readmemh("test_cpu.hex", ram);
        rst = 1'b0;
        clk = 1'b0;
        dump_memory();

        #1 rst = 1'b1;

        for (i = 0; i < 1000; i = i + 2) begin
            #1
            if (~oe & (a == FINISH_ADDR)) begin
                $display("Finish address reached");
                dump_memory();
                $finish;
            end
            clk = 1'b1;
            #1 clk = 1'b0;
        end
        #1

        $display("Time limit reached");
        dump_memory();
    end
endmodule
