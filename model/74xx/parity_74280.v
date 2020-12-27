module parity_74280(i, pe, po);
	input [8:0] i;
	output pe, po;

	assign #17 pe = ~^i;
	assign #3 po = ~pe;
endmodule
