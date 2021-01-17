#!/usr/bin/env python3
import codecs
from memory import MemoryModule

VGA_WIDTH = 80
VGA_HEIGHT = 30

class VgaModule(MemoryModule):
    def __init__(self):
        self.colorRam = [0] * (128 * 32)
        self.textRam = [0] * (128 * 32)

    def isAddressHandled(self, address):
        return 0xd000 < address <= 0xefff

    def set(self, address, value):
        if address & 0xf000 == 0xd000:
            self.colorRam[address & 0x0fff] = value
        elif address & 0xf000 == 0xe000:
            self.textRam[address & 0x0fff] = value
        else:
            raise RuntimeError("Setting by an unhandled address")

    def get(self, address):
        if address & 0xf000 == 0xd000:
            return self.colorRam[address & 0x0fff]
        elif address & 0xf000 == 0xe000:
            return self.textRam[address & 0x0fff]
        else:
            raise RuntimeError("Getting by an unhandled address")

    def dump(self):
        for row in range(VGA_HEIGHT):
            print(decodeCp437(bytes(self.textRam[col + row * 128] for col in range(VGA_WIDTH))))

def decodeCp437(b):
    return codecs.decode(bytes(x if x >= 32 else 32 for x in b), encoding='cp437')
