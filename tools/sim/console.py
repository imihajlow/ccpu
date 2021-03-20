#!/usr/bin/env python3
import argparse
import tkinter as tk

from vgacanvas import VgaCanvas
from vgaclient import VgaClient
from ps2client import Ps2Client

def click(e):
    vgaCanvas.update()

def update():
    vgaCanvas.update()
    ps2stringVar.set(ps2client.getBufferString())
    root.after(200, update)

def keydown(e):
    print(f"down {e.keysym}")
    ps2client.press(e.keysym)

def keyup(e):
    print(f"up {e.keysym}")
    ps2client.release(e.keysym)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='GUI console')
    parser.add_argument('-p', '--port', type=int, default=7002, help='TCP listen port')
    parser.add_argument('-f', '--font', required=True, help='font file')
    args = parser.parse_args()

    root = tk.Tk()
    root.bind("<KeyPress>", keydown)
    root.bind("<KeyRelease>", keyup)
    canvas = tk.Canvas(root, width=640, height=480)
    canvas.pack()
    ps2stringVar = tk.StringVar()
    ps2label = tk.Label(root, textvariable=ps2stringVar)
    ps2label.pack()

    vgaCanvas = VgaCanvas(canvas, args.font)
    vgaClient = VgaClient(args.port, vgaCanvas)
    vgaClient.start()

    ps2client = Ps2Client(args.port)
    ps2client.start()

    root.after(200, update)
    root.lift()
    root.mainloop()
