CCPU emulator
==============

An emulator with a gdb-like interface. Supports peripheral devices emulation: VGA, PS2, Card (limited support).

Usage
=====

Install with `cargo install --path .`.

`rsim --help` to see command line help.

Configuration
=============

Configuration is in YAML format. Required entries:

* `mem: [plain|io-rev3]` - memory layout. Plain means 64kB of RAM (to use with unit tests). 

* `vga: [absent|font:<font path>]` - font file should be specified for a video card emulation to function.

* `keyboard: [absent|present]` - matrix keyboard.

* `ps2: [absent|present]`

* `spi: [absent|present]`

* `stack: [absent|present]`

* `server: [disabled|port:<port>]` - runs a webserver on the given port.


Interactive mode commands
=========================

* `r[un]` - run until Ctrl-C is pressed or a breakpoint is reached.

* `l` - run until next source code line.

* `u[ntil] <label>` - run until label/address is reached.

* `b[reak] <label>` - set a breakpoint.

* `d[elete] <number>` - delete a breakpoint.

* `p[rint] [<number>] [b|w|d] <label>` - print bytes/words/dwords starting at label. Examples:
- `p b main_i` - print one byte at address with a label ending with `main_i`
- `p 5 w 0x8322` - print five words starting at 0x8322.

* `n[ext]` - execute one instruction.

* `press [<key>]` - press a key on the matrix keyboard or release it if no key is given.

* `png <filename>` - save current VGA frame into PNG image.

* `insert <filename>` - attach a card image.

* `eject` - detach the card image.

* `q[uit]` - quit.

Pressing Enter on a blank line repeats last command. Commands `until` and `break` take also `<filename>:<line>` as an argument.
