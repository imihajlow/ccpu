

pub trait Memory {
    fn get(&self, addr: u16) -> Result<u8, MemoryError>;

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryError>;
}

#[derive(Debug)]
pub enum MemoryError {
}
