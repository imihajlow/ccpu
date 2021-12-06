use crate::memory::{Memory, MemoryReadError, MemoryWriteError, ErrorChainable};
use crate::real_mem;
use crate::keyboard;
use crate::vga::Vga;
use crate::server::Server;
use crate::ps2::Ps2;
use crate::spi::Spi;
use crate::config::Config;
use std::io;
use std::sync::{Arc, Mutex};

pub struct System {
    mem: real_mem::Mem,
    kbd: Option<keyboard::Keyboard>,
    vga: Option<Arc<Mutex<Vga>>>,
    server: Option<Server>,
    ps2: Option<Arc<Mutex<Ps2>>>,
    spi: Option<Spi>,
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
        self.server.as_mut().map(|s| s.shutdown_and_join());
        println!("Bye");
    }
}

impl System {
    pub fn new<T>(config: &Config, prog_reader: &mut T) -> Result<System, LoadError>
    where T: io::Read + io::Seek {
        let mem = real_mem::Mem::new(config.get_mem_config(), prog_reader)?;
        let vga = Vga::new(config.get_vga_config())?
            .map(|vga| Arc::new(Mutex::new(vga)));
        let vga2 = vga.as_ref().map(|ref vga| Arc::clone(vga));
        let ps2 = Ps2::new(config.get_ps2_config())
            .map(|ps2| Arc::new(Mutex::new(ps2)));
        let ps22 = ps2.as_ref().map(|ref ps2| Arc::clone(ps2));
        let spi = Spi::new(config.get_spi_config());
        Ok(System {
            mem,
            kbd: keyboard::Keyboard::new(&config.get_kb_config()),
            vga: vga,
            ps2: ps2,
            spi: spi,
            server: Server::start(config.get_server_config(), vga2, ps22)
        })
    }

    pub fn get_keyboard_mut(&mut self) -> Option<&mut keyboard::Keyboard> {
        self.kbd.as_mut() //.map(|k| k)
    }

    pub fn get_vga(&self) -> Option<Arc<Mutex<Vga>>> {
        self.vga.as_ref().map(|v| Arc::clone(v))
    }

    pub fn get_spi_mut(&mut self) -> Option<&mut Spi> {
        self.spi.as_mut()
    }
}

impl Memory for System {
    fn get(&self, addr: u16) -> Result<u8, MemoryReadError> {
        self.mem.get(addr)
            .chain_some_error(self.kbd.as_ref().map(|kbd| kbd.get(addr)))
            .chain_some_error(self.spi.as_ref().map(|spi| spi.get(addr)))
            .chain_some_error(self.vga.as_ref().map(|vga| vga.lock().unwrap().get(addr)))
            .chain_some_error(self.ps2.as_ref().map(|ps2| ps2.lock().unwrap().get(addr)))
    }

    fn set(&mut self, addr: u16, value: u8) -> Result<(), MemoryWriteError> {
        self.mem.set(addr, value)
            .chain_some_error(self.kbd.as_mut().map(|kbd| kbd.set(addr, value)))
            .chain_some_error(self.spi.as_mut().map(|spi| spi.set(addr, value)))
            .chain_some_error(self.vga.as_mut().map(|vga| vga.lock().unwrap().set(addr, value)))
            .chain_some_error(self.ps2.as_mut().map(|ps2| ps2.lock().unwrap().set(addr, value)))
    }
}
