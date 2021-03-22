mod instruction;
mod memory;
mod machine;
mod plain_ram;

use std::env;
use std::fs::File;
use std::io;
use std::io::Write;
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::Arc;
use ctrlc;

enum Command {
    Error,
    Next,
    Until(u16),
    Run,
    Quit,
}

fn parse_command(s: &String) -> Command {
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
            match iter.next().unwrap_or("").parse::<u16>() {
                Ok(x) => Until(x),
                _ => Error
            }
        },

        Some("r") |
        Some("run") => Run,

        _ => Error
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();

    let fname = &args[1];
    let mut file = File::open(fname).expect("Can't open");
    let mut ram = plain_ram::PlainRam::load(&mut file).expect("Read failed");

    let ctrlc_pressed = Arc::new(AtomicBool::new(false));
    {
        let r = ctrlc_pressed.clone();
        ctrlc::set_handler(move || {
            r.store(true, Ordering::SeqCst);
        }).expect("Error setting Ctrl-C handler");
    }

    let mut state = machine::State::new();
    loop {
        machine::disasm(&ram, state.ip, state.ip).expect("Can't disasm");
        println!("{}", &state);
        print!("> ");
        io::stdout().flush().unwrap();
        let mut input = String::new();
        io::stdin().read_line(&mut input).unwrap();
        ctrlc_pressed.store(false, Ordering::SeqCst);
        let result = match parse_command(&input) {
            Command::Quit => break,
            Command::Next => state.step(&mut ram),
            Command::Until(x) => state.until(&mut ram, Some(x), &ctrlc_pressed),
            Command::Run => state.until(&mut ram, None, &ctrlc_pressed),
            Command::Error => {
                println!("Bad command");
                Ok(machine::StepResult::Ok)
            }
        };

        match result {
            Ok(machine::StepResult::Ok) => {
            },
            Ok(machine::StepResult::Breakpoint(id)) => {
                println!("Breakpoint {} reached", id);
            }
            Ok(_) => {
            },
            Err(e) => {
                println!("Can't execute {:?}", e);
            }
        }
    }
}
