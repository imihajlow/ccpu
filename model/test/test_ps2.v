`timescale 1us/1ns
module test_ps2();
task assert;
    input v;
    if (v !== 1'b1)
        $fatal;
endtask

reg n_rst;

wire rdy;
wire [7:0] d;
reg n_oe;
reg n_we;
reg n_sel;
reg a;

wire n_clk_out;
wire n_data_out;
reg clk_in;
reg data_in;

wire #0.01 clk = clk_in & ~n_clk_out;  // simulated open-drain
wire #0.01 data = data_in & ~n_data_out; // simulated open-drain
ps2 inst(
    .d(d),
    .n_clk_out(n_clk_out),
    .n_data_out(n_data_out),
    .rdy(rdy),
    .n_rst(n_rst),
    .clk_in(clk),
    .data_in(data),
    .n_oe(n_oe),
    .n_we(n_we),
    .n_sel(n_sel),
    .a(a)
);

reg [7:0] d_in;
assign #0.1 d = n_we ? 8'bz : d_in;


parameter N = 5;
integer i, j;
reg [10:0] data_recv[0:N-1];

initial begin
    data_recv[0][8:1] = 8'ha5;
    data_recv[1][8:1] = 8'h84;
    data_recv[2][8:1] = 8'h02;
    data_recv[3][8:1] = 8'hff;
    data_recv[4][8:1] = 8'h00;
    for (i = 0; i < N; i = i + 1) begin
        data_recv[i][0] = 0; // start bit
        data_recv[i][9] = i[0] ^ ^data_recv[i][8:1]; // parity valid on even i
        data_recv[i][10] = 1; // stop bit
    end
end

initial begin
    $dumpfile("test_ps2.vcd");
    $dumpvars;
    n_rst = 0;
    n_oe = 1;
    n_we = 1;
    n_sel = 0;
    clk_in = 1;
    data_in = 1;
    a = 0;

    #200
    n_rst = 1;
    #10

    // read status
    n_oe = 0;
    a = 1;
    #1
    while (~rdy) #10;
    assert(d[0] === 0); // no data
    n_oe = 1;
    #1

    // Test reception
    for (j = 0; j < N; j = j + 1) begin
        #1
        for (i = 0; i < 11; i = i + 1) begin
            assert(n_data_out === 0);
            assert(n_clk_out === 0);
            #25
            assert(n_data_out === 0);
            assert(n_clk_out === 0);
            data_in = data_recv[j][i];
            #25
            assert(n_data_out === 0);
            assert(n_clk_out === 0);
            clk_in = 0;
            #50
            assert(n_data_out === 0);
            assert(n_clk_out === (i == 10));
            clk_in = 1;
        end
        #150 ;
        assert(n_clk_out === 1);

        // read status
        n_oe = 0;
        a = 1;
        #1
        while (~rdy) #10;
        assert(d[0] === 1); // has data
        assert(d[1] === j[0]); // parity valid on even input values, invalid on odd
        n_oe = 1;
        #1

        // read data
        n_oe = 0;
        a = 0;
        #1;
        while (~rdy) #10;
        assert(n_clk_out === 1);
        if (d !== data_recv[j][8:1]) begin
            $display("received data mismatch: expected %08b, got %08b", data_recv[j][8:1], d);
            $fatal;
        end
        n_oe = 1;
        #1
        assert(n_clk_out === 1);

        // reset for the next reception
        #1
        a = 1;
        n_we = 0;
        #1
        assert(n_clk_out === 0);
        n_we = 1;
        a = 0;
        #1
        assert(n_clk_out === 0);

        // read status
        n_oe = 0;
        a = 1;
        #1
        while (~rdy) #10;
        assert(d[0] === 0); // no data
        n_oe = 1;
    end

    #300

    // test send
    a = 0;
    n_we = 0;
    #1;
    n_we = 1;
    #300
    $finish;
end

initial begin
    #1000000
    $display("timeout");
    $fatal;
end
endmodule
