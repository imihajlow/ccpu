CCPU emulator
==============

An emulator with a gdb-like interface. Supports peripheral devices emulation: VGA, PS2, Card (limited support).

Usage
=====

Compile with `cargo build --release`.

`./target/release/rsim --help` to see command line help.

Plain mode means no IO, just the CPU and 64k bytes of flat memory. Web server is not started in this mode (nothing to show there).

To see the VGA output, it's necessary to supply the font file with the `--font` option.

Interactive mode commands:

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