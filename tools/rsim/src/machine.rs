use crate::instruction;
use crate::instruction::AluOperation;
use crate::instruction::Instruction;
use crate::memory::{Memory, MemoryReadError, MemoryWriteError};
use crate::symmap::SymMap;
use std::fmt;
use std::ops::Deref;
use std::sync::atomic::{AtomicBool, Ordering};

#[derive(Debug)]
pub enum StepResult {
    Ok,
    ReadError(u16, MemoryReadError),
    WriteError(u16, MemoryWriteError),
    Breakpoint(u32),
    Watchpoint(u32),
}

pub struct State {
    pub ip: u16,
    pub a: u8,
    pub b: u8,
    pub p: u16,
    pub flags: Flags,

    breakpoints: Vec<(u32, u16)>,
    last_id: u32,
}

pub struct Flags {
    pub carry: bool,
    pub zero: bool,
    pub sign: bool,
    pub overflow: bool,
}

impl State {
    pub fn new() -> State {
        State {
            ip: 0,
            a: 0,
            b: 0,
            p: 0,
            flags: Flags::new(),
            breakpoints: Vec::new(),
            last_id: 0,
        }
    }
}

impl Flags {
    fn new() -> Flags {
        Flags {
            carry: false,
            zero: false,
            sign: false,
            overflow: false,
        }
    }
}

impl State {
    fn get_flag(&self, flag: instruction::Flag) -> bool {
        use instruction::Flag::*;
        match flag {
            ZERO => self.flags.zero,
            CARRY => self.flags.carry,
            SIGN => self.flags.sign,
            OVERFLOW => self.flags.overflow,
        }
    }

    fn get_reg(&self, reg: instruction::Register) -> u8 {
        use instruction::Register::*;
        match reg {
            A => self.a,
            B => self.b,
            PL => self.p.to_le_bytes()[0],
            PH => self.p.to_le_bytes()[1],
        }
    }

    fn get_alu_b(&self, reg: instruction::Register) -> u8 {
        use instruction::Register::*;
        match reg {
            A => 0,
            B => self.b,
            PL => self.p.to_le_bytes()[0],
            PH => self.p.to_le_bytes()[1],
        }
    }

    fn set_reg(&mut self, reg: instruction::Register, value: u8) {
        use instruction::Register::*;
        match reg {
            A => self.a = value,
            B => self.b = value,
            PL => self.p = u16::from_le_bytes([value, self.get_reg(PH)]),
            PH => self.p = u16::from_le_bytes([self.get_reg(PL), value]),
        };
    }
}

impl fmt::Display for Flags {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "[{}{}{}{}]",
            if self.zero { "Z" } else { " " },
            if self.carry { "C" } else { " " },
            if self.sign { "S" } else { " " },
            if self.overflow { "O" } else { " " }
        )
    }
}

impl fmt::Display for State {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(
            f,
            "IP={:04X} A={:02X} B={:02X} P={:04X} F={}",
            self.ip, self.a, self.b, self.p, self.flags
        )
    }
}

impl State {
    pub fn fancy_print(&self) {
        print!("IP=\x1b[1m{:04X}\x1b[0m A=\x1b[1m{:02X}\x1b[0m B=\x1b[1m{:02X}\x1b[0m P=\x1b[1m{:04X}\x1b[0m F={}",
            self.ip, self.a, self.b, self.p, self.flags);
    }
}

pub fn disasm(mem: &dyn Memory, start: u16, end: u16) -> () {
    let mut ip = start;
    while ip <= end {
        if let Ok((instr, new_ip)) = Instruction::load(mem, ip) {
            println!("{:04X} {}", ip, instr);
            ip = new_ip;
        } else {
            println!("{:04X} error", ip);
            return;
        }
    }
}

pub fn disasm_one(mem: &dyn Memory, ip: u16) -> String {
    if let Ok((instr, _)) = Instruction::load(mem, ip) {
        format!("{}", instr)
    } else {
        "error".to_string()
    }
}

fn gen_ovf(a: u8, b: u8, r: u8, is_sum: bool) -> bool {
    let a_bit = a & 0x80 != 0;
    let b_bit = match is_sum {
        true => b & 0x80 != 0,
        false => b & 0x80 == 0,
    };
    let r_bit = r & 0x80 != 0;
    if a_bit == b_bit {
        return a_bit != r_bit;
    } else {
        return false;
    }
}

fn exec_alu(op: AluOperation, arg1: u8, arg2: u8, old_flags: &Flags) -> (u8, Flags) {
    use AluOperation::*;
    let (r, c) = match op {
        MOV => (arg2, false),
        ADD => arg1.overflowing_add(arg2),
        ADC => {
            let (r0, c0) = arg1.overflowing_add(arg2);
            let (r1, c1) = r0.overflowing_add(old_flags.carry as u8);
            (r1, c0 || c1)
        }
        SUB => arg1.overflowing_sub(arg2),
        SBB => {
            let (r0, c0) = arg1.overflowing_sub(arg2);
            let (r1, c1) = r0.overflowing_sub(old_flags.carry as u8);
            (r1, c0 || c1)
        }
        INC => arg1.overflowing_add(1),
        DEC => arg1.overflowing_sub(1),
        NEG => ((!arg1).wrapping_add(1), arg1 != 0),
        NOT => (!arg1, false),
        SHL => {
            let carry = arg1 & 0x80 != 0;
            (arg1 << 1, carry)
        }
        SHR => {
            let c = (arg1 & 1) == 1;
            (arg1 >> 1, c)
        }
        SAR => {
            let c = (arg1 & 1) == 1;
            ((arg1 >> 1) | (arg1 & 0x80), c)
        }
        EXP => {
            if old_flags.carry {
                (0xff, false)
            } else {
                (0, false)
            }
        }
        OR => (arg1 | arg2, false),
        AND => (arg1 & arg2, false),
        XOR => (arg1 ^ arg2, false),
    };

    let ovf = match op {
        ADD | ADC => gen_ovf(arg1, arg2, r, true),
        SUB | SBB => gen_ovf(arg1, arg2, r, false),
        INC => gen_ovf(arg1, 1, r, true),
        DEC => gen_ovf(arg1, 1, r, false),
        NEG => gen_ovf(0, arg1, r, false),
        _ => false,
    };

    if let MOV = op {
        (r, Flags { ..*old_flags })
    } else {
        (
            r,
            Flags {
                carry: c,
                zero: r == 0,
                sign: r & 0x80 != 0,
                overflow: ovf,
            },
        )
    }
}

impl State {
    pub fn set_breakpoint(&mut self, address: u16) -> u32 {
        self.last_id += 1;
        self.breakpoints.push((self.last_id, address));
        return self.last_id;
    }

    pub fn del_breakpoint(&mut self, id_to_del: u32) {
        self.breakpoints.retain(|(id, _)| *id != id_to_del);
    }

    pub fn until<C>(
        &mut self,
        mem: &mut dyn Memory,
        until_addr: Option<u16>,
        ctrlc_pressed: &C,
    ) -> StepResult
    where
        C: Deref<Target = AtomicBool>,
    {
        while !ctrlc_pressed.load(Ordering::SeqCst) {
            match self.step(mem) {
                StepResult::Ok => {}
                x => return x,
            }
            if until_addr == Some(self.ip) {
                break;
            }
        }
        StepResult::Ok
    }

    pub fn step_line<C>(
        &mut self,
        mem: &mut dyn Memory,
        symmap: &SymMap,
        ctrlc_pressed: &C,
    ) -> StepResult
    where
        C: Deref<Target = AtomicBool>,
    {
        while !ctrlc_pressed.load(Ordering::SeqCst) {
            match self.step(mem) {
                StepResult::Ok => {}
                x => return x,
            }
            match symmap.associate_line(self.ip) {
                Some(_) => return StepResult::Ok,
                None => {}
            }
        }
        StepResult::Ok
    }

    pub fn step(&mut self, mem: &mut dyn Memory) -> StepResult {
        let (instr, new_ip) = match Instruction::load(mem, self.ip) {
            Ok(instr) => instr,
            Err(x) => return StepResult::ReadError(self.ip, x),
        };
        match instr {
            Instruction::ALU { op, inverse, reg } => {
                let arg = self.get_alu_b(reg);
                match inverse {
                    true => {
                        let (r, flags) = exec_alu(op, arg, self.a, &self.flags);
                        self.set_reg(reg, r);
                        self.flags = flags;
                    }
                    false => {
                        let (r, flags) = exec_alu(op, self.a, arg, &self.flags);
                        self.a = r;
                        self.flags = flags;
                    }
                }
                self.ip = new_ip;
            }
            Instruction::LD(reg) => {
                let value = match mem.get(self.p) {
                    Ok(x) => x,
                    Err(e) => return StepResult::ReadError(self.p, e),
                };
                self.ip = new_ip;
                self.set_reg(reg, value);
            }
            Instruction::LDI(reg, value) => {
                self.ip = new_ip;
                self.set_reg(reg, value);
            }
            Instruction::ST(reg) => {
                let value = self.get_reg(reg);
                match mem.set(self.p, value) {
                    Ok(()) => {}
                    Err(e) => return StepResult::WriteError(self.p, e),
                }
                self.ip = new_ip;
            }
            Instruction::NOP => {
                self.ip = new_ip;
            }
            Instruction::JMP => {
                self.ip = self.p;
                self.p = new_ip;
            }
            Instruction::JC { flag, inverse } => {
                let flag_value = self.get_flag(flag);
                if flag_value ^ inverse {
                    self.ip = self.p;
                    self.p = new_ip;
                } else {
                    self.ip = new_ip;
                }
            }
        };
        match self.breakpoints.iter().find(|(_, a)| *a == self.ip) {
            Some((id, _)) => StepResult::Breakpoint(*id),
            None => StepResult::Ok,
        }
    }
}
