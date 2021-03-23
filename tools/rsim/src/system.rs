use crate::memory::{Memory, MemoryReadError, MemoryWriteError, ErrorChainable};
use crate::real_mem;
use crate::plain_ram;
use crate::keyboard;
use std::io;

pub enum System {
    Plain(crate::plain_ram::PlainRam),
    Real {
        mem: real_mem::Mem,
        kbd: keyboard::Keyboard
    }
}

#[derive(Debug)]
pub enum LoadError {
    ProgLoadError(real_mem::LoadError)
}

impl From<real_mem::LoadError> for LoadError {
    fn from(error: real_mem::LoadError) -> Self {
        LoadError::ProgLoadError(error)
    }
}

impl From<io::Error> for LoadError {
    fn from(error: io::Error) -> Self {
        LoadError::from(real_mem::LoadError::from(error))
    }
}

impl System {
    pub fn new<T>(plain: bool, prog_reader: &mut T) -> Result<System, LoadError>
    where T: io::Read + io::Seek {
        if plain {
            let mem = plain_ram::PlainRam::load(prog_reader)?;
            Ok(System::Plain(mem))
        } else {
            let mem = real_mem::Mem::load(prog_reader)?;
            Ok(System::Real {
                mem,
                kbd: keyboard::Keyboard::new()
            })
        }
    }

    pub fn get_keyboard_mut(&mut self) -> Option<&mut keyboard::Keyboard> {
        match self {
            System::Plain(_) => None,
            System::Real{ ref mut kbd, .. } => Some(kbd)
        }
    }
}

impl Memory for System {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError> {
        match self {
            System::Plain(m) => m.get(addr),
            System::Real { mem, kbd } => {
                mem.get(addr)
                    .chain_error(kbd.get(addr))
            }
        }
    }

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryWriteError> {
        match self {
            System::Plain(m) => m.set(addr, value),
            System::Real { mem, kbd } => {
                mem.set(addr, value)
                    .chain_error(kbd.set(addr, value))
            }
        }
    }
}
