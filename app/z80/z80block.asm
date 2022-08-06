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
    .global z80_tmp2

    .global z80_cf
    .global z80_nf
    .global z80_pf
    .global z80_hf
    .global z80_zf
    .global z80_sf
    .global z80_not_implemented

    .global set_flags

    .export opcode_ldi
    .export opcode_ldd
    .export opcode_ldir
    .export opcode_lddr

    .section text.block
opcode_ldi:
    ; transfer (de) <- (hl)
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  b
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    st  b
    ; increment hl
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl + 1)
    ld  a
    dec pl
    ld  b
    inc b
    st  b
    adc a, 0
    inc pl
    st  a
    ; increment de
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de + 1)
    ld  a
    dec pl
    ld  b
    inc b
    st  b
    adc a, 0
    inc pl
    st  a
    ; decrement bc
    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc + 1)
    ld  a
    dec pl
    ld  b
    dec b
    st  b
    sbb a, 0
    inc pl
    st  a
    or  a, b
    ldi ph, hi(set_flags_z)
    ldi pl, lo(set_flags_z)
    jz
set_flags_nz:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_sf | z80_zf | z80_cf
    and a, b
    ldi b, z80_pf
    or  a, b
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp
set_flags_z:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_sf | z80_zf | z80_cf
    and a, b
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp


opcode_ldd:
    ; transfer (de) <- (hl)
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  b
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    st  b
    ; decrement hl
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl + 1)
    ld  a
    dec pl
    ld  b
    dec b
    st  b
    sbb a, 0
    inc pl
    st  a
    ; decrement de
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de + 1)
    ld  a
    dec pl
    ld  b
    dec b
    st  b
    sbb a, 0
    inc pl
    st  a
    ; decrement bc
    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc + 1)
    ld  a
    dec pl
    ld  b
    dec b
    st  b
    sbb a, 0
    inc pl
    st  a
    or  a, b
    ldi ph, hi(set_flags_nz)
    ldi pl, lo(set_flags_nz)
    jnz
    ldi ph, hi(set_flags_z)
    ldi pl, lo(set_flags_z)
    jmp

opcode_ldir:
    ; transfer (de) <- (hl)
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  b
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    st  b
    ; increment hl
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl + 1)
    ld  a
    dec pl
    ld  b
    inc b
    st  b
    adc a, 0
    inc pl
    st  a
    ; increment de
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de + 1)
    ld  a
    dec pl
    ld  b
    inc b
    st  b
    adc a, 0
    inc pl
    st  a
    ; decrement bc
    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc + 1)
    ld  a
    dec pl
    ld  b
    dec b
    st  b
    sbb a, 0
    inc pl
    st  a
    or  a, b
    ldi ph, hi(opcode_ldir)
    ldi pl, lo(opcode_ldir)
    jnz
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_sf | z80_zf | z80_cf
    and a, b
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

opcode_lddr:
    ; transfer (de) <- (hl)
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  b
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    st  b
    ; decrement hl
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl + 1)
    ld  a
    dec pl
    ld  b
    dec b
    st  b
    sbb a, 0
    inc pl
    st  a
    ; decrement de
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de + 1)
    ld  a
    dec pl
    ld  b
    dec b
    st  b
    sbb a, 0
    inc pl
    st  a
    ; decrement bc
    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc + 1)
    ld  a
    dec pl
    ld  b
    dec b
    st  b
    sbb a, 0
    inc pl
    st  a
    or  a, b
    ldi ph, hi(opcode_lddr)
    ldi pl, lo(opcode_lddr)
    jnz
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_sf | z80_zf | z80_cf
    and a, b
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp
