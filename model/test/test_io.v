`timescale 1us/1ns
module test_io();
task assert;
    input v;
    if (v !== 1'b1)
        $fatal;
endtask

reg [15:0] a;
reg n_oe;
reg n_we;
wire n_rdy;

wire n_rom_cs;
wire n_raml_cs;
wire n_ramh_cs;

wire n_kb_oe;
wire kb_cp;
wire cr_cp;
wire lcd_e;

wire [7:0] cr;

reg raml_ena;
reg [4:0] n_ram_x_ena;
wire ram_a_ena = n_ram_x_ena[0];
wire ram_b_ena = n_ram_x_ena[1];
wire ram_c_ena = n_ram_x_ena[2];
wire ram_d_ena = n_ram_x_ena[3];
wire ram_e_ena = n_ram_x_ena[4];

assign cr = {n_ram_x_ena, 2'b0, raml_ena};

io inst(
    .n_rdy(n_rdy),
    .n_rom_cs(n_rom_cs),
    .n_raml_cs(n_raml_cs),
    .n_ramh_cs(n_ramh_cs),
    .n_kb_oe(n_kb_oe),
    .kb_cp(kb_cp),
    .cr_cp(cr_cp),
    .lcd_e(lcd_e),
    .a(a),
    .n_oe(n_oe),
    .n_we(n_we),
    .cr(cr));

integer i, j, k, l;

initial begin
    $dumpfile("test_io.vcd");
    $dumpvars;

    a = 16'h0000;
    n_oe = 1;
    n_we = 1;
    raml_ena = 0;

    for (l = 0; l < 2; l = l + 1) begin
        raml_ena = l;
        for (k = 0; k < 3; k = k + 1) begin
            if (k == 0) begin
                n_oe = 1;
                n_we = 1;
            end else if (k == 1) begin
                n_oe = 0;
                n_we = 1;
            end else begin
                n_oe = 1;
                n_we = 0;
            end
            for (j = 0; j < 32; j = j + 1) begin
                n_ram_x_ena = j;
                for (i = 'h0000; i < 'h10000; i = i + 1) begin
                    a = i;
                    #1
                    if (i < 'h8000) begin
                        assert(~n_rdy);
                        assert(n_rom_cs === raml_ena);
                        assert(n_raml_cs === ~raml_ena);
                        assert(n_ramh_cs);
                        assert(n_kb_oe);
                        assert(kb_cp);
                        assert(cr_cp);
                        assert(~lcd_e);
                    end else if (i < 'ha000) begin
                        assert(~n_rdy);
                        assert(n_rom_cs);
                        assert(n_raml_cs);
                        assert(~n_ramh_cs);
                        assert(n_kb_oe);
                        assert(kb_cp);
                        assert(cr_cp);
                        assert(~lcd_e);
                    end else if (i < 'hb000) begin
                        assert(n_rdy === ~ram_a_ena);
                        assert(n_rom_cs);
                        assert(n_raml_cs);
                        assert(n_ramh_cs === ~ram_a_ena);
                        assert(n_kb_oe);
                        assert(kb_cp);
                        assert(cr_cp);
                        assert(~lcd_e);
                    end else if (i < 'hc000) begin
                        assert(n_rdy === ~ram_b_ena);
                        assert(n_rom_cs);
                        assert(n_raml_cs);
                        assert(n_ramh_cs === ~ram_b_ena);
                        assert(n_kb_oe);
                        assert(kb_cp);
                        assert(cr_cp);
                        assert(~lcd_e);
                    end else if (i < 'hd000) begin
                        assert(n_rdy === ~ram_c_ena);
                        assert(n_rom_cs);
                        assert(n_raml_cs);
                        assert(n_ramh_cs === ~ram_c_ena);
                        assert(n_kb_oe);
                        assert(kb_cp);
                        assert(cr_cp);
                        assert(~lcd_e);
                    end else if (i < 'he000) begin
                        assert(n_rdy === ~ram_d_ena);
                        assert(n_rom_cs);
                        assert(n_raml_cs);
                        assert(n_ramh_cs === ~ram_d_ena);
                        assert(n_kb_oe);
                        assert(kb_cp);
                        assert(cr_cp);
                        assert(~lcd_e);
                    end else if (i < 'hf000) begin
                        assert(n_rdy === ~ram_e_ena);
                        assert(n_rom_cs);
                        assert(n_raml_cs);
                        assert(n_ramh_cs === ~ram_e_ena);
                        assert(n_kb_oe);
                        assert(kb_cp);
                        assert(cr_cp);
                        assert(~lcd_e);
                    end else if (i >= 'hff00) begin
                        // internal IO area
                        assert(n_rom_cs);
                        assert(n_raml_cs);
                        assert(n_ramh_cs);
                        if ((i & 'h6) === 0) begin
                            // keyboard: 0xffx0 or 0xffx1
                            assert(~n_rdy);
                            assert(n_kb_oe === n_oe);
                            assert(kb_cp === n_we);
                            assert(cr_cp);
                            assert(~lcd_e);
                        end else if ((i & 'h6) === 2) begin
                            // LCD: 0xffx2 and 0xffx3
                            assert(~n_rdy);
                            assert(n_kb_oe);
                            assert(kb_cp);
                            assert(cr_cp);
                            assert(lcd_e === ~n_we);
                        end else if ((i & 'h6) === 4) begin
                            // CR: 0xffx4 or 0xffx5
                            assert(~n_rdy);
                            assert(n_kb_oe);
                            assert(kb_cp);
                            assert(cr_cp === n_we);
                            assert(~lcd_e);
                        end else begin
                            assert(~n_rdy);
                            assert(n_kb_oe);
                            assert(kb_cp);
                            assert(cr_cp);
                            assert(~lcd_e);
                        end
                    end else begin
                        // 0xf000 - 0xfeff - empty
                        assert(n_rdy);
                        assert(n_rom_cs);
                        assert(n_raml_cs);
                        assert(n_ramh_cs);
                        assert(n_kb_oe);
                        assert(kb_cp);
                        assert(cr_cp);
                        assert(~lcd_e);
                    end
                end // for i
            end // for j
        end // for k
    end // for l
end // initial

endmodule
