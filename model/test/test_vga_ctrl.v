`timescale 1ns/1ns
module test_vga_ctrl();
task assert;
    input v;
    if (v !== 1'b1)
        $fatal;
endtask

reg n_rst;
reg [15:0] a;
reg n_we;
reg n_oe;
reg ena;

wire a_sel; // 0 - int, 1 - ext
wire n_text_ram_cs;
wire n_text_ram_oe;
wire n_text_ram_we;
wire n_d_to_text_oe;
wire n_color_ram_cs;
wire n_color_ram_oe;
wire n_color_ram_we;
wire n_d_to_color_oe;
wire n_pixel_ena;
wire hsync_out;
wire vsync_out;
reg [9:0] vy; // line number (total)
reg [9:0] hx;
wire n_rdy;
wire n_h_rst;
wire n_v_rst;

vga_ctrl inst(
    .a_sel(a_sel),
    .n_text_ram_cs(n_text_ram_cs),
    .n_text_ram_oe(n_text_ram_oe),
    .n_text_ram_we(n_text_ram_we),
    .n_d_to_text_oe(n_d_to_text_oe),
    .n_color_ram_cs(n_color_ram_cs),
    .n_color_ram_oe(n_color_ram_oe),
    .n_color_ram_we(n_color_ram_we),
    .n_d_to_color_oe(n_d_to_color_oe),
    .n_pixel_ena(n_pixel_ena),
    .hsync_out(hsync_out),
    .vsync_out(vsync_out),
    .vy(vy),
    .hx(hx),
    .n_rst(n_rst),
    .a(a),
    .n_we(n_we),
    .n_oe(n_oe),
    .n_rdy(n_rdy),
    .n_h_rst(n_h_rst),
    .n_v_rst(n_v_rst),
    .ena(ena));

always @(n_text_ram_we or n_text_ram_cs or a_sel) begin
    if (~a_sel) begin // internal counter on the address bus
        if (~n_text_ram_cs & ~n_text_ram_we) begin // write
            $display("Crap is written into text RAM");
            $fatal;
        end
    end
end

always @(n_color_ram_we or n_color_ram_cs or a_sel) begin
    if (~a_sel) begin // internal counter on the address bus
        if (~n_color_ram_cs & ~n_color_ram_we) begin // write
            $display("Crap is written into color RAM");
            $fatal;
        end
    end
end

wire n_x_ram_cswe = (n_text_ram_we | n_text_ram_cs) & (n_color_ram_we | n_color_ram_cs);
always @(negedge n_rdy) begin
    if (n_x_ram_cswe) begin
        $display("n_rdy is low before n_we and n_cs");
        $fatal;
    end
end

always @(posedge a_sel or negedge a_sel) begin
    if (~n_x_ram_cswe) begin
        $display("address transition during write");
        $fatal;
    end
end

integer i, j, k;
initial begin
    $dumpfile("test_vga_ctrl.vcd");
    $dumpvars;

    n_rst = 0;
    a = 0;
    n_we = 1;
    n_oe = 1;
    vy = 0;
    hx = 0;
    ena = 0;

    // test n_rst
    #40
    assert(n_h_rst === 0);
    assert(n_v_rst === 0);

    n_rst = 1;
    #40

    // V: 480 lines + 10 front + 2 sync + 33 back
    for (j = 0; j <= 480 + 10 + 2 + 33; j = j + 1) begin
        vy = j;
        // H: 96 sync + 48 back + 640 pixels + 16 front
        for (i = 0; i <= 96 + 48 + 640 + 16; i = i + 1) begin
            hx = i;
            #40
            if (j < 480) begin
                // visible area
                assert(vsync_out);
                assert(n_v_rst);
                if (i == 0) begin
                    // back porch, no memory access
                    assert(hsync_out);
                    assert(n_h_rst);
                    assert(n_rdy);
                    assert(n_pixel_ena);
                    assert(n_text_ram_cs);
                    assert(n_text_ram_oe);
                    assert(n_text_ram_we);
                    assert(n_color_ram_cs);
                    assert(n_color_ram_oe);
                    assert(n_color_ram_we);
                    assert(~n_d_to_text_oe);
                    assert(~n_d_to_color_oe);
                    assert(a_sel);
                end else if (i < 8) begin
                    // back porch and preload
                    assert(hsync_out);
                    assert(n_h_rst);
                    assert(n_rdy);
                    assert(n_pixel_ena);
                    assert(~n_text_ram_cs);
                    assert(~n_text_ram_oe);
                    assert(n_text_ram_we);
                    assert(~n_color_ram_cs);
                    assert(~n_color_ram_oe);
                    assert(n_color_ram_we);
                    assert(n_d_to_text_oe);
                    assert(n_d_to_color_oe);
                    assert(~a_sel);
                end else if (i < 640) begin
                    // pixel area and preload
                    assert(hsync_out);
                    assert(n_h_rst);
                    assert(n_rdy);
                    assert(~n_text_ram_cs);
                    assert(~n_text_ram_oe);
                    assert(n_text_ram_we);
                    assert(~n_color_ram_cs);
                    assert(~n_color_ram_oe);
                    assert(n_color_ram_we);
                    assert(n_d_to_text_oe);
                    assert(n_d_to_color_oe);
                    assert(~n_pixel_ena);
                    assert(~a_sel);
                end else if (i < 8 + 640) begin
                    // pixel area, no preload
                    assert(hsync_out);
                    assert(n_h_rst);
                    assert(n_rdy);
                    assert(n_text_ram_cs);
                    assert(n_text_ram_oe);
                    assert(n_text_ram_we);
                    assert(n_color_ram_cs);
                    assert(n_color_ram_oe);
                    assert(n_color_ram_we);
                    assert(~n_d_to_text_oe);
                    assert(~n_d_to_color_oe);
                    assert(~n_pixel_ena);
                    assert(a_sel);
                end else if (i < 8 + 640 + 16) begin
                    // front porch
                    assert(hsync_out);
                    assert(n_h_rst);
                    assert(n_rdy);
                    assert(n_text_ram_cs);
                    assert(n_text_ram_oe);
                    assert(n_text_ram_we);
                    assert(n_color_ram_cs);
                    assert(n_color_ram_oe);
                    assert(n_color_ram_we);
                    assert(~n_d_to_text_oe);
                    assert(~n_d_to_color_oe);
                    assert(n_pixel_ena);
                    assert(a_sel);
                end else if (i < 8 + 640 + 16 + 96) begin
                    // hsync
                    assert(~hsync_out);
                    assert(n_h_rst);
                    assert(n_rdy);
                    assert(n_text_ram_cs);
                    assert(n_text_ram_oe);
                    assert(n_text_ram_we);
                    assert(n_color_ram_cs);
                    assert(n_color_ram_oe);
                    assert(n_color_ram_we);
                    assert(~n_d_to_text_oe);
                    assert(~n_d_to_color_oe);
                    assert(n_pixel_ena);
                    assert(a_sel);
                end else if (i < 8 + 640 + 16 + 96 + 40) begin
                    // back porch before preload
                    assert(hsync_out);
                    assert(n_h_rst);
                    assert(n_rdy);
                    assert(n_text_ram_cs);
                    assert(n_text_ram_oe);
                    assert(n_text_ram_we);
                    assert(n_color_ram_cs);
                    assert(n_color_ram_oe);
                    assert(n_color_ram_we);
                    assert(~n_d_to_text_oe);
                    assert(~n_d_to_color_oe);
                    assert(n_pixel_ena);
                    assert(a_sel);
                end else if (i == 96 + 48 + 640 + 16) begin
                    // reset
                    assert(~n_h_rst);
                end
            end else if (j < 480 + 10 + 2 + 33) begin
                // v blank
                assert(n_v_rst);
                assert(vsync_out === ~((j >= 480 + 10) & (j < 480 + 10 + 2)));

                if (i < 96 + 48 + 640 + 16) begin
                    assert(hsync_out === ~(i >= 8 + 640 + 16 && i < 8 + 640 + 16 + 96));
                    assert(n_h_rst);
                    assert(n_rdy);
                    assert(n_text_ram_cs);
                    assert(n_text_ram_oe);
                    assert(n_text_ram_we);
                    assert(n_color_ram_cs);
                    assert(n_color_ram_oe);
                    assert(n_color_ram_we);
                    assert(~n_d_to_text_oe);
                    assert(~n_d_to_color_oe);
                    assert(n_pixel_ena);
                    assert(a_sel);
                    assert(n_h_rst);
                end else if (i == 96 + 48 + 640 + 16) begin
                    assert(~n_h_rst);
                end
            end else if (j == 480 + 10 + 2 + 33) begin
                // reset
                assert(~n_v_rst);
            end
        end // for i
    end // for j

    // Check memory access
    //
    n_we = 1'b0;
    a = 16'hd000;
    for (vy = 475; vy < 482; vy = vy) begin
        for (k = 0; k < 2; k = k + 1) begin
            ena = k;
            for (j = 0; j < 2; j = j + 1) begin
                a[12] = j[0];
                a[13] = ~j[0];
                if (vy < 480) begin
                    // inside visible area
                    // H: 96 sync + 48 back + 640 pixels + 16 front
                    for (i = 0; i <= 96 + 48 + 640 + 16; i = i + 1) begin
                        if (hx == 640 + 16) begin
                            vy = vy + 1;
                        end
                        hx = i;
                        // VGA timings are fine at this point (assuming they don't depend on the memory access)
                        // => no need to push for 40 nS memory access timings.
                        #60
                        assert(vsync_out);
                        assert(n_v_rst);
                        if (i == 0) begin
                            // back porch, no memory access
                            assert(hsync_out);
                            assert(n_h_rst);
                            assert(n_rdy);
                            assert(n_pixel_ena);
                            assert(n_text_ram_cs);
                            assert(n_text_ram_oe);
                            assert(n_text_ram_we);
                            assert(n_color_ram_cs);
                            assert(n_color_ram_oe);
                            assert(n_color_ram_we);
                            assert(~n_d_to_text_oe);
                            assert(~n_d_to_color_oe);
                            assert(a_sel);
                        end else if (i < 8) begin
                            // back porch and preload
                            assert(hsync_out);
                            assert(n_h_rst);
                            assert(n_rdy);
                            assert(n_pixel_ena);
                            assert(~n_text_ram_cs);
                            assert(~n_text_ram_oe);
                            assert(n_text_ram_we);
                            assert(~n_color_ram_cs);
                            assert(~n_color_ram_oe);
                            assert(n_color_ram_we);
                            assert(n_d_to_text_oe);
                            assert(n_d_to_color_oe);
                            assert(~a_sel);
                        end else if (i < 8 + 640 - 8) begin
                            // pixel area and preload
                            assert(hsync_out);
                            assert(n_h_rst);
                            assert(n_rdy);
                            assert(~n_text_ram_cs);
                            assert(~n_text_ram_oe);
                            assert(n_text_ram_we);
                            assert(~n_color_ram_cs);
                            assert(~n_color_ram_oe);
                            assert(n_color_ram_we);
                            assert(n_d_to_text_oe);
                            assert(n_d_to_color_oe);
                            assert(~n_pixel_ena);
                            assert(~a_sel);
                        end else if (i == 640) begin
                            // pixel area, no memory access
                            assert(hsync_out);
                            assert(n_h_rst);
                            assert(n_text_ram_cs);
                            assert(n_text_ram_oe);
                            assert(n_text_ram_we);
                            assert(n_color_ram_cs);
                            assert(n_color_ram_oe);
                            assert(n_color_ram_we);
                            assert(~n_d_to_text_oe);
                            assert(~n_d_to_color_oe);
                            assert(~n_pixel_ena);
                            assert(a_sel);
                        end else if (i < 8 + 640) begin
                            // pixel area, no preload
                            assert(hsync_out);
                            assert(n_h_rst);
                            assert(n_rdy === ~ena);
                            assert(n_text_ram_cs === j[0] | ~ena);
                            assert(n_text_ram_oe);
                            assert(n_text_ram_we === j[0] | ~ena);
                            assert(n_color_ram_cs === ~j[0] | ~ena);
                            assert(n_color_ram_oe);
                            assert(n_color_ram_we === ~j[0] | ~ena);
                            assert(~n_d_to_text_oe);
                            assert(~n_d_to_color_oe);
                            assert(~n_pixel_ena);
                            assert(a_sel);
                        end else if (i < 8 + 640 + 16) begin
                            // front porch
                            assert(hsync_out);
                            assert(n_h_rst);
                            assert(n_rdy === ~ena);
                            assert(n_text_ram_cs === j[0] | ~ena);
                            assert(n_text_ram_oe);
                            assert(n_text_ram_we === j[0] | ~ena);
                            assert(n_color_ram_cs === ~j[0] | ~ena);
                            assert(n_color_ram_oe);
                            assert(n_color_ram_we === ~j[0] | ~ena);
                            assert(~n_d_to_text_oe);
                            assert(~n_d_to_color_oe);
                            assert(n_pixel_ena);
                            assert(a_sel);
                        end else if (i < 8 + 640 + 16 + 96) begin
                            // hsync
                            assert(~hsync_out);
                            assert(n_h_rst);
                            assert(n_rdy === ~ena);
                            assert(n_text_ram_cs === j[0] | ~ena);
                            assert(n_text_ram_oe);
                            assert(n_text_ram_we === j[0] | ~ena);
                            assert(n_color_ram_cs === ~j[0] | ~ena);
                            assert(n_color_ram_oe);
                            assert(n_color_ram_we === ~j[0] | ~ena);
                            assert(~n_d_to_text_oe);
                            assert(~n_d_to_color_oe);
                            assert(n_pixel_ena);
                            assert(a_sel);
                        end else if (i < 8 + 640 + 16 + 96 + 40) begin
                            // back porch before preload
                            assert(hsync_out);
                            assert(n_h_rst);
                            assert(n_rdy === ~ena);
                            assert(n_text_ram_cs === j[0] | ~ena);
                            assert(n_text_ram_oe);
                            assert(n_text_ram_we === j[0] | ~ena);
                            assert(n_color_ram_cs === ~j[0] | ~ena);
                            assert(n_color_ram_oe);
                            assert(n_color_ram_we === ~j[0] | ~ena);
                            assert(~n_d_to_text_oe);
                            assert(~n_d_to_color_oe);
                            assert(n_pixel_ena);
                            assert(a_sel);
                        end else if (i == 96 + 48 + 640 + 16) begin
                            // reset
                            assert(~n_h_rst);
                        end
                    end // for i
                end else begin
                    // outside visible area
                    for (i = 0; i <= 96 + 48 + 640 + 16; i = i + 1) begin
                        hx = i;
                        if (hx == 640 + 16) begin
                            vy = vy + 1;
                        end
                        #40
                        // v blank
                        assert(n_v_rst);
                        assert(vsync_out);

                        if (i < 96 + 48 + 640 + 16) begin
                            #20 // more relaxed timing
                            assert(hsync_out === ~(i >= 8 + 640 + 16 && i < 8 + 640 + 16 + 96));
                            assert(n_h_rst);
                            assert(n_rdy === ~ena);
                            assert(n_text_ram_cs === j[0] | ~ena);
                            assert(n_text_ram_oe);
                            assert(n_text_ram_we === j[0] | ~ena);
                            assert(n_color_ram_cs === ~j[0] | ~ena);
                            assert(n_color_ram_oe);
                            assert(n_color_ram_we === ~j[0] | ~ena);
                            assert(~n_d_to_text_oe);
                            assert(~n_d_to_color_oe);
                            assert(n_pixel_ena);
                            assert(a_sel);
                        end else if (i == 96 + 48 + 640 + 16) begin
                            assert(~n_h_rst);
                        end
                    end // for i
                end // if
            end // for j
        end // for k
    end // for vx
end
endmodule
