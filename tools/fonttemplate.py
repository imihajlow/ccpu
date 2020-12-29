#!/usr/bin/env python3
import argparse

def char(x):
    return chr(x) if 32 < x < 128 else ''

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate template font description file')
    parser.add_argument('output', help='result file name', type=argparse.FileType("w"))
    args = parser.parse_args()
    for i in range(256):
        print(f"-- {i} (0x{i:02x}) {char(i)}", file=args.output)
        for line in range(16):
            print("." * 8, file=args.output)
