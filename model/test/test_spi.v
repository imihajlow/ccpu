`timescale 1us/1ns
module test_spi();
task assert;
    input v;
    if (v !== 1'b1)
        $fatal;
endtask

parameter N=5;
reg [7:0] values_in[0:N-1];
reg [7:0] values_out[0:N-1];
integer i;

initial begin
	$dumpfile("test_spi.vcd");
	$dumpvars;
	values_in[0] = 8'h00;
	values_in[1] = 8'ha5;
	values_in[2] = 8'h88;
	values_in[3] = 8'h11;
	values_in[4] = 8'hb7;

	values_out[0] = 8'h30;
	values_out[1] = 8'hff;
	values_out[2] = 8'h55;
	values_out[3] = 8'haa;
	values_out[4] = 8'h92;
end

reg n_rst;
wire clk;
wire mosi;
wire miso;

wire n_rdy;
wire [7:0] d;
reg n_oe;
reg n_we;
reg n_sel;
spi inst(
	.d(d),
	.clk(clk),
	.mosi(mosi),
	.n_rdy(n_rdy),
	.n_rst(n_rst),
	.miso(miso),
	.n_oe(n_oe),
	.n_we(n_we),
	.n_sel(n_sel));

reg [7:0] d_in;
assign #0.1 d = n_we ? 8'bz : d_in;
initial begin
	n_rst = 0;
	n_oe = 1;
	n_we = 1;
	n_sel = 0;
end

integer current_index;
integer bit_index;
reg [7:0] input_reg;

initial begin
	bit_index = 7;
	current_index = 0;
end
always @(posedge clk) begin
	input_reg[bit_index] = mosi;
end
always @(negedge clk) begin
	bit_index = bit_index - 1;
	if (bit_index < 0) begin
		bit_index = 7;
		if (input_reg != values_in[current_index]) begin
			$display("invalid value received: @%0d %08b instead of %08b", current_index, input_reg, values_in[current_index]);
			$fatal;
		end
		current_index = current_index + 1;
	end
end

assign miso = values_out[current_index][bit_index];

initial begin
	#50
	n_rst = 1;
	bit_index = 7;

	for (i = 0; i < N; i = i + 1) begin
		d_in = values_in[i];
		n_oe = 1;
		n_we = 0;
		#1
		while (n_rdy) #1 ;
		n_we = 1;
		#1
		n_oe = 0;
		#1
		while (n_rdy) #1 ;
		#1
		if (d !== values_out[i]) begin
			$display("read wrong value from the bus: @%0d %08b instead of %08b", i, d, values_out[i]);
			$fatal;
		end

	end
	$finish;
end

initial begin
	#1000
	$display("timeout");
	$fatal;
end
endmodule
