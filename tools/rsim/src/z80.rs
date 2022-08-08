use crate::memory;
use crate::symmap::SymMap;

pub struct Z80EmuState {
    addr_a: u16,
    addr_f: u16,
    addr_bc: u16,
    addr_de: u16,
    addr_hl: u16,
    addr_sp: u16,
    addr_ix: u16,
    addr_iy: u16,
    addr_pc: u16,
    addr_opcode: u16,
    addr_prefix: u16,
    addr_imm: u16,
}

impl Z80EmuState {
    pub fn new(symmap: &SymMap) -> Option<Self> {
        Some(Self {
            addr_a: symmap.find_exact_global_symbol("z80_a")?,
            addr_f: symmap.find_exact_global_symbol("z80_f")?,
            addr_bc: symmap.find_exact_global_symbol("z80_bc")?,
            addr_de: symmap.find_exact_global_symbol("z80_de")?,
            addr_hl: symmap.find_exact_global_symbol("z80_hl")?,
            addr_sp: symmap.find_exact_global_symbol("z80_sp")?,
            addr_ix: symmap.find_exact_global_symbol("z80_ix")?,
            addr_iy: symmap.find_exact_global_symbol("z80_iy")?,
            addr_pc: symmap.find_exact_global_symbol("z80_pc")?,
            addr_opcode: symmap.find_exact_global_symbol("z80_current_opcode")?,
            addr_prefix: symmap.find_exact_global_symbol("z80_prefix")?,
            addr_imm: symmap.find_exact_global_symbol("z80_imm0")?,
        })
    }

    pub fn fancy_print(&self, mem: &dyn memory::Memory) {
        let a = mem.get(self.addr_a).unwrap();
        let f = mem.get(self.addr_f).unwrap();
        let bc = mem.get_u16(self.addr_bc).unwrap();
        let de = mem.get_u16(self.addr_de).unwrap();
        let hl = mem.get_u16(self.addr_hl).unwrap();
        let sp = mem.get_u16(self.addr_sp).unwrap();
        let ix = mem.get_u16(self.addr_ix).unwrap();
        let iy = mem.get_u16(self.addr_iy).unwrap();
        let pc = mem.get_u16(self.addr_pc).unwrap();
        let opcode = mem.get(self.addr_opcode).unwrap();
        let prefix = mem.get(self.addr_prefix).unwrap();
        let imm = mem.get_u16(self.addr_imm).unwrap();

        println!("A  \x1b[1m{:02X}\x1b[0m   F  \x1b[1m{}\x1b[0m", a, get_flags_string(f));
        println!("BC \x1b[1m{:04X}\x1b[0m DE \x1b[1m{:04X}\x1b[0m", bc, de);
        println!("HL \x1b[1m{:04X}\x1b[0m SP \x1b[1m{:04X}\x1b[0m", hl, sp);
        println!("IX \x1b[1m{:04X}\x1b[0m IY \x1b[1m{:04X}\x1b[0m", ix, iy);
        println!("PC \x1b[1m{:04X}\x1b[0m op \x1b[1m{:02X}\x1b[0m pr \x1b[1m{:02X}\x1b[0m imm \x1b[1m{:04X}\x1b[0m", pc, opcode, prefix, imm);

    }
}

/*
.const z80_cf = 1
.const z80_nf = 2
.const z80_pf = 4
.const z80_hf = 0x10
.const z80_zf = 0x40
.const z80_sf = 0x80
*/
fn get_flags_string(f: u8) -> String {
    format!("[{}{} {} {}{}{}]",
        if f & 0x80 != 0 { 'S' } else { ' ' },
        if f & 0x40 != 0 { 'Z' } else { ' ' },
        if f & 0x10 != 0 { 'H' } else { ' ' },
        if f & 0x04 != 0 { 'P' } else { ' ' },
        if f & 0x02 != 0 { 'N' } else { ' ' },
        if f & 0x01 != 0 { 'C' } else { ' ' }
        )
}
