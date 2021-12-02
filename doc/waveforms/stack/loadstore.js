/* https://wavedrom.com/editor.html */
{signal: [
  {name: "n_we", wave: "x.10x..1.x."},
  {name: "n_oe", wave: "x.1.x..0.x."},
  {name: "a", wave: "x.3.x..3.x.", data: "FC00 FC00"},
  {name: "d", wave: "x..3x..z.x.", data: "X"},
  {name: "n_sel", wave: "1.0.1..0.1.", data: "FC00 FC00"},
  {},
  {name: "n_load", wave: "1..01......"},
  {name: "up", wave: "1.........."},
  {name: "down", wave: "1.........."},
  {name: "n_oe_d", wave: "1......0.1."},
  {name: "n_oe_ai", wave: "1.........."},
],
  config: {hscale: 1},
  head: {text: "Stack pointer load/store"}
}
