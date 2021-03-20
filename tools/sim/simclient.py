import threading
import socket
from abc import ABC, abstractmethod

class ISimClientListener(ABC):
    @abstractmethod
    def memSet(self, address, value):
        pass

    @abstractmethod
    def memGet(self, address):
        return 0

    @abstractmethod
    def simConnected(self):
        pass

    @abstractmethod
    def simDisconnected(self):
        pass

class SimClient(threading.Thread):
    def __init__(self, port, addressRanges, listener):
        self._addressRanges = addressRanges
        self._listener = listener
        self._port = port
        threading.Thread.__init__(self)

    def run(self):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect(("localhost", self._port))
        print("connected")
        f = s.makefile("rw")
        print(f"ranges: {self._addressRanges}")
        f.write(",".join(f"{f}-{t}" for f,t in self._addressRanges) + "\n")
        f.flush()
        self._listener.simConnected()
        while True:
            l = f.readline()
            if len(l) == 0:
                break
            tokens = l.strip().split(" ")
            if tokens[0] == 'set':
                addr,value = [int(x, 0) for x in tokens[1:]]
                self._listener.memSet(addr, value)
            elif tokens[0] == 'get':
                addr = int(tokens[1], 0)
                v = self._listener.memGet(addr)
                f.write(f"{v}\n")
                f.flush()
        self._listener.simDisconnected()
