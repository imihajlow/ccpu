use rand::{thread_rng, RngCore};
use crate::memory::{Memory, MemoryReadError, MemoryWriteError};
use std::io;
use std::ops::Index;
use png;
use itertools::concat;

const CHAR_SEG_ADDR: u16 = 0xE000;
const COLOR_SEG_ADDR: u16 = 0xD000;

pub struct Vga {
    char_seg: [u8; 0x1000],
    color_seg: [u8; 0x1000],
    font: Option<Font>
}

struct Font {
    glyphs: [[u8; 16]; 0x100]
}

#[derive(Debug)]
pub enum RenderError {
    EncodingError(png::EncodingError),
    NoFont
}

impl From<png::EncodingError> for RenderError {
    fn from(e: png::EncodingError) -> Self {
        RenderError::EncodingError(e)
    }
}

impl Font {
    fn load<T>(reader: &mut T) -> io::Result<Font>
    where T: io::Read {
        let mut r = Font { glyphs: [[0;16]; 0x100] };
        for i in 0..0x100 {
            reader.read_exact(&mut r.glyphs[i])?;
        }
        Ok(r)
    }

    fn render(&self, buf: &mut Vec<u8>, ch: u8, color: u8, c: u8, r: u8) {
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

impl Vga {
    pub fn new<T>(font_file: &mut Option<T>) -> io::Result<Self>
    where T: io::Read {
        let mut r = Vga {
            char_seg: [0; 0x1000],
            color_seg: [0; 0x1000],
            font: match font_file {
                None => None,
                Some(ref mut r) => Some(Font::load(r)?)
            }
        };
        thread_rng().fill_bytes(&mut r.char_seg);
        thread_rng().fill_bytes(&mut r.color_seg);
        Ok(r)
    }

    pub fn create_image<W: io::Write>(&self, w: W) -> Result<(), RenderError> {
        let font = match self.font {
            None => return Err(RenderError::NoFont),
            Some(ref f) => f
        };
        let mut encoder = png::Encoder::new(w, 640, 480);
        encoder.set_color(png::ColorType::Indexed);
        encoder.set_depth(png::BitDepth::Four);
        encoder.set_palette(
            concat(
                (0..16)
                .map(|irgb| (irgb & 8 != 0, irgb & 4 != 0, irgb & 2 != 0, irgb & 1 != 0))
                .map(|(i,r,g,b)| (i as u8, r as u8, g as u8, b as u8))
                .map(|(i,r,g,b)| vec![i * 0xaa + r * 0x55, i * 0xaa + g * 0x55, i * 0xaa + b * 0x55])
            )
        );
        let mut writer = encoder.write_header()?;

        let size = 320 * 480;
        let mut img_data: Vec<u8> = Vec::with_capacity(size);
        unsafe { img_data.set_len(size); }
        for r in 0..30 {
            for c in 0..80 {
                let ch = self.char_seg[(r << 7) + c];
                let color = self.color_seg[(r << 7) + c];
                font.render(&mut img_data, ch, color, c as u8, r as u8);
            }
        }

        writer.write_image_data(&img_data)?;
        Ok(())
    }
}

impl Memory for Vga {
    fn get(&self, _addr: u16) -> Result<u8, MemoryReadError> {
        Err(MemoryReadError::Empty)
    }

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryWriteError> {
        match addr & 0xF000 {
            CHAR_SEG_ADDR => {
                self.char_seg[(addr - CHAR_SEG_ADDR) as usize] = value;
                Ok(())
            }
            COLOR_SEG_ADDR => {
                self.color_seg[(addr - COLOR_SEG_ADDR) as usize] = value;
                Ok(())
            }
            _ => Err(MemoryWriteError::Empty)
        }
    }
}
