module uni_reg(
//output
			doa,
			dob,
			rco,
//input
			clk,
			rst,
			we,
			oea,
			oeb,
			cnt,
			di);
	input wire clk;
	input wire rst;
	input wire we;
	input wire oea;
	input wire oeb;
	input wire cnt;
	input wire [7:0] di;
	output tri [7:0] doa;
	output tri [7:0] dob;
	output wire rco;


	wire [3:0] cnt1_q;
	wire [3:0] cnt2_q;
	wire cnt1_rco;

	counter_74163 cnt1(.clk(clk), .clr_n(rst), .enp(cnt), .ent(cnt), .load_n(we), .P(di[3:0]), .Q(cnt1_q), .rco(cnt1_rco));
	counter_74163 cnt2(.clk(clk), .clr_n(rst), .enp(cnt), .ent(cnt1_rco), .load_n(we), .P(di[7:4]), .Q(cnt2_q), .rco(rco));

	wire [7:0] q = {cnt2_q, cnt1_q};
	assign doa = oea ? 8'bz : q;
	assign dob = oeb ? 8'bz : q;
endmodule
