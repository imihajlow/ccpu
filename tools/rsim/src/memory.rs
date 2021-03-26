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
    DeviceError,
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
            MemoryWriteError::Empty => write!(f, "no write consumers"),
            MemoryWriteError::DeviceError => write!(f, "device error")
        }
    }
}

pub trait ErrorChainable {
    fn chain_error(self, other: Self) -> Self;
}

impl ErrorChainable for Result<u8, MemoryReadError> {
    fn chain_error(self, other: Self) -> Self {
        use MemoryReadError::*;
        match self {
            Err(Empty) => other,
            Err(Contention) => Err(Contention),
            Ok(_) => match other {
                Ok(_) => Err(Contention),
                Err(Empty) => self,
                Err(Contention) => Err(Contention)
            }
        }
    }
}

impl ErrorChainable for Result<(), MemoryWriteError> {
    fn chain_error(self, other: Self) -> Self {
        use MemoryWriteError::*;
        match self {
            Err(Empty) => other,
            Err(DeviceError) => Err(DeviceError),
            Ok(()) => Ok(())
        }
    }
}
