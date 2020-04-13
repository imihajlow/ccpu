#!/usr/bin/env python3

class Keyboard:
    def __init__(self):
        self.value = 0x00
        self.pressed = None

    def write(self, v):
        self.value = v

    def read(self):
        if self.pressed is None:
            return 0xff
        else:
            row, col = self.pressed
            if bool((1 << row) & self.value):
                return 0xff
            else:
                return ~(1 << col) & 0xff

    def press(self, row, col):
        self.pressed = row, col

    def release(self):
        self.pressed = None
