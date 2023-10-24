/* https://wavedrom.com/editor.html */
{signal: [
  {name: "n_tx_hold", wave: "1..............0..."},
  {name: "tx_cp_in", wave: "p..................", period: 0.5},
  {name: "tx_sck", wave: "1010101010101010..."},
  {name: "tx_mosi", wave: "2.2.2.2.2.2.2.2.0..", data: "b1023.0 b1023.1 b1023.2 b1023.3 b1023.4 b1023.5 b1023.6 b1023.7"},
  {name: "tx_shift_q7", wave: "22.2.2.2.2.2.2.0...", data: "..23.0 b1023.1 b1023.2 b1023.3 b1023.4 b1023.5 b1023.6 b1023.7"},
  {name: "n_tx_shift_pl", wave: "1..............0..."},
  {name: "tx_shift_cp", wave: "010101010101010...."},
  {name: "tx_byte_cnt", wave: "2..............2...", data: "1023 0"},
  {name: "tx_cnt", wave: "2222222222222222...", data: "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 0"},
],
  foot: {text:"Frame transmission end"},
  config: {hscale: 1},
}

