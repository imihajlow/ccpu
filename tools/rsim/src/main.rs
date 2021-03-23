mod instruction;
mod memory;
mod machine;
mod plain_ram;
mod real_mem;
mod symmap;

use std::fs::File;
use std::io;
use std::io::Write;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::Arc;
use ctrlc;
use parse_int::parse;
use argparse::{ArgumentParser, StoreTrue, Store};
use crate::machine::StepResult;

enum Command {
    Error,
    Next,
    Until(u16),
    Run,
    Breakpoint(u16),
    Print(u16, Type, u16),
    Quit,
}

#[derive(Copy, Clone)]
pub enum Type {
    Byte,
    Word,
    Dword
}


fn parse_command(syms: &symmap::SymMap, s: &String) -> Command {
    use Command::*;
    if s.len() == 0 {
        return Quit;
    }
    let mut iter = s.split_whitespace();
    match iter.next() {
        None |
        Some("n") |
        Some("next") => Next,

        Some("u") |
        Some("until") => {
            match select_address(syms, iter.next().unwrap_or("")) {
                Some(x) => Until(x),
                _ => Error
            }
        },

        Some("r") |
        Some("run") => Run,

        Some("b") |
        Some("break") |
        Some("breakpoint") => {
            match select_address(syms, iter.next().unwrap_or("")) {
                Some(x) => Breakpoint(x),
                _ => Error
            }
        },

        Some("p") |
        Some("print") => {
            let args: Vec<&str> = iter.collect();
            let (i_addr, i_type, i_count) = match args.len() {
                0 => return Error,
                1 => {
                    // p var
                    (0, None, None)
                },
                2 => {
                    // p w var
                    (1, Some(0), None)
                },
                3 => {
                    // p 100 b var
                    (2, Some(1), Some(0))
                },
                _ => return Error
            };
            let t = if let Some(i) = i_type {
                match args[i] {
                    "b" |
                    "byte" |
                    "bytes" => Type::Byte,

                    "w" |
                    "word" |
                    "words" => Type::Word,

                    "d" |
                    "dword" |
                    "dwords" => Type::Dword,

                    _ => return Error
                }
            } else {
                Type::Byte
            };

            let count = if let Some(i) = i_count {
                match parse::<u16>(args[i]) {
                    Ok(n) => n,
                    _ => return Error
                }
            } else {
                1
            };

            let addr = match select_address(syms, args[i_addr]) {
                Some(x) => x,
                None => return Error
            };
            Print(addr, t, count)
        }

        _ => Error
    }
}

fn select_address(syms: &symmap::SymMap, name: &str) -> Option<u16> {
    match parse::<u16>(&name) {
        Ok(addr) => return Some(addr),
        _ => {}
    }

    let symbols = syms.find_symbol(name);
    match symbols.len() {
        0 => {
            println!("Symbol not found: {}", name);
            None
        },
        1 => {
            let (name,addr) = &symbols[0];
            println!("{} => 0x{:04X}", name, addr);
            Some(*addr)
        },
        n if n < 10 => {
            println!("Choose wisely:");
            for (i, (name, addr)) in symbols.iter().enumerate() {
                println!("{}. {} (0x{:04X})", i, name, addr);
            }
            print!("Which one? ");
            io::stdout().flush().unwrap();
            let mut input = String::new();
            io::stdin().read_line(&mut input).unwrap();
            match parse::<usize>(&input) {
                Ok(i) if i < n => {
                    Some(symbols[i].1)
                },
                _ => {
                    println!("As you wish.");
                    None
                }
            }
        },
        _ => {
            println!("Too many choises");
            None
        }
    }
}

fn get_value(mem: &dyn memory::Memory, addr: u16, t: Type) -> Option<u32> {
    match t {
        Type::Byte => {
            let b = mem.get(addr).ok()?;
            Some(b.into())
        }
        Type::Word => {
            let b0 = mem.get(addr).ok()?;
            let b1 = mem.get(addr + 1).ok()?;
            Some(u16::from_le_bytes([b0, b1]).into())
        }
        Type::Dword => {
            let b0 = mem.get(addr).ok()?;
            let b1 = mem.get(addr + 1).ok()?;
            let b2 = mem.get(addr + 2).ok()?;
            let b3 = mem.get(addr + 3).ok()?;
            Some(u32::from_le_bytes([b0, b1, b2, b3]).into())
        }
    }
}

fn dump_mem(mem: &dyn memory::Memory, addr: u16, t: Type, count: u16) {
    let size = match t {
        Type::Byte => 1,
        Type::Word => 2,
        Type::Dword => 4
    };
    if count == 1 {
        let val = get_value(mem, addr, t);
        match val {
            Some(x) => println!("0x{:04X} = {:X} ({})", addr, x, x),
            None => println!("0x{:04X} = X", addr)
        };
    } else {
        for i in 0..count {
            let val = get_value(mem, addr + i * size, t);
            match val {
                Some(x) => print!("{:0width$X} ", x, width=(size * 2).into()),
                None => print!("XX")
            }
        }
        println!("");
    }

}

fn main() {
    let mut fname_bin = String::new();
    let mut fname_map = String::new();
    let mut mem_plain = false;

    {
        let mut ap = ArgumentParser::new();
        ap.set_description("CCPU simulator");
        ap.refer(&mut mem_plain).add_option(&["--plain"], StoreTrue, "Plain 64k of RAM, no IO");
        ap.refer(&mut fname_bin).add_argument("file", Store, "Program file");
        ap.refer(&mut fname_map).add_argument("mapfile", Store, "Label map file");
        ap.parse_args_or_exit();
    }


    let mut file_bin = File::open(fname_bin).expect("Can't open");
    let mut file_map = File::open(fname_map).expect("Can't open");
    let mut ram: Box<dyn memory::Memory> = if mem_plain {
        Box::new(plain_ram::PlainRam::load(&mut file_bin).expect("Read failed"))
    } else {
        Box::new(real_mem::Mem::load(&mut file_bin).expect("Read failed"))
    };
    let syms = symmap::SymMap::load(&mut file_map).expect("Symbol load failed");

    let ctrlc_pressed = Arc::new(AtomicBool::new(false));
    {
        let r = ctrlc_pressed.clone();
        ctrlc::set_handler(move || {
            r.store(true, Ordering::SeqCst);
        }).expect("Error setting Ctrl-C handler");
    }

    let mut state = machine::State::new();
    loop {
        match syms.associate_address(state.ip) {
            Some((addr, offset)) => println!("{} + 0x{:X}:", addr, offset),
            None => {}
        }
        machine::disasm(&*ram, state.ip, state.ip).expect("Can't disasm");
        println!("{}", &state);
        print!("> ");
        io::stdout().flush().unwrap();
        let mut input = String::new();
        io::stdin().read_line(&mut input).unwrap();
        ctrlc_pressed.store(false, Ordering::SeqCst);
        let result = match parse_command(&syms, &input) {
            Command::Quit => break,
            Command::Next => state.step(&mut *ram),
            Command::Until(x) => state.until(&mut *ram, Some(x), &ctrlc_pressed),
            Command::Run => state.until(&mut *ram, None, &ctrlc_pressed),
            Command::Breakpoint(x) => {
                let id = state.set_breakpoint(x);
                println!("Breakpoint {} at 0x{:04X}", id, x);
                StepResult::Ok
            },
            Command::Print(addr, t, count) => {
                dump_mem(&*ram, addr, t, count);
                StepResult::Ok
            }
            Command::Error => {
                println!("Bad command");
                StepResult::Ok
            }
        };

        match result {
            StepResult::Ok => {
            },
            StepResult::Breakpoint(id) => {
                println!("Breakpoint {} reached", id);
            },
            StepResult::Watchpoint(id) => {
                println!("Watchpoint {} reached", id);
            },
            StepResult::ReadError(addr, err) => {
                println!("Read error at 0x{:04X}: {}", addr, err);
            },
            StepResult::WriteError(addr, err) => {
                println!("Write error at 0x{:04X}: {}", addr, err);
            }
        }
    }
}
