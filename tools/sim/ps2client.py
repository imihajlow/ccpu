import simclient

mapping = {
    'q': [0x15],
    'w': [0x1d],
    'e': [0x24],
    'r': [0x2d],
    't': [0x2c],
    'y': [0x35],
    'u': [0x3c],
    'i': [0x43],
    'o': [0x44],
    'p': [0x4d],
    'a': [0x1c],
    's': [0x1b],
    'd': [0x23],
    'f': [0x2b],
    'g': [0x34],
    'h': [0x33],
    'j': [0x3b],
    'k': [0x42],
    'l': [0x4b],
    'z': [0x1a],
    'x': [0x22],
    'c': [0x21],
    'v': [0x2a],
    'b': [0x32],
    'n': [0x31],
    'm': [0x3a],
    '1': [0x16],
    '2': [0x1e],
    '3': [0x26],
    '4': [0x25],
    '5': [0x2e],
    '6': [0x36],
    '7': [0x3d],
    '8': [0x3e],
    '9': [0x46],
    'space': [0x29],
    'Tab': [0x0d],
    'Return': [0x5a],
    'section': [0x0e],
    'Escape': [0x76],
    'F1': [0x05],
    'F2': [0x06],
    'F3': [0x04],
    'F4': [0x0c],
    'F5': [0x03],
    'F6': [0x0b],
    'F7': [0x83],
    'F8': [0x05],
    'F9': [0x01],
    'F10': [0x09],
    'F11': [0x78],
    'F12': [0x07],
    'BackSpace': [0x66],
    'bracketleft': [0x54],
    'bracketright': [0x5b],
    'semicolon': [0x4c],
    'quoteright': [0x52],
    'comma': [0x41],
    'period': [0x49],
    'slash': [0x4a],
    'Left': [0xe0, 0x6b],
    'Right': [0xe0, 0x74],
    'Up': [0xe0, 0x75],
    'Down': [0xe0, 0x72],
}

DATA_ADDR = 0xfd00
CTRL_ADDR = 0xfd01

class Ps2Client(simclient.ISimClientListener, simclient.SimClient):
    def __init__(self, port):
        self._buffer = []
        simclient.SimClient.__init__(self, port, [(0xfd00,0xfd01)], self)

    def memSet(self, addr, value):
        if addr == CTRL_ADDR:
            if len(self._buffer) > 0:
                self._buffer = self._buffer[1:]
        elif addr == DATA_ADDR:
            print("Sending unsupported")

    def memGet(self, addr):
        if addr == DATA_ADDR:
            if len(self._buffer) > 0:
                return self._buffer[0]
            else:
                return 0x00
        elif addr == CTRL_ADDR:
            has_data = bool(len(self._buffer))
            recv_valid = True
            n_send_ack = False
            return int(has_data) | (int(recv_valid) << 1) | (int(n_send_ack) << 2)
        else:
            print(f"Wrong addr: 0x{addr:04X}")

    def simConnected(self):
        self._buffer.append(0xaa)

    def simDisconnected(self):
        pass

    def press(self, keysym):
        if keysym in mapping:
            m = mapping[keysym]
            for x in m:
                self._buffer.append(x)
        else:
            print(f"Unhandled key: {keysym}")

    def release(self, keysym):
        if keysym in mapping:
            m = mapping[keysym]
            if len(m) == 1:
                self._buffer.append(0xf0)
                self._buffer.append(m[0])
            elif len(m) == 2:
                self._buffer.append(m[0])
                self._buffer.append(0xf0)
                self._buffer.append(m[1])
            else:
                raise RuntimeError("Mapping is too long")
        else:
            print(f"Unhandled key: {keysym}")

    def getBufferString(self):
        r = " ".join(f"{c:02X}" for c in self._buffer[:10])
        if len(self._buffer) >= 10:
            r += '...'
        return r
