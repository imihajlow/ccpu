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

    .global z80_reset_prefix

    .export opcode_ld_rr
    .export opcode_ld_r_indir
    .export opcode_ld_indir_r

    .section text.ld
    ; ================================
    ; 40-6F, 78-7F excluding *6 and *E
opcode_ld_rr:
    ; ED 57, ED 5F, ED 47, ED 4F aren't supported
    ; same PH through the whole function
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  b
    ldi a, 0x07
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ; PH:PL = source Z80 register
    ld  b
    ldi pl, lo(z80_current_opcode)
    ld  a

    ; b = source value
    ; a = opcode
    shr a
    shr a
    shr a
    ; a = (destination register number) | 0x8
    ldi pl, lo(z80_regs_origin + 8)
    sub pl, a
    st  a

    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

    ; ================================
    ; 46, 4E, 56, 5E, 66, 6E
opcode_ld_r_indir:
    ldi ph, 
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

opcode_ld_indir_r:
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

    .section bss.ld
source: res 1
