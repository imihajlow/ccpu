use crate::memory::MemoryReadError;
use crate::memory::MemoryWriteError;
use crate::memory::Memory;
use std::io;

const CR_ADDR: u16 = 0xFF02;

pub struct Mem {
    rom: [u8; 0x8000],
    hi_ram: [u8; 0x7000],
    lo_ram: [u8; 0x8000],
    cr: Cr
}

#[derive(Copy, Clone)]
pub struct Cr {
    raml_ena: bool,
    l_ena: bool,
    r_ena: bool,
    ram_a_ena: bool,
    ram_b_ena: bool,
    ram_c_ena: bool,
    ram_d_ena: bool,
    ram_e_ena: bool,
}

impl From<u8> for Cr {
    fn from(value: u8) -> Self {
        Cr {
            raml_ena: value & 0x1 != 0,
            l_ena: value & 0x2 != 0,
            r_ena: value & 0x4 != 0,
            ram_a_ena: value & 0x8 != 0,
            ram_b_ena: value & 0x10 != 0,
            ram_c_ena: value & 0x20 != 0,
            ram_d_ena: value & 0x40 != 0,
            ram_e_ena: value & 0x80 != 0
        }
    }
}

fn bit(value: bool, shift: u8) -> u8 {
    if value {
        1 << shift
    } else {
        0
    }
}

impl From<Cr> for u8 {
    fn from(cr: Cr) -> u8 {
        bit(cr.raml_ena, 0) |
        bit(cr.l_ena, 1) |
        bit(cr.r_ena, 2) |
        bit(cr.ram_a_ena, 3) |
        bit(cr.ram_b_ena, 4) |
        bit(cr.ram_c_ena, 5) |
        bit(cr.ram_d_ena, 6) |
        bit(cr.ram_e_ena, 7)
    }
}

#[derive(Debug)]
pub enum LoadError {
    IoError(io::Error),
    WrongFileSize
}

impl From<io::Error> for LoadError {
    fn from(error: io::Error) -> Self {
        LoadError::IoError(error)
    }
}

impl Mem {
    pub fn load<T>(reader: &mut T) -> Result<Mem, LoadError>
    where T: io::Read + io::Seek {
        let size = reader.seek(io::SeekFrom::End(0))?;
        if size != 0x8000 {
            return Err(LoadError::WrongFileSize);
        }
        reader.seek(io::SeekFrom::Start(0))?;
        let mut ram = Mem{
            rom: [0xff; 0x8000],
            hi_ram: [0x00; 0x7000],
            lo_ram: [0x00; 0x8000],
            cr: Cr::from(0)
        };
        reader.read_exact(&mut ram.rom)?;
        Ok(ram)
    }
}

impl Memory for Mem {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError> {
        match addr {
            x if x < 0x8000 => {
                if self.cr.raml_ena {
                    Ok(self.lo_ram[x as usize])
                } else {
                    Ok(self.rom[x as usize])
                }
            },
            x if x < 0xA000 => {
                Ok(self.hi_ram[x as usize - 0x8000])
            },
            x if x < 0xB000 => {
                if self.cr.ram_a_ena {
                    Ok(self.hi_ram[x as usize - 0x8000])
                } else {
                    Err(MemoryReadError::Empty)
                }
            },
            x if x < 0xC000 => {
                if self.cr.ram_b_ena {
                    Ok(self.hi_ram[x as usize - 0x8000])
                } else {
                    Err(MemoryReadError::Empty)
                }
            },
            x if x < 0xD000 => {
                if self.cr.ram_c_ena {
                    Ok(self.hi_ram[x as usize - 0x8000])
                } else {
                    Err(MemoryReadError::Empty)
                }
            },
            x if x < 0xE000 => {
                if self.cr.ram_d_ena {
                    Ok(self.hi_ram[x as usize - 0x8000])
                } else {
                    Err(MemoryReadError::Empty)
                }
            },
            x if x < 0xF000 => {
                if self.cr.ram_e_ena {
                    Ok(self.hi_ram[x as usize - 0x8000])
                } else {
                    Err(MemoryReadError::Empty)
                }
            },
            CR_ADDR => {
                Ok(u8::from(self.cr))
            },
            _ => {
                Err(MemoryReadError::Empty)
            },
        }
    }

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryWriteError> {
        match addr {
            x if x < 0x8000 => {
                if self.cr.raml_ena {
                    self.lo_ram[x as usize] = value;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            },
            x if x < 0xA000 => {
                self.hi_ram[x as usize - 0x8000] = value;
                Ok(())
            },
            x if x < 0xB000 => {
                if self.cr.ram_a_ena {
                    self.hi_ram[x as usize - 0x8000] = value;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            },
            x if x < 0xC000 => {
                if self.cr.ram_b_ena {
                    self.hi_ram[x as usize - 0x8000] = value;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            },
            x if x < 0xD000 => {
                if self.cr.ram_c_ena {
                    self.hi_ram[x as usize - 0x8000] = value;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            },
            x if x < 0xE000 => {
                if self.cr.ram_d_ena {
                    self.hi_ram[x as usize - 0x8000] = value;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            },
            x if x < 0xF000 => {
                if self.cr.ram_e_ena {
                    self.hi_ram[x as usize - 0x8000] = value;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            },
            CR_ADDR => {
                self.cr = Cr::from(value);
                Ok(())
            },
            _ => {
                Err(MemoryWriteError::Empty)
            },
        }
    }
}
