use std::fmt;

pub trait Memory {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError>;

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryWriteError>;
}

#[derive(Debug)]
pub enum MemoryReadError {
    Contention,
    Empty,
}

#[derive(Debug)]
pub enum MemoryWriteError {
    Empty,
}

impl fmt::Display for MemoryReadError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            MemoryReadError::Contention => write!(f, "bus contention"),
            MemoryReadError::Empty => write!(f, "empty address")
        }
    }
}

impl fmt::Display for MemoryWriteError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            MemoryWriteError::Empty => write!(f, "no write consumers")
        }
    }
}
