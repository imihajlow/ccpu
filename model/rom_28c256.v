`timescale 1ns/1ns
module rom_28c256(
//output
          d,
//input
          a,
          n_cs,
          n_oe);
    parameter FILENAME="";
    input wire [14:0] a;
    output wire [7:0] d;
    input wire n_cs;
    input wire n_oe;

    reg [7:0] rom[0:(1 << 15) - 1];

    initial begin
        $readmemh(FILENAME, rom);
    end

    assign #350 d = (n_cs | n_oe) ? 8'bz : rom[a];
endmodule
