import simclient
import random
from abc import ABC, abstractmethod

CHAR_RAM_ADDRESS = 0xE000
COLOR_RAM_ADDRESS = 0xD000

class IVgaCanvas(ABC):
    @abstractmethod
    def renderChar(self, col, row, char, color):
        pass

class VgaClient(simclient.ISimClientListener, simclient.SimClient):
    def __init__(self, port, canvas):
        self._charRam = [random.randrange(256) for _ in range(4096)]
        self._colorRam = [random.randrange(256) for _ in range(4096)]
        self._canvas = canvas
        ranges = [(CHAR_RAM_ADDRESS, CHAR_RAM_ADDRESS + 0xFFF), (COLOR_RAM_ADDRESS, COLOR_RAM_ADDRESS + 0xFFF)]
        simclient.SimClient.__init__(self, port, ranges, self)

    def memSet(self, address, value):
        offset = address & 0xFFF
        row = offset >> 7
        col = offset & 0x7F
        if address & 0xF000 == CHAR_RAM_ADDRESS:
            ram = self._charRam
        elif address & 0xF000 == COLOR_RAM_ADDRESS:
            ram = self._colorRam
        else:
            raise ValueError("Unhandled address")
        ram[offset] = value
        self._canvas.renderChar(col, row, self._charRam[offset], self._colorRam[offset])
        # self._canvas.update()

    def memGet(self, address):
        return random.randrange(256)

    def simConnected(self):
        print("VGA connected")
        for row in range(30):
            for col in range(80):
                offset = (row << 7) | col
                self._canvas.renderChar(col, row, self._charRam[offset], self._colorRam[offset])
        # self._canvas.update()

    def simDisconnected(self):
        print("VGA disconnected")
