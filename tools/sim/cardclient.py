import simclient

DATA_ADDR = 0xfd02
CTRL_ADDR = 0xfd03

R1_IDLE = 1
R1_READY = 0
class CardClient(simclient.ISimClientListener, simclient.SimClient):
    def __init__(self, port, img):
        self._buffer = []
        self.n_cs = False
        self.power = False
        self.data = 0
        self.inserted = False
        self.writeProtect = False
        self._file = open(img, "r+b")
        self._state = "idle"
        self._initialized = False
        self._acmd = False
        simclient.SimClient.__init__(self, port, [(0xfd02,0xfd03)], self)

    def memSet(self, addr, value):
        if addr == CTRL_ADDR:
            self.n_cs = bool(value & 4)
            self.power = bool(value & 8)
            if not self.power:
                self._initialized = False
                self._acmd = False
        elif addr == DATA_ADDR:
            if self.inserted and self.power and not self.n_cs:
                self.data = self.processData(value)
            else:
                self.data = 0xff

    def memGet(self, addr):
        if addr == DATA_ADDR:
            return self.data
        elif addr == CTRL_ADDR:
            return int(not self.inserted) | (int(self.writeProtect) << 1)
        else:
            print(f"Wrong addr: 0x{addr:04X}")

    def simConnected(self):
        pass

    def simDisconnected(self):
        pass

    def insert(self):
        self.inserted = True

    def eject(self):
        self.inserted = False
        self._initialized = False
        self._acmd = False

    def processData(self, value):
        if self._state == "idle":
            if value != 0xff:
                self._cmdData = [value]
                self._state = "cmd"
        elif self._state == "cmd":
            self._cmdData.append(value)
            if len(self._cmdData) == 6:
                self._state = "rsp"
        elif self._state == "rsp":
            cmd = self._cmdData[0]
            result = 0xff
            self._state = "idle"
            if not self._acmd:
                if cmd == (0x40 | 0):
                    print("CMD0")
                    self._initialized = False
                    result = R1_IDLE
                elif cmd == (0x40 | 55):
                    print("CMD55")
                    self._acmd = True
                    result = R1_READY if self._initialized else R1_IDLE
                elif cmd == (0x40 | 17):
                    print("CMD17")
                    offset = 0
                    for i in range(1,5):
                        offset <<= 8
                        offset |= self._cmdData[i]
                    print(f"Reading block from offset 0x{offset:08X}")
                    if not self._initialized:
                        result = R1_IDLE
                    addr = self._file.seek(offset, 0)
                    self._busyCnt = 3
                    if addr == offset:
                        self._state = "read_begin"
                        self._block = self._file.read(512)
                        result = R1_READY
                    else:
                        print(f"Out of range")
                        self._state = "oor"
                        result = R1_READY
                else:
                    print(f"Wrong CMD: {cmd}")
            else:
                if cmd == (0x40 | 41):
                    print("ACMD41")
                    self._initialized = True
                    self._acmd = False
                    result = R1_READY
                else:
                    print(f"Wrong ACMD: {cmd}")
                self._acmd = False
            return result
        elif self._state == "oor":
            if self._busyCnt == 0:
                return 0x81
            else:
                self._busyCnt -= 1
                return 0xff
        elif self._state == "read_begin":
            if self._busyCnt == 0:
                self._state = "read"
                self._readIndex = 0
                return 0xfe
            else:
                self._busyCnt -= 1
                return 0xff
        elif self._state == "read":
            v = self._block[self._readIndex]
            self._readIndex += 1
            if self._readIndex == 512:
                self._state = "read_crc1"
            return v
        elif self._state == "read_crc1":
            self._state = "read_crc2"
            return 0xff
        elif self._state == "read_crc2":
            self._state = "idle"
            return 0xff
        else:
            print("Card state error")
        return 0xff
