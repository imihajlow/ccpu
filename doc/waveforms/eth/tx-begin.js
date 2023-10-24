/* https://wavedrom.com/editor.html */
{signal: [
  {name: "n_tx_req", wave: "10..1.........................."},
  {name: "n_tx_hold", wave: "0...1.........................."},
  {name: "tx_cp_in", wave: "p..............................", period: 0.5},
  {name: "tx_oe", wave: "0..................1..........."},
  {name: "tx_sck", wave: "0...................10101010101"},
  {name: "tx_mosi", wave: "0...................2.2.2.2.2.2", data: "b0.0 b0.1 b0.2 b0.3 b0.4 b0.5 b0.6 b0.7 b1.0 b1.1"},
  {name: "tx_shift_q7", wave: "0..2.2.2.2.2.2.2.2.2.2.2.2.2.2.", data: "x.0 x.1 x.2 x.3 x.4 x.5 x.6 x.7 b0.0 b0.1 b0.2 b0.3 b0.4 b0.5"},
  {name: "tx_buf_d", wave: "x..........2...............2...", data: "b0 b1"},
  {name: "n_tx_shift_pl", wave: "1..01..............01.........."},
  {name: "tx_shift_cp", wave: "0..1010101010101010101010101010"},
  {name: "tx_byte_cnt", wave: "x..2...............2...........", data: "0 1"},
  {name: "tx_cnt", wave: "x..2222222222222222222222222222", data: "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 0 1 2 3 4 5 6 7 8 9 10 11"},
],
  foot: {text:"Frame transmission begin"},
  config: {hscale: 1},
}

