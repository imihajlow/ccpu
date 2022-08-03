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

    .export opcode_ex_de_hl
    .export opcode_exx
    .export opcode_ex_af

    ; exchange instructions

    .section text.opcode_ex_de_hl
    ; EB
opcode_ex_de_hl:
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    ld  a
    ldi pl, lo(z80_hl)
    ld  b
    st  a
    inc pl
    ld  a
    ldi pl, lo(z80_de)
    st  b
    inc pl
    ld  b
    st  a
    ldi pl, lo(z80_hl + 1)
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp


    .section text.opcode_ex_af
    ; 08
opcode_ex_af:
    ldi ph, hi(z80_a)
    ldi pl, lo(z80_a)
    ld  a
    ldi pl, lo(z80_a_s)
    ld  b
    st  a
    ldi pl, lo(z80_a)
    st  b
    ldi pl, lo(z80_f)
    ld  a
    ldi pl, lo(z80_f_s)
    ld  b
    st  a
    ldi pl, lo(z80_f)
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    .section text.opcode_exx
    ; D9
opcode_exx:
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    ld  a
    ldi pl, lo(z80_de_s)
    ld  b
    st  a
    inc pl
    ld  a
    ldi pl, lo(z80_de)
    st  b
    inc pl
    ld  b
    st  a
    ldi pl, lo(z80_de_s + 1)
    st  b

    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc)
    ld  a
    ldi pl, lo(z80_bc_s)
    ld  b
    st  a
    inc pl
    ld  a
    ldi pl, lo(z80_bc)
    st  b
    inc pl
    ld  b
    st  a
    ldi pl, lo(z80_bc_s + 1)
    st  b

    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    ldi pl, lo(z80_hl_s)
    ld  b
    st  a
    inc pl
    ld  a
    ldi pl, lo(z80_hl)
    st  b
    inc pl
    ld  b
    st  a
    ldi pl, lo(z80_hl_s + 1)
    st  b

    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp
