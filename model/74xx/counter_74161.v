`timescale 1ns/1ps
module counter_74161
(
  input clk,
  input clr_n,
  input enp,
  input ent,
  input load_n,
  input [3:0] P,   // 4-bit parallel input

  output [3:0] Q,  // Parallel outputs
  output rco
);

reg [3:0] count = 0;
wire overflow;
assign #10 overflow = count[3] & count[2] & count[1] & count[0] & ent;

always @(posedge clk or negedge clr_n)
begin
  if (~clr_n)
  begin
    count <= #26 4'b0000;
  end
  else if (~load_n)
  begin
    count <= #15 P;
  end
  else if (enp & ent)
  begin
    count <= #15 count + 1;
  end
end

assign Q = count;
assign rco = overflow;

endmodule
