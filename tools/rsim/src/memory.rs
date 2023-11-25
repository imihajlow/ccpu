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
    InvalidValue,
}

impl<'a> dyn Memory + 'a {
    pub fn get_u16(&'a self, addr: u16) -> Result<u16, MemoryReadError> {
        let lo = self.get(addr)?;
        let hi = self.get(addr.wrapping_add(1))?;
        return Ok(((hi as u16) << 8) | lo as u16);
    }
}

impl fmt::Display for MemoryReadError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            MemoryReadError::Contention => write!(f, "bus contention"),
            MemoryReadError::Empty => write!(f, "empty address"),
        }
    }
}

impl fmt::Display for MemoryWriteError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            MemoryWriteError::Empty => write!(f, "no write consumers"),
            MemoryWriteError::DeviceError => write!(f, "device error"),
            MemoryWriteError::InvalidValue => write!(f, "invalid value"),
        }
    }
}

pub trait ErrorChainable {
    fn chain_error(self, other: Self) -> Self;

    fn chain_some_error(self, other: Option<Self>) -> Self
    where
        Self: Sized,
    {
        match other {
            None => self,
            Some(x) => self.chain_error(x),
        }
    }
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
                Err(Contention) => Err(Contention),
            },
        }
    }
}

impl ErrorChainable for Result<(), MemoryWriteError> {
    fn chain_error(self, other: Self) -> Self {
        use MemoryWriteError::*;
        match self {
            Err(Empty) => other,
            Err(DeviceError) => Err(DeviceError),
            Err(InvalidValue) => Err(InvalidValue),
            Ok(()) => Ok(()),
        }
    }
}
