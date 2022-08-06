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

    .export opcode_cpl
    .export opcode_ccf
    .export opcode_scf

    ; General purpose AF operation

    .section text.af_arithm
    ; 2F
opcode_cpl:
    ldi ph, hi(z80_a)
    ldi pl, lo(z80_a)
    ld  a
    not a
    st  a
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_nf | z80_hf
    or  a, b
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; 3F
opcode_ccf:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  b
    ; h := c
    ; n := 0
    ; c := !c
    ldi a, ~(z80_nf | z80_hf)
    and b, a
    mov a, b
    shr a
    exp a
    ldi pl, z80_hf
    and a, pl
    or  b, a
    ldi a, z80_cf
    xor b, a
    ldi pl, lo(z80_f)
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; 37
opcode_scf:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  b
    ldi a, ~(z80_nf | z80_hf)
    and b, a
    ldi a, z80_cf
    or  b, a
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp
