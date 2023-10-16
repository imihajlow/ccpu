/* https://wavedrom.com/editor.html */
{signal: [
  {name: "nSS", wave: "10.|1|0|1|."},
  {name: "n_inhibit", wave: "1..|.|.|.|."},
  {name: "n_we", wave: "x.....|...|...|...|0Hx", period: 0.5},
  {name: "A", wave: "x.....|...|...|...|3.x", period: 0.5, data: ["0xFB00"]},
  {},
  {name: "sck_ena", wave: "1..|0|.|.|1"},
  {name: "n_recv_rst", wave: "1.....|...|...|...|01.", period: 0.5},
  {node: ".A..B.C.D"},
],
  edge: ["A+B frame received", "C+D frame dropped"],
  foot: {text: "Frame reception"},
  config: {hscale: 2},
}

