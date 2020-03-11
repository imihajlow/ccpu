#!/usr/bin/env python3

WATCH_READ = 1
WATCH_WRITE = 2

class Memory:
    def __init__(self, rom):
        self.memory = rom + [0] * (65536 - len(rom))
        self.verbose = False
        self.watches = []
        self.reachedWatch = None

    def setVerbose(self, verbose):
        self.verbose = verbose

    def set(self, address, value, watch=True):
        if self.verbose:
            print("[0x{:04X}] <- 0x{:02X}".format(address, value))
        self.memory[address] = value
        if watch:
            self.__checkWatch(address, WATCH_WRITE)

    def get(self, address):
        self.__checkWatch(address, WATCH_READ)
        return self.memory[address]

    def printValue(self, address, fmt):
        if fmt == 'b':
            value = self.memory[address]
            print("[0x{0:04X}] = 0x{1:02X} ({1})".format(address, value))
        if fmt == 'w':
            value = self.memory[address] | (self.memory[address + 1] << 8)
            print("[0x{0:04X}] = 0x{1:04X} ({1})".format(address, value))
        elif fmt == 'd':
            value = self.memory[address] | (self.memory[address + 1] << 8) | (self.memory[address + 2] << 16) | (self.memory[address + 3] << 24)
            print("[0x{0:04X}] = 0x{1:08X} ({1})".format(address, value))
        elif fmt == 'q':
            value = self.memory[address] | (self.memory[address + 1] << 8) | (self.memory[address + 2] << 16) | (self.memory[address + 3] << 24) \
                    | (self.memory[address + 4] << 32) | (self.memory[address + 5] << 40) | (self.memory[address + 6] << 48) | (self.memory[address + 7] << 56)
            print("[0x{0:04X}] = 0x{1:016X} ({1})".format(address, value))

    def watch(self, address, mode=WATCH_WRITE):
        self.watches += [(address, mode)]
        return len(self.watches) - 1

    def getReachedWatch(self):
        return self.reachedWatch

    def clearReachedWatch(self):
        self.reachedWatch = None

    def __checkWatch(self, address, mode):
        for i, (watchAddress, watchMode) in enumerate(self.watches):
            if address == watchAddress and bool(mode & watchMode):
                self.reachedWatch = i
                return
