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
    .global z80_tmp

    .export opcode_ld_bc_imm16
    .export opcode_ld_de_imm16
    .export opcode_ld_hl_imm16
    .export opcode_ld_sp_imm16

    .export opcode_ld_bc_indir_imm16
    .export opcode_ld_de_indir_imm16
    .export opcode_ld_sp_indir_imm16
    .export opcode_ld_hl_indir_imm16

    .export opcode_ld_indir_bc
    .export opcode_ld_indir_de
    .export opcode_ld_indir_sp
    .export opcode_ld_indir_hl

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

    .section text.opcode_ld_bc_indir_imm16
    ; ED 4B
    ; ld bc, (nn)
opcode_ld_bc_indir_imm16:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  b
    mov a, 0
    inc pl
    adc ph, a
    ld  a
    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc)
    st  b
    inc pl
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    .section text.opcode_ld_de_indir_imm16
    ; ED 5B
    ; ld de, (nn)
opcode_ld_de_indir_imm16:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  b
    mov a, 0
    inc pl
    adc ph, a
    ld  a
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    st  b
    inc pl
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    .section text.opcode_ld_sp_indir_imm16
    ; ED 7B
    ; ld sp, (nn)
opcode_ld_sp_indir_imm16:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  b
    mov a, 0
    inc pl
    adc ph, a
    ld  a
    ldi ph, hi(z80_sp)
    ldi pl, lo(z80_sp)
    st  b
    inc pl
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    .section text.opcode_ld_hl_indir_imm16
    ; 2A, DD 2A, FD 2a
    ; ld hl, (nn)
    ; ld ix, (nn)
    ; ld iy, (nn)
opcode_ld_hl_indir_imm16:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(ld_hl_indir)
    ldi pl, lo(ld_hl_indir)
    jz ; no prefix
    ldi ph, hi(ld_iy_indir)
    ldi pl, lo(ld_iy_indir)
    js ; FD

ld_ix_indir:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  b
    mov a, 0
    inc pl
    adc ph, a
    ld  a
    ldi ph, hi(z80_ix)
    ldi pl, lo(z80_ix)
    st  b
    inc pl
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    .section text.ld_iy_indir
ld_iy_indir:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  b
    mov a, 0
    inc pl
    adc ph, a
    ld  a
    ldi ph, hi(z80_iy)
    ldi pl, lo(z80_iy)
    st  b
    inc pl
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    .section text.ld_hl_indir
ld_hl_indir:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  b
    mov a, 0
    inc pl
    adc ph, a
    ld  a
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    st  b
    inc pl
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    .section text.opcode_ld_indir_bc
opcode_ld_indir_bc:
    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc)
    ld  b
    inc pl
    ld  a
    ldi pl, lo(z80_tmp)
    st  a

    ldi ph, hi(ld_indir_from_tmp)
    ldi pl, lo(ld_indir_from_tmp)
    jmp

    .section text.opcode_ld_indir_de
opcode_ld_indir_de:
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    ld  b
    inc pl
    ld  a
    ldi pl, lo(z80_tmp)
    st  a

    ldi ph, hi(ld_indir_from_tmp)
    ldi pl, lo(ld_indir_from_tmp)
    jmp

    .section text.opcode_ld_indir_sp
opcode_ld_indir_sp:
    ldi ph, hi(z80_sp)
    ldi pl, lo(z80_sp)
    ld  b
    inc pl
    ld  a
    ldi pl, lo(z80_tmp)
    st  a

    ldi ph, hi(ld_indir_from_tmp)
    ldi pl, lo(ld_indir_from_tmp)
    jmp

    .section text.opcode_ld_indir_hl
opcode_ld_indir_hl:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(ld_indir_hl)
    ldi pl, lo(ld_indir_hl)
    jz ; no prefix
    ldi ph, hi(ld_indir_iy)
    ldi pl, lo(ld_indir_iy)
    js ; FD

ld_indir_ix:
    ldi ph, hi(z80_ix)
    ldi pl, lo(z80_ix)
    ld  b
    inc pl
    ld  a
    ldi pl, lo(z80_tmp)
    st  a

    ldi ph, hi(ld_indir_from_tmp)
    ldi pl, lo(ld_indir_from_tmp)
    jmp

    .section text.ld_indir_iy
ld_indir_iy:
    ldi ph, hi(z80_iy)
    ldi pl, lo(z80_iy)
    ld  b
    inc pl
    ld  a
    ldi pl, lo(z80_tmp)
    st  a

    ldi ph, hi(ld_indir_from_tmp)
    ldi pl, lo(ld_indir_from_tmp)
    jmp

    .section text.ld_indir_hl
ld_indir_hl:
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  b
    inc pl
    ld  a
    ldi pl, lo(z80_tmp)
    st  a

    ; [z80_imm0] <- b
    ; [z80_imm0 + 1] <- [z80_tmp]
ld_indir_from_tmp:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    st  b
    ldi ph, hi(z80_tmp)
    ldi pl, lo(z80_tmp)
    ld  b
    ldi pl, lo(z80_imm0 + 1)
    ld  a
    dec pl
    ld  pl
    inc pl
    adc a, 0
    mov ph, a
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp
