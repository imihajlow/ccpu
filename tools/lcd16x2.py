#!/usr/bin/env python3

class Display:
    def __init__(self):
        self.text = [""]

    def writeCmd(self, v):
        if len(self.text[-1]) > 0:
            self.text += [""]

    def writeData(self, v):
        if 32 <= v < 128:
            self.text[-1] += chr(v)
        else:
            self.text[-1] += '?'

    def print(self):
        if len(self.text) > 1 or len(self.text[0]) > 1:
            print("New text:")
            for t in self.text:
                print(t)

    def resetText(self):
        self.text = [""]
