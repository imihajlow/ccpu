#!/usr/bin/env python3
import argparse
from intelhex import IntelHex

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Convert Intel Hex to binary')
    parser.add_argument('-o', metavar="RESULT", required=True, help='output file name')
    parser.add_argument('file', help='input file name')
    args = parser.parse_args()

    program = IntelHex()
    program.fromfile(args.file, format="hex")
    program.tobinfile(args.o)

