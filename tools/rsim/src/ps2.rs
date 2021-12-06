use crate::config::Ps2Config;
use crate::memory::{Memory, MemoryReadError, MemoryWriteError};
use std::collections::VecDeque;

const PS2_DATA_ADDR: u16 = 0xFD00;
const PS2_CTRL_ADDR: u16 = 0xFD01;

pub struct Ps2 {
    queue: VecDeque<u8>,
    last_data: u8,
}

impl Ps2 {
    pub fn new(config: &Ps2Config) -> Option<Self> {
        match config {
            Ps2Config::Absent => None,
            Ps2Config::Present => Some(Self {
                queue: VecDeque::new(),
                last_data: 0
            })
        }
    }

    pub fn push(&mut self, v: u8) {
        self.queue.push_back(v);
    }
}

impl Memory for Ps2 {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError> {
        match addr {
            PS2_DATA_ADDR => {
                match self.queue.front() {
                    None => Ok(self.last_data),
                    Some(x) => Ok(*x)
                }
            }
            PS2_CTRL_ADDR => {
                let has_data = self.queue.len() != 0;
                Ok(has_data as u8 | 2)
            }
            _ => Err(MemoryReadError::Empty)
        }
    }

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryWriteError> {
        match addr {
            PS2_CTRL_ADDR => {
                match self.queue.pop_front() {
                    Some(x) => {
                        self.last_data = x;
                    }
                    None => {}
                }
                Ok(())
            }
            PS2_DATA_ADDR => {
                println!("PS2 transmit {}", value);
                Ok(())
            }
            _ => Err(MemoryWriteError::Empty)
        }
    }
}
