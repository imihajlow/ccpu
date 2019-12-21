module ram(a, d, oe, we, clk);
    parameter D_WIDTH = 8;
    parameter A_WIDTH = 15;
    input [A_WIDTH-1:0] a;
    inout [D_WIDTH-1:0] d;
    input oe, we, clk;

    reg [D_WIDTH-1:0] storage [0:(2 << A_WIDTH) - 1];

    assign d = oe ? storage[a] : 'bz;

    always @(posedge clk) begin
        if (we) begin
            storage[a] <= d;
        end
    end
endmodule
