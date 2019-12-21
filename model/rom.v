module rom(a, d, ena);
    parameter A_WIDTH = 15;
    parameter FILENAME = "rom.hex";
    input [A_WIDTH-1:0] a;
    output [7:0] d;
    input ena;

    reg [7:0] mem [0:(1 << A_WIDTH) - 1];

    initial begin
        $readmemh(FILENAME, mem);
    end

    assign d = ena ? mem[a] : 'bz;
endmodule
