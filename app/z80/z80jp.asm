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

    .export opcode_jp
    .export opcode_jp_c
    .export opcode_jp_nc
    .export opcode_jp_z
    .export opcode_jp_nz
    .export opcode_jp_pe
    .export opcode_jp_po
    .export opcode_jp_p
    .export opcode_jp_m

    ; jump group

    .section text.opcode_jp
    ; C3
opcode_jp:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  b
    ldi pl, lo(z80_pc)
    st  a
    inc pl
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; DA
opcode_jp_c:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shr a
    ldi ph, hi(opcode_jp)
    ldi pl, lo(opcode_jp)
    jc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; D2
opcode_jp_nc:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shr a
    ldi ph, hi(opcode_jp)
    ldi pl, lo(opcode_jp)
    jnc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; CA
opcode_jp_z:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_zf
    and a, b
    ldi ph, hi(opcode_jp)
    ldi pl, lo(opcode_jp)
    jnz
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; C2
opcode_jp_nz:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_zf
    and a, b
    ldi ph, hi(opcode_jp)
    ldi pl, lo(opcode_jp)
    jz
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; EA
opcode_jp_pe:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_pf
    and a, b
    ldi ph, hi(opcode_jp)
    ldi pl, lo(opcode_jp)
    jnz
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; E2
opcode_jp_po:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_pf
    and a, b
    ldi ph, hi(opcode_jp)
    ldi pl, lo(opcode_jp)
    jz
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; FA
opcode_jp_m:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    ldi ph, hi(opcode_jp)
    ldi pl, lo(opcode_jp)
    jc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; F2
opcode_jp_p:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    ldi ph, hi(opcode_jp)
    ldi pl, lo(opcode_jp)
    jnc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp
