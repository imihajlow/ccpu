use crate::config::MemConfig;
use crate::memory::Memory;
use crate::memory::MemoryReadError;
use crate::memory::MemoryWriteError;
use serde::Deserialize;
use std::io;

const CR_ADDR: u16 = 0xFF02;

pub enum Mem {
    Plain(PlainMem),
    IoRev3(IoRev3Mem),
}

pub struct PlainMem {
    ram: [u8; 0x10000],
}

pub struct IoRev3Mem {
    rom: [u8; 0x8000],
    hi_ram: [u8; 0x7000],
    lo_ram: [u8; 0x8000],
    cr: Cr,
}

#[derive(Copy, Clone, Deserialize, Debug, Default)]
#[serde(from = "u8")]
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
            ram_e_ena: value & 0x80 != 0,
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
        bit(cr.raml_ena, 0)
            | bit(cr.l_ena, 1)
            | bit(cr.r_ena, 2)
            | bit(cr.ram_a_ena, 3)
            | bit(cr.ram_b_ena, 4)
            | bit(cr.ram_c_ena, 5)
            | bit(cr.ram_d_ena, 6)
            | bit(cr.ram_e_ena, 7)
    }
}

impl Cr {
    fn get_max_program_size(&self) -> usize {
        if !self.raml_ena {
            0x8000
        } else {
            if !self.ram_a_ena {
                return 0xA000;
            }
            if !self.ram_b_ena {
                return 0xB000;
            }
            if !self.ram_c_ena {
                return 0xC000;
            }
            if !self.ram_d_ena {
                return 0xD000;
            }
            if !self.ram_e_ena {
                return 0xE000;
            }
            return 0xF000;
        }
    }
}

#[derive(Debug)]
pub enum LoadError {
    IoError(io::Error),
    WrongFileSize,
}

impl From<io::Error> for LoadError {
    fn from(error: io::Error) -> Self {
        LoadError::IoError(error)
    }
}

impl PlainMem {
    fn new<T>(reader: &mut T) -> Result<Self, LoadError>
    where
        T: io::Read + io::Seek,
    {
        let size = reader.seek(io::SeekFrom::End(0))? as usize;
        if size > 0x10000 {
            return Err(LoadError::WrongFileSize);
        }
        reader.seek(io::SeekFrom::Start(0))?;
        let mut r = Self {
            ram: [0x00; 0x10000],
        };
        let left = r.ram.split_at_mut(size).0;
        reader.read_exact(left)?;
        Ok(r)
    }
}

impl IoRev3Mem {
    fn new<T>(cr: &Cr, reader: &mut T) -> Result<Self, LoadError>
    where
        T: io::Read + io::Seek,
    {
        let size = reader.seek(io::SeekFrom::End(0))? as usize;
        if size > cr.get_max_program_size() {
            return Err(LoadError::WrongFileSize);
        }
        reader.seek(io::SeekFrom::Start(0))?;
        let mut r = IoRev3Mem {
            rom: [0xff; 0x8000],
            hi_ram: [0x00; 0x7000],
            lo_ram: [0x00; 0x8000],
            cr: *cr,
        };
        if r.cr.raml_ena {
            reader.read(&mut r.lo_ram)?;
        } else {
            reader.read(&mut r.rom)?;
        }
        reader.read(&mut r.hi_ram)?;
        Ok(r)
    }
}

impl Mem {
    pub fn new<T>(config: &MemConfig, reader: &mut T) -> Result<Mem, LoadError>
    where
        T: io::Read + io::Seek,
    {
        match config {
            MemConfig::Plain => Ok(Self::Plain(PlainMem::new(reader)?)),
            MemConfig::IoRev3(cr) => Ok(Self::IoRev3(IoRev3Mem::new(cr, reader)?)),
        }
    }
}

impl Memory for Mem {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError> {
        match self {
            Self::Plain(m) => m.get(addr),
            Self::IoRev3(m) => m.get(addr),
        }
    }

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryWriteError> {
        match self {
            Self::Plain(ref mut m) => m.set(addr, value),
            Self::IoRev3(ref mut m) => m.set(addr, value),
        }
    }
}

impl Memory for PlainMem {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError> {
        Ok(self.ram[addr as usize])
    }

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryWriteError> {
        self.ram[addr as usize] = value;
        Ok(())
    }
}

impl Memory for IoRev3Mem {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError> {
        match addr {
            x if x < 0x8000 => {
                if self.cr.raml_ena {
                    Ok(self.lo_ram[x as usize])
                } else {
                    Ok(self.rom[x as usize])
                }
            }
            x if x < 0xA000 => Ok(self.hi_ram[x as usize - 0x8000]),
            x if x < 0xB000 => {
                if self.cr.ram_a_ena {
                    Ok(self.hi_ram[x as usize - 0x8000])
                } else {
                    Err(MemoryReadError::Empty)
                }
            }
            x if x < 0xC000 => {
                if self.cr.ram_b_ena {
                    Ok(self.hi_ram[x as usize - 0x8000])
                } else {
                    Err(MemoryReadError::Empty)
                }
            }
            x if x < 0xD000 => {
                if self.cr.ram_c_ena {
                    Ok(self.hi_ram[x as usize - 0x8000])
                } else {
                    Err(MemoryReadError::Empty)
                }
            }
            x if x < 0xE000 => {
                if self.cr.ram_d_ena {
                    Ok(self.hi_ram[x as usize - 0x8000])
                } else {
                    Err(MemoryReadError::Empty)
                }
            }
            x if x < 0xF000 => {
                if self.cr.ram_e_ena {
                    Ok(self.hi_ram[x as usize - 0x8000])
                } else {
                    Err(MemoryReadError::Empty)
                }
            }
            CR_ADDR => Ok(u8::from(self.cr)),
            _ => Err(MemoryReadError::Empty),
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
            }
            x if x < 0xA000 => {
                self.hi_ram[x as usize - 0x8000] = value;
                Ok(())
            }
            x if x < 0xB000 => {
                if self.cr.ram_a_ena {
                    self.hi_ram[x as usize - 0x8000] = value;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            }
            x if x < 0xC000 => {
                if self.cr.ram_b_ena {
                    self.hi_ram[x as usize - 0x8000] = value;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            }
            x if x < 0xD000 => {
                if self.cr.ram_c_ena {
                    self.hi_ram[x as usize - 0x8000] = value;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            }
            x if x < 0xE000 => {
                if self.cr.ram_d_ena {
                    self.hi_ram[x as usize - 0x8000] = value;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            }
            x if x < 0xF000 => {
                if self.cr.ram_e_ena {
                    self.hi_ram[x as usize - 0x8000] = value;
                    Ok(())
                } else {
                    Err(MemoryWriteError::Empty)
                }
            }
            CR_ADDR => {
                self.cr = Cr::from(value);
                Ok(())
            }
            _ => Err(MemoryWriteError::Empty),
        }
    }
}
