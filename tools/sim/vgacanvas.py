from vgaclient import IVgaCanvas
from PIL import Image, ImageTk

def component(i, c):
    return int(i) * 0x55 + int(c) * 0xaa

def genPalette():
    for block in range(16):
        for irgb in range(16):
            i = bool(irgb & 8)
            r = bool(irgb & 4)
            g = bool(irgb & 2)
            b = bool(irgb & 1)
            yield component(i, r)
            yield component(i, g)
            yield component(i, b)

class Glyph:
    def __init__(self, data):
        self._data = data

    def render(self, img, x, y, color):
        fg = color & 0xf
        bg = color >> 4
        for r in range(16):
            row = self._data[r]
            for c in range(8):
                bit = bool((row >> c) & 1)
                img.putpixel((x + c, y + r), fg if bit else bg)


class VgaCanvas(IVgaCanvas):
    def __init__(self, canvas, fontFile):
        self._glyphs = []
        self._canvas = canvas
        self._imgId = None
        self._img = Image.new("P", (640,480))
        self._img.putpalette(list(genPalette()))
        with open(fontFile, "rb") as f:
            while True:
                d = f.read(16)
                if len(d) != 16:
                    break
                self._glyphs.append(Glyph(d))

    def renderChar(self, col, row, char, color):
        x = col * 8
        y = row * 16
        self._glyphs[char].render(self._img, x, y, color)

    def update(self):
        phi = ImageTk.PhotoImage(self._img)
        if self._imgId is not None:
            self._canvas.itemconfig(self._imgId, image=phi)
        else:
            self._imgId = self._canvas.create_image(320, 240, image=phi)
        self._phi = phi
        # self._canvas.update()
