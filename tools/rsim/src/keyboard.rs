use crate::config::KbConfig;
use crate::memory::{Memory, MemoryReadError, MemoryWriteError};

const KEYBOARD_ADDR: u16 = 0xFF00;

pub const KEY_F1: (u8, u8) = (4, 3);
pub const KEY_F2: (u8, u8) = (4, 2);
pub const KEY_HASH: (u8, u8) = (4, 1);
pub const KEY_STAR: (u8, u8) = (4, 0);

pub const KEY_1: (u8, u8) = (3, 3);
pub const KEY_2: (u8, u8) = (3, 2);
pub const KEY_3: (u8, u8) = (3, 1);
pub const KEY_UP: (u8, u8) = (3, 0);

pub const KEY_4: (u8, u8) = (2, 3);
pub const KEY_5: (u8, u8) = (2, 2);
pub const KEY_6: (u8, u8) = (2, 1);
pub const KEY_DOWN: (u8, u8) = (2, 0);

pub const KEY_7: (u8, u8) = (1, 3);
pub const KEY_8: (u8, u8) = (1, 2);
pub const KEY_9: (u8, u8) = (1, 1);
pub const KEY_ESCAPE: (u8, u8) = (1, 0);

pub const KEY_LEFT: (u8, u8) = (0, 3);
pub const KEY_0: (u8, u8) = (0, 2);
pub const KEY_RIGHT: (u8, u8) = (0, 1);
pub const KEY_ENTER: (u8, u8) = (0, 0);

pub struct Keyboard {
    pressed: Option<(u8, u8)>,
    row_mask: u8
}

impl Keyboard {
    pub fn new(config: &KbConfig) -> Option<Self> {
        match config {
            KbConfig::Absent => None,
            KbConfig::Present => Some(Keyboard {
                pressed: None,
                row_mask: 0xFF
            })
        }
    }

    pub fn press(&mut self, key: Option<(u8, u8)>) {
        self.pressed = key;
    }
}

impl Memory for Keyboard {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError> {
        if addr == KEYBOARD_ADDR {
            match self.pressed {
                None => Ok(0xFF),
                Some((row, col)) => {
                    if (self.row_mask & (1 << row)) == 0 {
                        Ok(!(1 << col))
                    } else {
                        Ok(0xFF)
                    }
                }
            }
        } else {
            Err(MemoryReadError::Empty)
        }
    }

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryWriteError> {
        if addr == KEYBOARD_ADDR {
            self.row_mask = value;
            Ok(())
        } else {
            Err(MemoryWriteError::Empty)
        }
    }
}
