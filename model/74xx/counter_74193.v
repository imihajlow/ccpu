`timescale 1ns/1ns
// https://www.ti.com/lit/ds/symlink/sn74hc193.pdf
module counter_74193
(
  input clr,
  input n_load,
  input up,
  input down,
  input [3:0] d,

  output [3:0] q,
  output n_co,
  output n_bo
);

reg [3:0] count = 0;
assign #5 n_co = ~((count == 4'b1111) & ~up);
assign #5 n_bo = ~((count == 4'b0000) & ~down);

always @(clr) begin
  if (clr)
  begin
    count <= 4'b0000;
  end
end

always @(n_load or d) begin
  if (~clr & ~n_load) begin
    count <= d;
  end
end

always @(posedge up)
begin
  if (~clr & n_load)
  begin
      count <= count + 1;
  end
end

always @(posedge down)
begin
  if (~clr & n_load)
  begin
      count <= count - 1;
  end
end

assign #5 q = count;

endmodule
