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
wire #0.01 n_clk = ~clk; // 74lv14a
wire #0.01 n_data = ~data; // 74lv14a
ps2 inst(
    .d(d),
    .n_clk_out(n_clk_out),
    .n_data_out(n_data_out),
    .rdy(rdy),
    .n_rst(n_rst),
    .n_clk_in(n_clk),
    .n_data_in(n_data),
    .n_oe(n_oe),
    .n_we(n_we),
    .n_sel(n_sel),
    .a(a)
);

reg [7:0] d_in;
assign #0.1 d = n_we ? 8'bz : d_in;

reg can_transmit;
reg transmitting;
initial begin
    transmitting = 0;
    can_transmit = 1;
end

task transmit_to_host;
    input [7:0] b;
    input parity_valid;

    reg complete;
    integer i;
    begin
        complete = 0;
        while (~complete) begin
            wait(clk);
            #5
            wait(can_transmit);
            transmitting = 1;
            for (i = 0; (i < 11) & ~n_clk_out; i = i + 1) begin
                if (i == 0)
                    data_in = 0;
                else if (i < 9)
                    data_in = b[i - 1];
                else if (i == 9)
                    data_in = parity_valid ^ ^b;
                else
                    data_in = 1;
                #25
                clk_in = 0;
                #25
                clk_in = 1;
            end
            data_in = 1;
            complete = i == 11;
            if (~complete)
                $display("transmission interrupted");
            transmitting = 0;
        end
    end
endtask

reg [7:0] recv_template;
reg [7:0] recv_data;
reg recv_parity;
integer last_clk_down;
initial begin
    last_clk_down = 0;
end
always @(posedge n_clk_out) begin
    last_clk_down = $stime;
end
integer reception_bit;
always @(negedge n_clk_out) begin
    if ($stime - last_clk_down > 100 && n_data_out) begin
        // byte reception requested
        can_transmit = 0;
        for (reception_bit = 0; reception_bit < 11 & ~n_clk_out; reception_bit = reception_bit + 1) begin
            #25
            clk_in = 0;
            #25
            clk_in = 1;
            if (reception_bit < 8)
                recv_data[reception_bit] = ~n_data_out;
            else if (reception_bit == 8)
                recv_parity = ~n_data_out;
            else if (reception_bit == 9)
                data_in = 0;
            else
                data_in = 1;
        end
        can_transmit = 1;
        if (reception_bit != 11)
            $display("reception interrupted");
        else begin
            $display("data received by device: %08b %01b", recv_data, recv_parity);
            if (recv_template !== recv_data) begin
                $display("received by device data mismatch: %08b expected, %08b got", recv_template, recv_data);
                $fatal;
            end
            if (^recv_data == recv_parity) begin
                $display("host to device parity error");
                $fatal;
            end
        end
    end
end

parameter N = 5;
integer i, j;
reg [7:0] data_recv[0:N-1];
reg [10:0] data_send;

initial begin
    data_recv[0] = 8'ha5;
    data_recv[1] = 8'h84;
    data_recv[2] = 8'h02;
    data_recv[3] = 8'hff;
    data_recv[4] = 8'h00;
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
    wait (rdy);
    assert(d[0] === 0); // no data
    n_oe = 1;
    #1

    // Test reception
    for (j = 0; j < N; j = j + 1) begin
        #1
        transmit_to_host(data_recv[j], j[0]);
        #150 ;
        assert(n_clk_out === 1);

        // read status
        n_oe = 0;
        a = 1;
        #1
        wait (rdy);
        #10;
        assert(d[0] === 1); // has data
        assert(d[1] === j[0]); // parity valid on even input values, invalid on odd
        n_oe = 1;
        #1

        // read data
        n_oe = 0;
        a = 0;
        #1;
        wait (rdy);
        assert(n_clk_out === 1);
        if (d !== data_recv[j]) begin
            $display("received data mismatch: expected %08b, got %08b", data_recv[j], d);
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
        wait (rdy);
        assert(d[0] === 0); // no data
        n_oe = 1;
    end

    #300

    // test send
    recv_template = 8'b11001010;
    a = 0;
    d_in = recv_template;
    n_we = 0;
    #1;
    n_we = 1;
    #1
    // read status
    a = 1;
    n_oe = 0;
    wait(rdy);
    assert(~d[0]); // no data in recv register
    assert(d[2] === 0); // ack

    // send when data is received
    transmit_to_host(8'h4c, 1);
    #1
    a = 1;
    n_oe = 0;
    wait(rdy);
    assert(d[0]); // has data
    assert(d[1]); // parity valid
    a = 0;
    #1
    wait(rdy);
    assert(d === 8'h4c);

    #1
    n_oe = 1;
    a = 0;
    #1
    recv_template = 8'hc5;
    d_in = recv_template;
    n_we = 0;
    #1
    wait(rdy);
    n_we = 1;
    #1
    // read status
    a = 1;
    n_oe = 0;
    wait(rdy);
    assert(d[0]); // has data
    assert(d[1]); // parity valid
    assert(d[2] === 0); // ack
    #1
    assert(n_clk_out); // reception is still inhibited

    // read data
    a = 0;
    #1
    wait(rdy);
    assert(d === 8'h4c);

    #1000;
    $finish;
end

initial begin
    #1000000
    $display("timeout");
    $fatal;
end
endmodule
