`timescale 1ns/1ns
module test_vga();
/*
    This is not an automatic test bench.
    To test VGA: run test_vga_ctrl.v, check errors, then run this one, open test_vga.vcd and observe waveforms.
*/
task assert;
    input v;
    if (v !== 1'b1)
        $fatal;
endtask

reg n_rst;
reg [15:0] a;
wire [7:0] d;
reg n_oe, n_we;
wire n_rdy;
wire [3:0] color_out;
wire hsync_out, vsync_out;

vga inst(
    .n_rst(n_rst),
    .a(a),
    .d(d),
    .n_oe(n_oe),
    .n_we(n_we),
    .n_rdy(n_rdy),
    .color_out(color_out),
    .hsync_out(hsync_out),
    .vsync_out(vsync_out));

initial begin
    $dumpfile("test_vga.vcd");
    $dumpvars;
    n_rst = 0;
    a = 0;
    n_oe = 1;
    n_we = 1;
    #1000

    n_rst = 1;
    #35000000;
    $finish;
end

endmodule
