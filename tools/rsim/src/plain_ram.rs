use crate::memory::MemoryError;
use crate::memory::Memory;
use std::io;

pub struct PlainRam {
    contents: [u8; 0x10000]
}

impl Memory for PlainRam {
    fn get(&self, addr: u16) -> Result<u8, MemoryError> {
        Ok(self.contents[addr as usize])
    }

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryError> {
        self.contents[addr as usize] = value;
        Ok(())
    }
}

impl PlainRam {
    pub fn load<T: io::Read>(reader: &mut T) -> io::Result<PlainRam> {
        let mut ram = PlainRam{
            contents: [0; 0x10000]
        };
        reader.read(&mut ram.contents)?;
        Ok(ram)
    }
}
