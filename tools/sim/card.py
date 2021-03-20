#!/usr/bin/env python3
import argparse
from cardclient import CardClient

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='GUI console')
    parser.add_argument('-p', '--port', type=int, default=7002, help='TCP listen port')
    parser.add_argument('img', help='memory card image')
    args = parser.parse_args()

    cc = CardClient(args.port, args.img)
    cc.start()
    while True:
        try:
            l = input("> ")
        except EOFError:
            break
        l = l.strip()
        if l == "insert":
            cc.insert()
        elif l == "eject":
            cc.eject()
        else:
            print("Possible commands: eject, insert")
