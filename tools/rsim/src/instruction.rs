use std::fmt;
use strum_macros::Display;
use crate::memory;

pub enum Instruction {
    ALU { op: AluOperation, inverse: bool, reg: Register },
    LD(Register),
    ST(Register),
    LDI(Register, u8),
    JMP,
    NOP,
    JC { flag: Flag, inverse: bool }
}

#[derive(Display, Debug, Copy, Clone)]
pub enum Register {
    A,
    B,
    PL,
    PH
}

#[derive(Display, Debug, Copy, Clone)]
pub enum AluOperation {
    ADD,
    ADC,
    SUB,
    SBB,
    INC,
    DEC,
    SHR,
    SAR,
    SHL,
    MOV,
    OR,
    AND,
    XOR,
    NOT,
    NEG,
    EXP
}

#[derive(Display, Debug, Copy, Clone)]
pub enum Flag {
    CARRY,
    ZERO,
    SIGN,
    OVERFLOW
}

impl AluOperation {
    fn is_single_arg(&self) -> bool {
        use AluOperation::*;
        match self {
            INC | DEC | SHR | SAR | SHL | NOT | NEG | EXP => true,
            _ => false
        }
    }
}

impl fmt::Display for Instruction {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Instruction::ALU { op, inverse: false, .. } if op.is_single_arg() =>
                write!(f, "{} A", op),
            Instruction::ALU { op, inverse: false, reg: Register::A } =>
                write!(f, "{} A, 0", op),
            Instruction::ALU { op, inverse: false, reg } =>
                write!(f, "{} A, {}", op, reg),
            Instruction::ALU { op, inverse: true, reg } if op.is_single_arg() =>
                write!(f, "{} {}", op, reg),
            Instruction::ALU { op, inverse: true, reg } =>
                write!(f, "{} {}, A", op, reg),
            Instruction::LD(reg) =>
                write!(f, "LD {}", reg),
            Instruction::ST(reg) =>
                write!(f, "ST {}", reg),
            Instruction::LDI(reg, value) =>
                write!(f, "LDI {}, 0x{:02X}", reg, value),
            Instruction::JMP =>
                write!(f, "JMP"),
            Instruction::NOP =>
                write!(f, "NOP"),
            Instruction::JC { flag: Flag::CARRY, inverse: false } =>
                write!(f, "JC"),
            Instruction::JC { flag: Flag::ZERO, inverse: false } =>
                write!(f, "JZ"),
            Instruction::JC { flag: Flag::SIGN, inverse: false } =>
                write!(f, "JS"),
            Instruction::JC { flag: Flag::OVERFLOW, inverse: false } =>
                write!(f, "JO"),
            Instruction::JC { flag: Flag::CARRY, inverse: true } =>
                write!(f, "JNC"),
            Instruction::JC { flag: Flag::ZERO, inverse: true } =>
                write!(f, "JNZ"),
            Instruction::JC { flag: Flag::SIGN, inverse: true } =>
                write!(f, "JNS"),
            Instruction::JC { flag: Flag::OVERFLOW, inverse: true } =>
                write!(f, "JNO")
        }
    }
}

fn is_alu(op: u8) -> bool {
    op & 0x80 == 0
}

fn is_ld(op: u8) -> bool {
    op & 0xE0 == 0x80
}

fn is_st(op: u8) -> bool {
    op & 0xE0 == 0xA0
}

fn is_ldi(op: u8) -> bool {
    op & 0xE0 == 0xC0
}

fn is_jc(op: u8) -> bool {
    op & 0xE8 == 0xE0
}

fn is_jmp(op: u8) -> bool {
    op & 0xEC == 0xE8
}

fn is_nop(op: u8) -> bool {
    op & 0xEC == 0xEC
}

fn alu_op(op: u8) -> AluOperation {
    use AluOperation::*;
    match (op >> 3) & 0xf {
        0 => EXP,
        1 => AND,
        2 => OR,
        3 => SHL,
        4 => NOT,
        5 => XOR,
        6 => SHR,
        7 => SAR,
        8 => MOV,
        9 => ADD,
        10 => ADC,
        11 => INC,
        12 => NEG,
        13 => SUB,
        14 => SBB,
        15 => DEC,
        _ => panic!()
    }
}

fn operand(op: u8) -> Register {
    match op & 0x03 {
        0 => Register::A,
        1 => Register::B,
        2 => Register::PL,
        3 => Register::PH,
        _ => panic!()
    }
}

fn operand_st(op: u8) -> Register {
    match op & 0x01 {
        0 => Register::A,
        1 => Register::B,
        _ => panic!()
    }
}

fn jc_flag(op: u8) -> Flag {
    match op & 0x03 {
        0 => Flag::ZERO,
        1 => Flag::CARRY,
        2 => Flag::SIGN,
        3 => Flag::OVERFLOW,
        _ => panic!()
    }
}

impl Instruction {
    pub fn load<T: memory::Memory>(mem: &T, offset: u16) -> Result<(Instruction, u16), memory::MemoryError> {
        let opcode = mem.get(offset)?;
        match opcode {
            _ if is_alu(opcode) => {
                Ok((
                    Instruction::ALU {
                        op: alu_op(opcode),
                        inverse: (opcode & 0x04) != 0,
                        reg: operand(opcode)
                    },
                    offset.wrapping_add(1)
                ))
            },
            _ if is_ld(opcode) => {
                Ok((
                    Instruction::LD(operand(opcode)),
                    offset.wrapping_add(1)
                ))
            },
            _ if is_st(opcode) => {
                Ok((
                    Instruction::ST(operand_st(opcode)),
                    offset.wrapping_add(1)
                ))
            },
            _ if is_jmp(opcode) => {
                Ok((
                    Instruction::JMP,
                    offset.wrapping_add(1)
                ))
            },
            _ if is_nop(opcode) => {
                Ok((
                    Instruction::NOP,
                    offset.wrapping_add(1)
                ))
            },
            _ if is_jc(opcode) => {
                Ok((
                    Instruction::JC {
                        flag: jc_flag(opcode),
                        inverse: (opcode & 0x04) != 0
                    },
                    offset.wrapping_add(1)
                ))
            },
            _ if is_ldi(opcode) => {
                let imm = mem.get(offset.wrapping_add(1))?;
                Ok((
                    Instruction::LDI (
                        operand(opcode),
                        imm
                    ),
                    offset.wrapping_add(2)
                ))
            },
            _ => panic!("Unhandled op: {}", opcode)
        }
    }
}
