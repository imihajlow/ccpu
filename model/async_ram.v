`timescale 1ns/1ns
module async_ram(a, d, n_oe, n_we, n_cs);
    parameter D_WIDTH = 8;
    parameter A_WIDTH = 15;
    parameter INITIAL_VALUE = 'hx;
    input [A_WIDTH-1:0] a;
    inout [D_WIDTH-1:0] d;
    input n_oe, n_we, n_cs;

    reg [D_WIDTH-1:0] storage [0:(2 << A_WIDTH) - 1];

    assign #55 d = (n_oe | n_cs) ? 'bz : storage[a];

    integer i;
    initial begin
        for (i = 0; i < (1 << A_WIDTH); i = i + 1) begin
            storage[i] = INITIAL_VALUE;
        end
    end

    always @(posedge n_we) begin
        if (~n_cs) begin
            storage[a] <= d;
        end
    end
endmodule
