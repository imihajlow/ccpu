/* https://wavedrom.com/editor.html */
{signal: [
  {name: "nSS", wave: "10...|1"},
  {name: "byte_count", wave: "2..222222x|x..", data: [0,1,2,3,4,5,6], period: 0.5},
  {name: "mac_ok", wave: "x.......0x.|..", period: 0.5, phase: 0.5},
  {name: "n_check_mac", wave: "0.......1.|0..", period: 0.5, phase: 0},
  {name: "n_recv_rst", wave: "1...0|1"},
  {name: "recv_ena", wave: "1....|."},
  {name: "mac_ok", wave: "1...0|1"},
  {name: "data_rdy", wave: "0....|."},
],
  foot: {text:"Frame filter - wrong MAC"},
  config: {hscale: 2},
}

