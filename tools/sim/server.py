import threading
import queue
import socketserver
from memory import MemoryModule

class ConnectionHandler(socketserver.StreamRequestHandler, MemoryModule):
    def __init__(self, memory, factory, *args, **kwargs):
        self._mem = memory
        self._state = "init"
        self._cmdqueue = queue.Queue()
        self._rspqueue = queue.Queue()
        self._factory = factory
        super(socketserver.StreamRequestHandler, self).__init__(*args, **kwargs)

    def _register(self, l):
        ranges = l.split(',')
        self._ranges = []
        for r in ranges:
            ends = r.split('-')
            if len(ends) == 1:
                b = int(ends[0], 0)
                e = b
            else:
                b,e = [int(x, 0) for x in ends]
            self._ranges.append((b,e))
        print(f"ranges: {self._ranges}")
        self._mem.registerModule(self)

    def isAddressHandled(self, address):
        for b,e in self._ranges:
            if address >= b and address <= e:
                return True
        return False

    def set(self, address, value):
        self._cmdqueue.put(('set', address, value), block=False)

    def get(self, address):
        self._cmdqueue.put(('get', address), block=False)
        return self._rspqueue.get()

    def handle(self):
        print("new connection")
        self._factory.register(self)
        l = self.rfile.readline().strip()
        l = l.decode("utf-8")
        self._register(l)
        while True:
            t = self._cmdqueue.get()
            action = t[0]
            params = t[1:]
            if action == 'set':
                addr, value = params
                self.wfile.write(f"set {addr} {value}\n".encode('utf-8'))
                self.wfile.flush()
            elif action == 'get':
                addr = params[0]
                self.wfile.write(f"get {addr}\n".encode('utf-8'))
                self.wfile.flush()
                l = self.rfile.readline().strip()
                self._rspqueue.put(int(l, 0), block=False)
            elif action == 'stop':
                return

    def finish(self):
        print("finish")

    def stop_(self):
        print(f"stopping {self}")
        self._cmdqueue.put(("stop",""))

class ConnectionFactory:
    def __init__(self, memory):
        self._mem = memory
        self._handlers = []

    def __call__(self, *args, **kwargs):
        return ConnectionHandler(self._mem, self, *args, **kwargs)

    def register(self, h):
        self._handlers.append(h)

    def stop(self):
        print(f"stopping factory {len(self._handlers)}, {self}")
        for h in self._handlers:
            h.stop_()
        print("stopped")

class Server(threading.Thread):
    def __init__(self, port, memory):
        self._mem = memory
        self._port = port
        self._server = None
        self._factory = ConnectionFactory(self._mem)
        threading.Thread.__init__(self)

    def stop(self):
        self._factory.stop()
        self._server.shutdown()
        self.join()

    def run(self):
        self._server = socketserver.ThreadingTCPServer(('localhost', self._port), self._factory)
        self._server.serve_forever()

