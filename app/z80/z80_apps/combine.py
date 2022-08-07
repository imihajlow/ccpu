#!/usr/bin/env python3
import argparse
from intelhex import IntelHex

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Combine Z80 emulator and Z80 program')
    parser.add_argument('-o', metavar="RESULT", required=True, help='output file name')
    parser.add_argument('file', help='input file name')
    args = parser.parse_args()

    emu = IntelHex()
    emu.fromfile("../z80emu.bin", format="bin")
    program = IntelHex()
    program.fromfile(args.file, format="hex")
    emu.merge(program, overlap="error")
    emu.tobinfile(args.o)

