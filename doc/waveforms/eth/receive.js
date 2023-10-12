/* https://wavedrom.com/editor.html */
{signal: [
  {name: "SDA", wave: "z222222222", data: [0,1,2,3,4,5,6,7,0], },
  {name: "SCK", wave: "0..HlHlHlHlHlHlHlHLH", node: "..................C", data: [], period: 0.5},
  {name: "data", wave: "x..2.2.2.2.2.2.2.7.2", period: 0.5},
  {name: "nWE", wave: "1................01.", node: ".................BD", period: 0.5, phase: -0.1},
  {name: "bit_count", wave: "2..2.2.2.2.2.2.2.2.2", data: [0,1,2,3,4,5,6,7,8,9], period: 0.5},
  {name: "bit_count[2]", wave: "0........1.......0..", node: ".................A", period: 0.5},
  {name: "byte_clk", wave: "0..........h.......L", period: 0.5},
  {name: "A", wave: "2..................2", data: [0, 1], period: 0.5},
],
  edge: ["A->B", "C->D"],
  config: {hscale: 2},
}

