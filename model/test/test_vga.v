`timescale 1ns/1ns
module test_vga();

/*
    This test bench checks for HSYNC and VSYNC timings
    and produces an output (vga.txt) which can be parsed by the VGA simulator (https://ericeastwood.com/lab/vga-simulator/).
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
reg ena;
wire n_rdy;
wire [3:0] color_out;
wire hsync_out, vsync_out;

reg [7:0] d_out;
assign #50 d = n_we ? 'hz : d_out;

vga inst(
    .n_rst(n_rst),
    .a(a),
    .d(d),
    .n_oe(n_oe),
    .n_we(n_we),
    .ena(ena),
    .n_rdy(n_rdy),
    .color_out(color_out),
    .hsync_out(hsync_out),
    .vsync_out(vsync_out));

integer last_hsync_down;
integer last_hsync_up;
initial begin
    last_hsync_up = 0;
    last_hsync_down = 0;
end
always @(negedge hsync_out) begin
    if (last_hsync_down > 40) begin
        // check v frame length: should be 800 * 40 nS
        if ($stime - last_hsync_down > 800 * 40 + 40) begin
            $display("H Frame is too long (down): %t", $stime - last_hsync_down);
            $fatal;
        end else if ($stime - last_hsync_down < 800 * 40 - 40) begin
            $display("H Frame is too short (down): %t", $stime - last_hsync_down);
            $fatal;
        end
    end
    if (last_hsync_up > 40) begin
        // should be 704 * 40 nS
        if ($stime - last_hsync_up > 704 * 40 + 40) begin
            $display("H up is too long: %t", $stime - last_hsync_up);
            $fatal;
        end else if ($stime - last_hsync_up < 704 * 40 - 40) begin
            $display("H up is too short: %t", $stime - last_hsync_up);
            $fatal;
        end
    end
    last_hsync_down = $time;
end
always @(posedge hsync_out) begin
    if (last_hsync_up > 40) begin
        // check v frame length: should be 800 * 40 nS
        if ($stime - last_hsync_up > 800 * 40 + 40) begin
            $display("H Frame is too long (up): %t", $stime - last_hsync_up);
            $fatal;
        end else if ($stime - last_hsync_up < 800 * 40 - 40) begin
            $display("H Frame is too short (up): %t", $stime - last_hsync_up);
            $fatal;
        end
    end
    if (last_hsync_down > 40) begin
        // should be 96 * 40 nS
        if ($stime - last_hsync_down > 96 * 40 + 40) begin
            $display("H down is too long: %t", $stime - last_hsync_down);
            $fatal;
        end else if ($stime - last_hsync_down < 96 * 40 - 40) begin
            $display("H down is too short: %t", $stime - last_hsync_down);
            $fatal;
        end
    end
    last_hsync_up = $time;
end


integer last_vsync_down;
integer last_vsync_up;
initial begin
    last_vsync_up = 0;
    last_vsync_down = 0;
end
always @(negedge vsync_out) begin
    if (last_vsync_down > 40) begin
        // check v frame length: should be 800 * 525 * 40 nS
        if ($stime - last_vsync_down > 800 * 525 * 40 + 40) begin
            $display("V Frame is too long (down): %t, should be 16800000", $stime - last_vsync_down);
            $fatal;
        end else if ($stime - last_vsync_down < 800 * 525 * 40 - 40) begin
            $display("V Frame is too short (down): %t, should be 16800000", $stime - last_vsync_down);
            $fatal;
        end
    end
    if (last_vsync_up > 40) begin
        // should be 800 * 523 * 40 nS
        if ($stime - last_vsync_up > 800 * 523 * 40 + 40) begin
            $display("V up is too long: %t, should be 16736000", $stime - last_vsync_up);
            $fatal;
        end else if ($stime - last_vsync_up < 800 * 523 * 40 - 40) begin
            $display("V up is too short: %t, should be 16736000", $stime - last_vsync_up);
            $fatal;
        end
    end
    last_vsync_down = $time;
end
always @(posedge vsync_out) begin
    if (last_vsync_up > 40) begin
        // check v frame length: should be 800 * 525 * 40 nS
        if ($stime - last_vsync_up > 800 * 525 * 40 + 160) begin
            $display("V Frame is too long (up): %t, should be 16800000", $stime - last_vsync_up);
            $fatal;
        end else if ($stime - last_vsync_up < 800 * 525 * 40 - 160) begin
            $display("V Frame is too short (up): %t, should be 16800000", $stime - last_vsync_up);
            $fatal;
        end
    end
    if (last_vsync_down > 40) begin
        // should be 800 * 2 * 40 nS
        // 0.5% tolerance = ±160 nS
        if ($stime - last_vsync_down > 800 * 2 * 40 + 160) begin
            $display("V down is too long: %t, should be 64000", $stime - last_vsync_down);
            $fatal;
        end else if ($stime - last_vsync_down < 800 * 2 * 40 - 160) begin
            $display("V down is too short: %t, should be 64000", $stime - last_vsync_down);
            $fatal;
        end
    end
    last_vsync_up = $time;
end

initial begin
    $dumpfile("test_vga.vcd");
    $dumpvars;
    n_rst = 0;
    a = 0;
    n_oe = 1;
    n_we = 1;
    ena = 1;
    d_out = 0;
    #1000

    n_rst = 1;
    #35000000;
    $finish;
end

integer fd;
initial begin
    fd = $fopen("vga.txt", "w");
    #105
    forever begin
        #40
        $fdisplay(fd, "%0t ns: %0b %0b %02b %02b %02b", $time, hsync_out, vsync_out, {color_out[3], color_out[2]}, {color_out[3], color_out[1]}, {color_out[3], color_out[0]});
    end
    $fclose(fd);
end

initial begin
    // write some values
    #10000
    ena = 1;
    a = 'he012;
    d_out = 74; // J
    n_we = 0;
    $display("writing text...");

    #500
    while (n_rdy) #500;
    n_we = 1;
    $display("written!");

    #3000
    a = 'hd015;
    d_out = 'h1f;
    n_we = 0;
    $display("writting color...");
    #500
    while (n_rdy) #500;
    n_we = 1;
    $display("written!");
end

endmodule
