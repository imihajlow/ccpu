use crate::card::Card;
use crate::config::SpiConfig;
use crate::memory::{Memory, MemoryReadError, MemoryWriteError};

const DATA_ADDR: u16 = 0xFD02;
const CTRL_ADDR: u16 = 0xFD03;

pub struct Spi {
    spi_buf: u8,
    power: bool,
    cs: bool,
    card: Option<Card>,
}

impl Spi {
    pub fn new(config: &SpiConfig) -> Option<Self> {
        match config {
            SpiConfig::Absent => None,
            SpiConfig::Present => Some(Self {
                spi_buf: 0,
                power: false,
                cs: true,
                card: None,
            }),
        }
    }

    pub fn insert(&mut self, mut card: Card) -> Option<Card> {
        let prev_card = self.card.take();
        card.set_power(self.power);
        card.set_cs(self.cs);
        self.card = Some(card);
        prev_card
    }

    pub fn eject(&mut self) -> Option<Card> {
        self.card.take()
    }
}

impl Memory for Spi {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError> {
        match addr {
            CTRL_ADDR => match self.card {
                Some(_) => Ok(0),
                None => Ok(1),
            },
            DATA_ADDR => Ok(self.spi_buf),
            _ => Err(MemoryReadError::Empty),
        }
    }

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryWriteError> {
        match addr {
            CTRL_ADDR => {
                self.power = value & 0x08 != 0;
                self.cs = value & 0x04 == 0;
                match self.card {
                    Some(ref mut card) => {
                        card.set_power(self.power);
                        card.set_cs(self.cs);
                    }
                    None => (),
                };
                Ok(())
            }
            DATA_ADDR => match self.card {
                Some(ref mut card) => match card.transfer(value) {
                    Some(x) => {
                        self.spi_buf = x;
                        Ok(())
                    }
                    None => Err(MemoryWriteError::DeviceError),
                },
                None => {
                    self.spi_buf = 0xff;
                    Ok(())
                }
            },
            _ => Err(MemoryWriteError::Empty),
        }
    }
}
