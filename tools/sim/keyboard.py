from memory import MemoryModule

matrix = [
    ['f1', 'f2', 'hash', 'star'],
    ['1', '2', '3', 'up'],
    ['4', '5', '6', 'down'],
    ['7', '8', '9', 'escape'],
    ['left', '0', 'right', 'enter']
]
class Keyboard(MemoryModule):
    def __init__(self):
        self.value = 0x00
        self.pressed = None

    def isAddressHandled(self, a):
        return a == 0xff00

    def set(self, a, v):
        self.value = v

    def get(self, a):
        if self.pressed is None:
            return 0xff
        else:
            row, col = self.pressed
            if bool((1 << row) & self.value):
                return 0xff
            else:
                return ~(1 << col) & 0xff

    def press(self, key):
        for row in range(5):
            for col in range(4):
                if key == matrix[4 - row][3 - col]:
                    self.pressed = row, col
                    print(f"pressed {row}, {col}")
                    return
        print(f"Wrong key: {key}")

    def release(self):
        self.pressed = None
