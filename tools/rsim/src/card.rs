use std::fs::File;
use std::io::{Seek, Read};


const CMD_0: u8 = 0x40;
const CMD_17: u8 = 0x40 | 17;
const CMD_24: u8 = 0x40 | 24;
const CMD_55: u8 = 0x40 | 55;
const CMD_41: u8 = 0x40 | 41;

const R1_IDLE: u8 = 1;
const R1_READY: u8 = 0;


pub struct Card {
    image: File,
    cs: bool,
    state: HardState,
}

#[derive(Debug)]
enum HardState {
    POWEROFF,
    ON {
        is_ready: bool,
        is_acmd: bool,
        state: SoftState
    }
}

#[derive(Debug)]
enum SoftState {
    Idle,
    Cmd {
        index: usize,
        data: [u8; 6]
    },
    DelayRead {
        addr: u32,
        counter: usize
    },
    Read {
        buf: [u8; 512],
        index: usize
    },
    BlockCrc1,
    BlockCrc2
}

impl Card {
    pub fn new(image: File) -> Self {
        Self {
            image,
            cs: true,
            state: HardState::POWEROFF
        }
    }

    pub fn set_power(&mut self, v: bool) {
        use HardState::*;
        match &self.state {
            POWEROFF if v => {
                self.state = ON {
                    is_ready: false,
                    is_acmd: false,
                    state: SoftState::Idle
                };
            }
            _ if !v => {
                self.state = POWEROFF;
            }
            _ => {}
        };
    }

    pub fn set_cs(&mut self, v: bool) {
        self.cs = v;
    }

    pub fn transfer(&mut self, v: u8) -> Option<u8> {
        if !self.cs {
            return Some(0xff)
        }
        use HardState::*;
        use SoftState::*;
        match self.state {
            POWEROFF => Some(0xff),
            ON { is_ready, is_acmd, ref mut state } => match state {
                Idle => {
                    match v {
                        0xff => Some(0xff),
                        CMD_0 |
                        CMD_55 |
                        CMD_17 |
                        CMD_24 |
                        CMD_41 => {
                            self.state = ON {
                                is_ready,
                                is_acmd,
                                state: Cmd {
                                    index: 1,
                                    data: [v, 0, 0, 0, 0, 0]
                                }
                            };
                            Some(0xff)
                        }
                        _ => {
                            eprintln!("Unhandled card command: 0x{:02X}", v);
                            None
                        }
                    }
                },
                Cmd { ref mut index, ref mut data } if *index < 6 => {
                    data[*index] = v;
                    *index = *index + 1;
                    Some(0xff)
                },
                Cmd { data, .. } => {
                    match data[0] {
                        CMD_0 if !is_acmd => {
                            self.state = ON {
                                is_ready: false,
                                is_acmd: false,
                                state: Idle
                            };
                            Some(R1_IDLE)
                        }
                        CMD_55 if !is_acmd => {
                            self.state = ON {
                                is_ready,
                                is_acmd: true,
                                state: Idle
                            };
                            Some(if is_ready { R1_READY } else { R1_IDLE })
                        }
                        CMD_41 if is_acmd => {
                            self.state = ON {
                                is_ready: true,
                                is_acmd: false,
                                state: Idle
                            };
                            Some(R1_READY)
                        }
                        CMD_17 if !is_acmd && is_ready => {
                            let pos = u32::from_be_bytes([data[1], data[2], data[3], data[4]]);
                            println!("Read block from 0x{:08X}", pos);
                            *state = DelayRead {
                                addr: pos,
                                counter: 3
                            };

                            Some(R1_READY)
                        }
                        _ => {
                            self.state = ON {
                                is_ready,
                                is_acmd: false,
                                state: Idle
                            };
                            Some(0b00000100 | ((!is_ready) as u8)) // illegal command
                        }
                    }
                }
                DelayRead { addr, counter: 0 } => {
                    let pos = *addr as u64;
                    match self.image.seek(std::io::SeekFrom::Start(pos)) {
                        Ok(_) => {
                            let mut buf: [u8; 512] = [0; 512];
                            match self.image.read_exact(&mut buf) {
                                Ok(()) => {
                                    *state = Read {
                                        buf,
                                        index: 0
                                    };
                                    Some(0b11111110) // data token
                                }
                                Err(e) => {
                                    *state = Idle;
                                    eprintln!("Can't read image: {:?}", e);
                                    Some(0b00000001) // error
                                }
                            }
                        }
                        Err(e) => {
                            eprintln!("Can't seek to {}: {:?}", pos, e);
                            *state = Idle;
                            Some(0b00001001) // out of range, error
                        }
                    }
                },
                DelayRead { ref mut counter, .. } => {
                    *counter -= 1;
                    Some(0xFF)
                },
                Read { index: 511, buf } => {
                    let val = buf[511];
                    *state = BlockCrc1;
                    Some(val)
                },
                Read { ref mut index, buf } => {
                    let i = *index;
                    *index += 1;
                    Some(buf[i])
                },
                BlockCrc1 => {
                    *state = BlockCrc2;
                    Some(0xff)
                }
                BlockCrc2 => {
                    *state = Idle;
                    Some(0xff)
                }
            }
        }
    }
}
