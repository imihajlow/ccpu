mod card;
mod config;
mod font;
mod instruction;
mod keyboard;
mod machine;
mod mem;
mod memory;
mod ps2;
mod server;
mod spi;
mod stack;
mod symmap;
mod system;
mod vga;
mod vga_window;
mod z80;

use crate::config::Config;
use crate::vga_window::VgaWindow;
use memory::MemoryWriteError;
use regex::Regex;
use std::fs::{File, OpenOptions};
use std::path::PathBuf;
use std::println;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::{mpsc, Arc};
use symmap::SymMap;
use system::System;
#[macro_use]
extern crate lazy_static;
use crate::machine::StepResult;
use argparse::{ArgumentParser, Collect, Store, StoreOption};
use ctrlc;
use parse_int::parse;
use rustyline::error::ReadlineError;
use rustyline::Editor;

enum Command {
    Next,
    NextLine,
    Until(u16),
    Run,
    Breakpoint(u16),
    Delete(u32),
    Print(u16, Type, u16),
    Poke(u16, Type, u64),
    Check(u16, Type, u64),
    Press(Option<(u8, u8)>),
    Png(String),
    Insert(File),
    Eject,
    Quit,
}

#[derive(Copy, Clone)]
enum ParseError {
    BadCommand,
    BadArgument,
}

#[derive(Copy, Clone)]
pub enum Type {
    Byte,
    Word,
    Dword,
    Qword,
}

impl Type {
    fn new_from_string(s: &str) -> Result<Self, ParseError> {
        match s {
            "b" | "byte" | "bytes" => Ok(Type::Byte),

            "w" | "word" | "words" => Ok(Type::Word),

            "d" | "dword" | "dwords" => Ok(Type::Dword),

            "q" | "qword" | "qwords" => Ok(Type::Qword),

            _ => Err(ParseError::BadArgument),
        }
    }
}

fn parse_command(
    syms: &symmap::SymMap,
    s: &String,
    rl: &mut Editor<()>,
) -> Result<Command, ParseError> {
    use Command::*;
    let mut iter = s.split_whitespace();
    match iter.next() {
        None | Some("n") | Some("next") => Ok(Next),

        Some("l") => Ok(NextLine),

        Some("u") | Some("until") => match select_address(syms, iter.next().unwrap_or(""), rl) {
            Some(x) => Ok(Until(x)),
            _ => Err(ParseError::BadArgument),
        },

        Some("r") | Some("run") => Ok(Run),

        Some("b") | Some("break") | Some("breakpoint") => {
            match select_address(syms, iter.next().unwrap_or(""), rl) {
                Some(x) => Ok(Breakpoint(x)),
                _ => Err(ParseError::BadArgument),
            }
        }

        Some("del") | Some("delete") => match iter.next() {
            Some(s) => match parse::<u32>(s) {
                Ok(x) => Ok(Delete(x)),
                _ => Err(ParseError::BadArgument),
            },
            None => Err(ParseError::BadArgument),
        },

        Some("p") | Some("print") => {
            let args: Vec<&str> = iter.collect();
            let (i_addr, i_type, i_count) = match args.len() {
                0 => return Err(ParseError::BadArgument),
                1 => {
                    // p var
                    (0, None, None)
                }
                2 => {
                    // p w var
                    (1, Some(0), None)
                }
                3 => {
                    // p 100 b var
                    (2, Some(1), Some(0))
                }
                _ => return Err(ParseError::BadArgument),
            };
            let t = if let Some(i) = i_type {
                Type::new_from_string(args[i])?
            } else {
                Type::Byte
            };

            let count = if let Some(i) = i_count {
                match parse::<u16>(args[i]) {
                    Ok(n) => n,
                    _ => return Err(ParseError::BadArgument),
                }
            } else {
                1
            };

            let addr = match select_address(syms, args[i_addr], rl) {
                Some(x) => x,
                None => return Err(ParseError::BadArgument),
            };
            Ok(Print(addr, t, count))
        }

        Some("poke") => {
            let args: Vec<&str> = iter.collect();
            if args.len() != 3 {
                return Err(ParseError::BadArgument);
            }

            let t = Type::new_from_string(args[0])?;

            let addr = match select_address(syms, args[1], rl) {
                Some(x) => x,
                None => return Err(ParseError::BadArgument),
            };

            let val = match parse::<u64>(&args[2]) {
                Ok(x) => x,
                Err(_) => return Err(ParseError::BadArgument),
            };
            Ok(Poke(addr, t, val))
        }

        Some("check") => {
            let args: Vec<&str> = iter.collect();
            if args.len() != 3 {
                return Err(ParseError::BadArgument);
            }

            let t = Type::new_from_string(args[0])?;

            let addr = match select_address(syms, args[1], rl) {
                Some(x) => x,
                None => return Err(ParseError::BadArgument),
            };

            let val = match parse::<u64>(&args[2]) {
                Ok(x) => x,
                Err(_) => return Err(ParseError::BadArgument),
            };
            Ok(Check(addr, t, val))
        }

        Some("press") => match iter.next() {
            None => Ok(Press(None)),
            Some(s) => Ok(match s.to_uppercase().as_str() {
                "F1" => Press(Some(keyboard::KEY_F1)),
                "F2" => Press(Some(keyboard::KEY_F2)),
                "*" => Press(Some(keyboard::KEY_STAR)),
                "#" => Press(Some(keyboard::KEY_HASH)),
                "1" => Press(Some(keyboard::KEY_1)),
                "2" => Press(Some(keyboard::KEY_2)),
                "3" => Press(Some(keyboard::KEY_3)),
                "UP" => Press(Some(keyboard::KEY_UP)),
                "4" => Press(Some(keyboard::KEY_4)),
                "5" => Press(Some(keyboard::KEY_5)),
                "6" => Press(Some(keyboard::KEY_6)),
                "DOWN" => Press(Some(keyboard::KEY_DOWN)),
                "7" => Press(Some(keyboard::KEY_7)),
                "8" => Press(Some(keyboard::KEY_8)),
                "9" => Press(Some(keyboard::KEY_9)),
                "ESCAPE" | "ESC" => Press(Some(keyboard::KEY_ESCAPE)),
                "LEFT" => Press(Some(keyboard::KEY_LEFT)),
                "0" => Press(Some(keyboard::KEY_0)),
                "RIGHT" => Press(Some(keyboard::KEY_RIGHT)),
                "ENTER" => Press(Some(keyboard::KEY_ENTER)),
                _ => return Err(ParseError::BadArgument),
            }),
        },

        Some("png") => match iter.next() {
            Some(s) => Ok(Png(s.to_string())),
            None => Err(ParseError::BadArgument),
        },

        Some("insert") => match iter.next() {
            Some(s) => match OpenOptions::new().write(true).read(true).open(s) {
                Ok(f) => Ok(Insert(f)),
                Err(e) => {
                    eprintln!("Can't open {}: {:?}", s, e);
                    Err(ParseError::BadArgument)
                }
            },
            None => Err(ParseError::BadArgument),
        },

        Some("eject") => Ok(Eject),

        Some("quit") => Ok(Quit),

        _ => Err(ParseError::BadCommand),
    }
}

fn select_symbol<N: std::fmt::Display>(
    symbols: &Vec<&(N, u16)>,
    rl: &mut Editor<()>,
) -> Option<u16> {
    match symbols.len() {
        0 => None,
        1 => {
            let (name, addr) = &symbols[0];
            println!("{} => 0x{:04X}", name, addr);
            Some(*addr)
        }
        n if n < 10 => {
            println!("Choose wisely:");
            for (i, (name, addr)) in symbols.iter().enumerate() {
                println!("{}. {} (0x{:04X})", i, name, addr);
            }
            let input = match rl.readline("Which one? ") {
                Ok(l) => l,
                Err(ReadlineError::Eof) | Err(ReadlineError::Interrupted) => return None,
                Err(e) => {
                    println!("Error {:?}", e);
                    return None;
                }
            };
            match parse::<usize>(&input) {
                Ok(i) if i < n => Some(symbols[i].1),
                _ => {
                    println!("As you wish.");
                    None
                }
            }
        }
        _ => {
            println!("Too many choises");
            None
        }
    }
}

fn select_address(syms: &symmap::SymMap, name: &str, rl: &mut Editor<()>) -> Option<u16> {
    lazy_static! {
        static ref RE: Regex = Regex::new(
            r"(?i)^(?:(?:([a-z_/][^: ]+):)([1-9][0-9]*))|([_a-z][_a-z0-9]+)|([1-9][0-9]*|0x[0-9a-f]+)$"
        )
        .unwrap();
    }

    match RE.captures(name) {
        None => {
            println!("Bad address");
            return None;
        }
        Some(cap) => {
            match cap.get(2) {
                Some(line) => {
                    let file = &cap[1];
                    let line = parse::<u32>(line.as_str()).unwrap();
                    let options = syms.find_line(file, line);
                    return select_symbol(&options, rl);
                }
                None => {}
            }
            match cap.get(3) {
                Some(name) => {
                    let symbols = syms.find_symbol(name.as_str());
                    return select_symbol(&symbols, rl);
                }
                None => {}
            }
            match cap.get(4) {
                Some(addr) => match parse::<u16>(addr.as_str()) {
                    Ok(addr) => return Some(addr),
                    _ => {}
                },
                None => {}
            }
        }
    }
    None
}

fn get_value(mem: &dyn memory::Memory, addr: u16, t: Type) -> Option<u64> {
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
        Type::Qword => {
            let mut buf = [0; 8];
            for i in 0..8 {
                buf[i] = mem.get(addr + i as u16).ok()?;
            }
            Some(u64::from_le_bytes(buf).into())
        }
    }
}

fn set_value(
    mem: &mut dyn memory::Memory,
    addr: u16,
    t: Type,
    val: u64,
) -> Result<(), MemoryWriteError> {
    let mut buf = [0; 8];
    let bytes = match t {
        Type::Byte => {
            buf[0] = val as u8;
            &buf[0..1]
        }
        Type::Word => {
            let lsb = (val as u16).to_le_bytes();
            buf[0..2].copy_from_slice(&lsb);
            &buf[0..2]
        }
        Type::Dword => {
            let lsb = (val as u32).to_le_bytes();
            buf[0..4].copy_from_slice(&lsb);
            &buf[0..4]
        }
        Type::Qword => {
            let lsb = (val as u64).to_le_bytes();
            buf[0..8].copy_from_slice(&lsb);
            &buf[0..8]
        }
    };
    for (offset, b) in bytes.iter().enumerate() {
        mem.set(addr + (offset as u16), *b)?;
    }
    Ok(())
}

fn dump_mem(mem: &dyn memory::Memory, addr: u16, t: Type, count: u16) {
    let size = match t {
        Type::Byte => 1,
        Type::Word => 2,
        Type::Dword => 4,
        Type::Qword => 8,
    };
    if count == 1 {
        let val = get_value(mem, addr, t);
        match val {
            Some(x) => println!("[0x{:04X}] = \x1b[1m{:X}\x1b[0m ({})", addr, x, x),
            None => println!("[0x{:04X}] = X", addr),
        };
    } else {
        print!("\x1b[1m");
        for i in 0..count {
            let val = get_value(mem, addr + i * size, t);
            match val {
                Some(x) => print!("{:0width$X} ", x, width = (size * 2).into()),
                None => print!("XX"),
            }
        }
        println!("\x1b[0m");
    }
}

fn tui_thread(
    ctrlc_pressed: Arc<AtomicBool>,
    mut system: System,
    syms: SymMap,
    mut startup_commands: Vec<String>,
    terminate_signal_souce: Option<mpsc::Sender<()>>,
) {
    let mut state = machine::State::new();
    let mut last_input = "\n".to_string();
    let mut rl = Editor::<()>::new();
    let z80 = z80::Z80EmuState::new(&syms);
    loop {
        match syms.associate_line(state.ip) {
            Some((filename, line)) => println!("{}:{}", filename, line),
            None => {}
        }
        state.fancy_print();
        print!("    {:14}", machine::disasm_one(&system, state.ip));
        match syms.associate_address(state.ip) {
            Some((sym, offset)) => println!("{} + 0x{:X}", sym, offset),
            None => {}
        }
        if let Some(ref s) = z80 {
            s.fancy_print(&system);
        }
        let mut input = match startup_commands.pop() {
            Some(s) => {
                println!("> {}", s);
                s
            }
            None => match rl.readline("> ") {
                Ok(l) => l,
                Err(ReadlineError::Eof) => break,
                Err(ReadlineError::Interrupted) => continue,
                Err(e) => {
                    println!("Error {:?}", e);
                    return;
                }
            },
        };
        if input == "" {
            input = last_input.clone();
        } else {
            last_input = input.clone();
        }
        ctrlc_pressed.store(false, Ordering::SeqCst);
        let cmd = parse_command(&syms, &input, &mut rl);
        let cmd = match cmd {
            Err(ParseError::BadCommand) => {
                println!("bad command");
                continue;
            }
            Err(ParseError::BadArgument) => {
                println!("bad argument");
                rl.add_history_entry(input.as_str());
                continue;
            }
            Ok(cmd) => {
                rl.add_history_entry(input.as_str());
                cmd
            }
        };
        let result = match cmd {
            Command::Quit => break,
            Command::Next => state.step(&mut system),
            Command::NextLine => state.step_line(&mut system, &syms, &ctrlc_pressed),
            Command::Until(x) => state.until(&mut system, Some(x), &ctrlc_pressed),
            Command::Run => state.until(&mut system, None, &ctrlc_pressed),
            Command::Breakpoint(x) => {
                let id = state.set_breakpoint(x);
                println!("Breakpoint {} at 0x{:04X}", id, x);
                StepResult::Ok
            }
            Command::Delete(x) => {
                state.del_breakpoint(x);
                StepResult::Ok
            }
            Command::Print(addr, t, count) => {
                dump_mem(&system, addr, t, count);
                StepResult::Ok
            }
            Command::Poke(addr, t, val) => {
                if let Err(e) = set_value(&mut system, addr, t, val) {
                    StepResult::WriteError(addr, e)
                } else {
                    StepResult::Ok
                }
            }
            Command::Check(addr, t, val) => {
                let got = get_value(&system, addr, t);
                if got == Some(val) {
                    StepResult::Ok
                } else {
                    println!(
                        "Check failed: address 0x{:04X}, expected {}, got {:?}",
                        addr, val, got
                    );
                    std::process::exit(1)
                }
            }
            Command::Press(v) => {
                match system.get_keyboard_mut() {
                    Some(kbd) => {
                        kbd.press(v);
                        match v {
                            Some((r, c)) => println!("Pressed {}, {}.", r, c),
                            None => println!("Released."),
                        }
                    }
                    None => {
                        println!(
                            "No keyboard in current configuration. Try running without --plain."
                        );
                    }
                }
                StepResult::Ok
            }
            Command::Png(ref s) => {
                match system.get_vga() {
                    Some(vga) => {
                        match File::create(s) {
                            Err(x) => {
                                println!("Can't open file {}: {}", s, x);
                            }
                            Ok(mut f) => match vga.lock().unwrap().create_image(&mut f) {
                                Ok(()) => {
                                    println!("{} has been written", s);
                                }
                                Err(x) => match x {
                                    _ => println!("Error saving {}: {:?}", s, x),
                                },
                            },
                        };
                    }
                    None => {
                        println!("No VGA in current configuration. Try running without --plain.");
                    }
                }
                StepResult::Ok
            }
            Command::Insert(f) => {
                match system.get_spi_mut() {
                    Some(ref mut spi) => {
                        spi.insert(card::Card::new(f));
                        println!("Inserted.");
                    }
                    None => {
                        println!("No SPI in current configuration. Try running without --plain.");
                    }
                }
                StepResult::Ok
            }
            Command::Eject => {
                match system.get_spi_mut() {
                    Some(spi) => {
                        spi.eject();
                    }
                    None => {}
                }
                StepResult::Ok
            }
        };

        match result {
            StepResult::Ok => {}
            StepResult::Breakpoint(id) => {
                println!("Breakpoint {} reached", id);
            }
            StepResult::Watchpoint(id) => {
                println!("Watchpoint {} reached", id);
            }
            StepResult::ReadError(addr, err) => {
                println!("Read error at 0x{:04X}: {}", addr, err);
            }
            StepResult::WriteError(addr, err) => {
                println!("Write error at 0x{:04X}: {}", addr, err);
            }
        }
    }
    if let Some(src) = terminate_signal_souce {
        src.send(()).ok();
    }
}

fn gui_thread(terminate_signal: mpsc::Receiver<()>, vga_window: VgaWindow) {
    vga_window.run(terminate_signal);
}

fn main() {
    let mut fname_bin = String::new();
    let mut fname_map: Option<String> = None;
    let mut fname_config_param: Option<String> = None;
    let mut startup_commands: Vec<String> = Vec::new();
    {
        let mut ap = ArgumentParser::new();
        ap.set_description("CCPU simulator");
        ap.refer(&mut startup_commands)
            .add_option(&["-c"], Collect, "Commands to run on startup");
        ap.refer(&mut fname_config_param).add_option(
            &["--config"],
            StoreOption,
            "Config file (default: rsim.yaml in current directory)",
        );
        ap.refer(&mut fname_bin)
            .add_argument("file", Store, "Program file");
        ap.refer(&mut fname_map)
            .add_argument("mapfile", StoreOption, "Label map file");
        ap.parse_args_or_exit();
    }

    let fname_config = fname_config_param.unwrap_or("rsim.yaml".to_string());

    startup_commands.reverse();

    let path_bin: PathBuf = fname_bin.into();
    let path_map: PathBuf = fname_map
        .map(|s| s.into())
        .unwrap_or_else(|| path_bin.with_extension("map"));

    let mut file_bin = File::open(path_bin.clone())
        .unwrap_or_else(|e| panic!("Can't open {}: {}", path_bin.display(), e));
    let mut file_map =
        File::open(path_map).unwrap_or_else(|e| panic!("Can't open {}: {}", path_bin.display(), e));
    let config = Config::new(&fname_config)
        .unwrap_or_else(|e| panic!("Can't open config {}: {:?}", fname_config, e));
    println!("{:?}", &config);
    let system = system::System::new(&config, &mut file_bin).expect("Can't load");
    let syms = symmap::SymMap::load(&mut file_map).expect("Symbol load failed");

    let ctrlc_pressed = Arc::new(AtomicBool::new(false));
    {
        let r = ctrlc_pressed.clone();
        ctrlc::set_handler(move || {
            r.store(true, Ordering::SeqCst);
        })
        .expect("Error setting Ctrl-C handler");
    }

    let vga_window = VgaWindow::new(system.get_vga(), system.get_ps2());

    if let Some(vga_window) = vga_window {
        let (terminate_signal_source, terminate_signal) = mpsc::channel();

        let tui_handle = std::thread::spawn(move || {
            tui_thread(
                ctrlc_pressed,
                system,
                syms,
                startup_commands,
                Some(terminate_signal_source),
            )
        });
        gui_thread(terminate_signal, vga_window);
        tui_handle.join().unwrap();
    } else {
        tui_thread(ctrlc_pressed, system, syms, startup_commands, None)
    }
}
