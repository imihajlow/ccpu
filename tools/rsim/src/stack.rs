use crate::memory::MemoryReadError;
use crate::memory::MemoryWriteError;
use crate::memory::Memory;
use crate::config::StackConfig;

const SP0_ADDR: u16 = 0xFC00;
const SP1_ADDR: u16 = 0xFC01;
const INCDEC_ADDR: u16 = 0xFC02;
const ENA_ADDR: u16 = 0xFC03;

const FRAME_BASE: u16 = 0xC000;

const FRAME_SIZE: u16 = 0x0800;

const INC_0: u8 = 1;
const INC_1: u8 = 2;
const DEC_0: u8 = 4;
const DEC_1: u8 = 8;

const ENABLE: u8 = 1;

pub struct Stack {
    enabled: bool,
    sp0: u8,
    sp1: u8,
    ram: [u8; 256 * (FRAME_SIZE as usize)]
}

impl Stack {
    pub fn new(config: &StackConfig) -> Option<Self> {
        match config {
            StackConfig::Absent => None,
            StackConfig::Present => Some(Self {
                enabled: false,
                sp0: 0,
                sp1: 1,
                ram: [0; 256 * 2048]
            })
        }
    }

    fn translate_addr(&self, addr: u16) -> usize {
        let frame = (addr & 0x0800) != 0;
        let offset = addr & 0x07FF;
        let sp = match frame {
            false => self.sp0,
            true => self.sp1
        };
        ((sp as usize) << 11) | (offset as usize)
    }
}

impl Memory for Stack {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError> {
        match addr {
            SP0_ADDR => Ok(self.sp0),
            SP1_ADDR => Ok(self.sp1),
            x if x >= FRAME_BASE && x < FRAME_BASE + 2 * FRAME_SIZE => {
                if self.enabled {
                    Ok(self.ram[self.translate_addr(addr)])
                } else {
                    Err(MemoryReadError::Empty)
                }
            },
            _ => Err(MemoryReadError::Empty)
        }
    }

    fn set(&mut self, addr: u16, val: u8) -> Result<(), MemoryWriteError> {
        match addr {
            SP0_ADDR => {
                self.sp0 = val;
                Ok(())
            }
            SP1_ADDR => {
                self.sp1 = val;
                Ok(())
            }
            INCDEC_ADDR => {
                let inc_0 = (val & INC_0) != 0;
                let inc_1 = (val & INC_1) != 0;
                let dec_0 = (val & DEC_0) != 0;
                let dec_1 = (val & DEC_1) != 0;
                let other_bits = (val & !(INC_0 | INC_1 | DEC_0 | DEC_1)) != 0;
                if other_bits {
                    return Err(MemoryWriteError::InvalidValue);
                }
                if inc_0 && dec_0 {
                    return Err(MemoryWriteError::InvalidValue);
                }
                if inc_1 && dec_1 {
                    return Err(MemoryWriteError::InvalidValue);
                }
                if inc_0 {
                    self.sp0 = self.sp0.wrapping_add(1);
                }
                if inc_1 {
                    self.sp1 = self.sp1.wrapping_add(1);
                }
                if dec_0 {
                    self.sp0 = self.sp0.wrapping_sub(1);
                }
                if dec_1 {
                    self.sp1 = self.sp1.wrapping_sub(1);
                }
                Ok(())
            }
            ENA_ADDR => {
                match val {
                    0 => self.enabled = false,
                    ENABLE => self.enabled = true,
                    _ => return Err(MemoryWriteError::InvalidValue)
                }
                Ok(())
            }
            x if x >= FRAME_BASE && x < FRAME_BASE + 2 * FRAME_SIZE => {
                if self.enabled {
                    self.ram[self.translate_addr(addr)] = val;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            }
            _ => Err(MemoryWriteError::Empty)
        }
    }
}
