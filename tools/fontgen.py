#!/usr/bin/env python3
import argparse
import sys

def bit(c):
    return 1 if c == '#' else 0

def load(f):
    font = [0] * 16 * 256
    index = 0
    row = 0
    for line in f:
        line = line.strip()
        if line[0] == '-':
            if index != 0 and row != 16:
                raise RuntimeError(f"char {index}: wrong number of rows")
            tokens = line.split(' ')
            index = int(tokens[1])
            row = 0
        else:
            if len(line) != 8:
                raise RuntimeError(f"char {index}, row {row}: wrong length")
            b = sum(bit(c) * (1 << i) for i,c in enumerate(line))
            font[index * 16 + row] = b
            row += 1
    return font

def get_pixel(data, row, column):
    char_index = (row // 16) * 32 + column // 8
    byte_index = char_index * 16 + row % 16
    shift = column % 8
    return (data[byte_index] >> shift) & 1

def store(filename, data, mode):
    if mode == 'hex':
        with open(filename, "w") as f:
            for i, b in enumerate(data):
                f.write("{:02X}".format(b))
                if i % 16 == 15:
                    f.write("\n")
                else:
                    f.write(" ")
    elif mode == 'bin':
        b = data + [0] * (32768 - len(data))
        with open(filename, "wb") as f:
            f.write(bytearray(b))
    elif mode == 'png':
        import png
        with open(filename, "wb") as f:
            writer = png.Writer(width=32*8, height=16*8, greyscale=True, bitdepth=1)
            writer.write(f, [[get_pixel(data, row, column) for column in range(32 * 8)] for row in range(16 * 8)])

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generate font ROM')
    parser.add_argument('file', help='font description file', type=argparse.FileType("r"))
    parser.add_argument('output', help='result file name')
    parser.add_argument('--mode', help='output mode', choices=["bin", "hex", "png"], required=True)
    args = parser.parse_args()

    try:
        rom = load(args.file)
        store(args.output, rom, args.mode)
    except RuntimeError as e:
        print(str(e))
        sys.exit(1)

