module test_uni_reg();

	reg clk;
	reg rst;
	reg we;
	reg oea;
	reg oeb;
	reg [7:0] di;
	tri [7:0] doa;
	tri [7:0] dob;

	uni_reg inst(.doa(doa), .dob(dob),
	             .clk(clk), .rst(rst),
	             .we(we), .oea(oea), .oeb(oeb),
	             .di(di));

	task assert;
		input v;
		if (!v)
			$fatal;
	endtask

	initial begin
		$monitor("clk = %b, rst = %b, we = %b, oea = %b, oeb = %b, di = %h, doa = %h, dob = %h",
		         clk, rst, we, oea, oeb, di, doa, dob);
		clk = 1'b0;
		rst = 1'b1;
		we = 1'b1;
		oea = 1'b1;
		oeb = 1'b1;
		di = 8'h57;

		assert(doa == 8'hz);
		assert(dob == 8'hz);
		#1 clk = ~clk;
		#1 oea = 1'b0;
		assert(doa == 8'h0);
		#1 clk = ~clk;
		we = 1'b0;
		assert(doa == 8'h0);
		#1 clk = ~clk;
		#1
		assert(doa == 8'h57);
		assert(dob == 8'hz);
		#1 oeb = 1'b0;
		assert(dob == 8'h57);
		we = 1'b1;
	end
endmodule
