#!/usr/bin/env python3
import argparse
import tkinter as tk

from vgacanvas import VgaCanvas
from vgaclient import VgaClient



def click(e):
    vgaCanvas.update()

def update():
    vgaCanvas.update()
    root.after(200, update)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='GUI console')
    parser.add_argument('-p', '--port', type=int, default=7002, help='TCP listen port')
    parser.add_argument('-f', '--font', required=True, help='font file')
    args = parser.parse_args()

    root = tk.Tk()
    canvas = tk.Canvas(root, width=640, height=480)
    canvas.bind("<Button-1>", click)
    canvas.pack()
    vgaCanvas = VgaCanvas(canvas, args.font)
    vgaClient = VgaClient(args.port, vgaCanvas)
    vgaClient.start()
    root.after(200, update)
    root.mainloop()
