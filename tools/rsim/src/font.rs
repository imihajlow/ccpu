use std::io;

pub struct Font {
    glyphs: [[u8; 16]; 0x100]
}

impl Font {
    pub fn load<T>(reader: &mut T) -> io::Result<Font>
    where T: io::Read {
        let mut r = Font { glyphs: [[0;16]; 0x100] };
        for i in 0..0x100 {
            reader.read_exact(&mut r.glyphs[i])?;
        }
        Ok(r)
    }

    pub fn render(&self, buf: &mut Vec<u8>, ch: u8, color: u8, c: u8, r: u8) {
        let glyph = &self.glyphs[ch as usize];
        let fg = color & 0xf;
        let bg = color >> 4;
        for y in 0..16 {
            let mask = glyph[y];
            for x in 0..4 {
                let offset = ((r as usize) * 16 + y) * 320 + (c as usize) * 4 + x;
                buf[offset] =
                    if mask & (1 << (2 * x + 1)) != 0 { fg } else { bg } |
                    ((if mask & (1 << (2 * x)) != 0 { fg } else { bg }) << 4);
            }
        }
    }
}
