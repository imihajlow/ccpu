use crate::memory::{Memory, MemoryReadError, MemoryWriteError, ErrorChainable};
use crate::real_mem;
use crate::plain_ram;
use crate::keyboard;
use crate::vga;
use crate::server;
use crate::ps2;
use std::io;
use std::sync::{Arc, Mutex};

pub enum System {
    Plain(crate::plain_ram::PlainRam),
    Real {
        mem: real_mem::Mem,
        kbd: keyboard::Keyboard,
        vga: Arc<Mutex<vga::Vga>>,
        server: server::Server,
        ps2: Arc<Mutex<ps2::Ps2>>
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


impl std::ops::Drop for System {
    fn drop(&mut self) {
        match self {
            System::Real { server, .. } => {
                server.shutdown_and_join();
            }
            _ => ()
        };
        println!("Bye");
    }
}

impl System {
    pub fn new<T>(plain: bool, prog_reader: &mut T, font_reader: &mut Option<T>, server_port: u16) -> Result<System, LoadError>
    where T: io::Read + io::Seek {
        if plain {
            let mem = plain_ram::PlainRam::load(prog_reader)?;
            Ok(System::Plain(mem))
        } else {
            let mem = real_mem::Mem::load(prog_reader)?;
            let vga = Arc::new(Mutex::new(vga::Vga::new(font_reader)?));
            let vga2 = Arc::clone(&vga);
            let ps2 = Arc::new(Mutex::new(ps2::Ps2::new()));
            let ps22 = Arc::clone(&ps2);
            Ok(System::Real {
                mem,
                kbd: keyboard::Keyboard::new(),
                vga: vga,
                ps2: ps2,
                server: server::Server::start(server_port, vga2, ps22)
            })
        }
    }

    pub fn get_keyboard_mut(&mut self) -> Option<&mut keyboard::Keyboard> {
        match self {
            System::Plain(_) => None,
            System::Real{ ref mut kbd, .. } => Some(kbd)
        }
    }

    pub fn get_vga(&self) -> Option<Arc<Mutex<vga::Vga>>> {
        match self {
            System::Plain(_) => None,
            System::Real{ ref vga, ..} => Some(Arc::clone(vga))
        }
    }
}

impl Memory for System {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError> {
        match self {
            System::Plain(m) => m.get(addr),
            System::Real { mem, kbd, vga, ps2, .. } => {
                mem.get(addr)
                    .chain_error(kbd.get(addr))
                    .chain_error(vga.lock().unwrap().get(addr))
                    .chain_error(ps2.lock().unwrap().get(addr))
            }
        }
    }

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryWriteError> {
        match self {
            System::Plain(m) => m.set(addr, value),
            System::Real { mem, kbd, vga, ps2, .. } => {
                mem.set(addr, value)
                    .chain_error(kbd.set(addr, value))
                    .chain_error(vga.lock().unwrap().set(addr, value))
                    .chain_error(ps2.lock().unwrap().set(addr, value))
            }
        }
    }
}
