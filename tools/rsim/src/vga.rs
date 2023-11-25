use crate::config::VgaConfig;
use crate::font::Font;
use rand::{thread_rng, RngCore};
use crate::memory::{Memory, MemoryReadError, MemoryWriteError};
use std::io;
use png;
use itertools::concat;

const CHAR_SEG_ADDR: u16 = 0xE000;
const COLOR_SEG_ADDR: u16 = 0xD000;

pub struct Vga {
    char_seg: [u8; 0x1000],
    color_seg: [u8; 0x1000],
    font: Font
}

#[derive(Debug)]
pub enum RenderError {
    EncodingError(png::EncodingError),
}

impl From<png::EncodingError> for RenderError {
    fn from(e: png::EncodingError) -> Self {
        RenderError::EncodingError(e)
    }
}

impl Vga {
    pub fn new(config: &VgaConfig) -> std::io::Result<Option<Self>> {
        match config {
            VgaConfig::Absent => Ok(None),
            VgaConfig::PresentWithFontPath(path) => {
                let mut reader = std::fs::File::open(path)?;
                let mut r = Vga {
                    char_seg: [0; 0x1000],
                    color_seg: [0; 0x1000],
                    font: Font::load(&mut reader)?
                };
                thread_rng().fill_bytes(&mut r.char_seg);
                thread_rng().fill_bytes(&mut r.color_seg);
                Ok(Some(r))
            }
        }
    }

    pub fn create_image<W: io::Write>(&self, w: W) -> Result<(), RenderError> {
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
                self.font.render(&mut img_data, ch, color, c as u8, r as u8);
            }
        }

        writer.write_image_data(&img_data)?;
        Ok(())
    }

    pub fn render_to_buffer(&self, buf: &mut [u32]) {
        assert!(buf.len() == 640 * 480);
        for r in 0..30 {
            for c in 0..80 {
                let ch = self.char_seg[(r << 7) + c];
                let color = self.color_seg[(r << 7) + c];
                let fg_irgb = color & 0xf;
                let bg_irgb = color >> 4;
                let fg_rgba = irgb2rgba(fg_irgb);
                let bg_rgba = irgb2rgba(bg_irgb);
                self.font.render_rgba(buf, fg_rgba, bg_rgba, ch, c as u8, r as u8);
            }
        }
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

fn irgb2rgba(irgb: u8) -> u32 {
    let i = (irgb & 8 != 0) as u8;
    let r = (irgb & 4 != 0) as u8;
    let g = (irgb & 2 != 0) as u8;
    let b = (irgb & 1 != 0) as u8;
    let b = [i * 0xaa + b * 0x55, i * 0xaa + g * 0x55, i * 0xaa + r * 0x55, 0];
    u32::from_le_bytes(b)
}
