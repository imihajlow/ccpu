#!/usr/bin/env python3
import argparse

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Flip bits 6 and 7 of every byte in the file')
    parser.add_argument('file', help='file name')
    args = parser.parse_args()
    a = None
    with open(args.file, "rb") as f:
        a = list(f.read())
    for i,x in enumerate(a):
        a[i] = (x & 0x3f) | ((x & 0x40) << 1) | ((x & 0x80) >> 1)
    with open(args.file, "wb") as f:
        f.write(bytearray(a))
