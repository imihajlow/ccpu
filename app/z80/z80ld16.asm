    .global z80_regs_origin
    .global z80_f
    .global z80_a
    .global z80_bc
    .global z80_c
    .global z80_b
    .global z80_de
    .global z80_e
    .global z80_d
    .global z80_hl
    .global z80_l
    .global z80_h
    .global z80_f_s
    .global z80_a_s
    .global z80_bc_s
    .global z80_c_s
    .global z80_b_s
    .global z80_de_s
    .global z80_e_s
    .global z80_d_s
    .global z80_hl_s
    .global z80_l_s
    .global z80_h_s
    .global z80_ix
    .global z80_iy
    .global z80_sp
    .global z80_i
    .global z80_r
    .global z80_pc
    .global z80_current_opcode
    .global z80_prefix
    .global z80_indir_src

    .global z80_reset_prefix
    .global z80_imm0
    .global z80_imm1

    .export opcode_ld_bc_imm16
    .export opcode_ld_de_imm16
    .export opcode_ld_hl_imm16
    .export opcode_ld_sp_imm16

    ; 16-bit load group

    ; 01
    ; LD BC, nn
    .section text.opcode_ld_bc_imm16
opcode_ld_bc_imm16:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  b
    ldi pl, lo(z80_bc)
    st  a
    inc pl
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; 11
    ; LD DE, nn
    .section text.opcode_ld_de_imm16
opcode_ld_de_imm16:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  b
    ldi pl, lo(z80_de)
    st  a
    inc pl
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; 31
    ; LD SP, nn
    .section text.opcode_ld_sp_imm16
opcode_ld_sp_imm16:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  b
    ldi pl, lo(z80_sp)
    st  a
    inc pl
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; 21, DD 21, FD 21
    ; LD HL, nn
    ; LD IX, nn
    ; LD IY, nn
    .section text.opcode_ld_hl_imm16
opcode_ld_hl_imm16:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(ld_hl)
    ldi pl, lo(ld_hl)
    jz ; no prefix
    ldi ph, hi(ld_iy)
    ldi pl, lo(ld_iy)
    js ; FD

ld_ix:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  b
    ldi pl, lo(z80_ix)
    st  a
    inc pl
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    .section text.ld_iy
ld_iy:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  b
    ldi pl, lo(z80_iy)
    st  a
    inc pl
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    .section text.ld_hl
ld_hl:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  b
    ldi pl, lo(z80_hl)
    st  a
    inc pl
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

