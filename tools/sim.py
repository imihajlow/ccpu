#!/usr/bin/env python3
import argparse
import re
import sys
import readline
from machine import Machine

def load(file):
    ba = file.read()
    if len(ba) != 32768:
        raise ValueError("Wrong program file size (must be 32768)")
    return list(ba)

def loadLabels(file):
    r = re.compile(r"(\w+)\s*=\s*0x([0-9a-f]+)", re.I)
    labels = {}
    for line in file:
        m = r.match(line)
        if m is None:
            raise ValueError("Map file error: '{}'".format(line))
        labels[m.group(1)] = int(m.group(2), 16)
    return labels

def loop(program, labels):
    m = Machine(program)
    while True:
        m.printState()
        line = input("> ")
        m.step()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Simulator')
    parser.add_argument('file', type=argparse.FileType("rb"), help='program file')
    parser.add_argument('mapfile', type=argparse.FileType("r"), help='label map file')
    args = parser.parse_args()

    # try:
    program = load(args.file)
    labels = loadLabels(args.mapfile)
    loop(program, labels)
    # except Exception as e:
    #     print(e)
    #     sys.exit(1)
