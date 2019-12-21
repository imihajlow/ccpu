// Purpose: 4 bit fully synchronous binary counter
// Western: 74LS163
// USSR: K555IE18/К555ИЕ18
module counter_74163
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

// localparam counter_74163 = 20; // Propagation delay from datasheet

reg overflow = 1'b0;
reg [3:0] count = 0;

always @(posedge clk or negedge clr_n)
begin
  if (~clr_n)
  begin
    count <= 4'b0000;
    overflow <= 1'b0;
  end
  else if (~load_n)
  begin
    count <= P;
    overflow <= 1'b0;
  end
  else if (enp & ent)
  begin
    count <= count + 1;
    overflow <= count[3] & count[2] & count[1] & ~count[0] & ent; // Counted till 14 ('b1110) and ent is active (high)
  end
end

assign Q = count;
assign rco = overflow;

endmodule
