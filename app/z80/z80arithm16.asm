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

    .global z80_cf
    .global z80_nf
    .global z80_pf
    .global z80_hf
    .global z80_zf
    .global z80_sf

    .export opcode_add_bc_16
    .export opcode_add_de_16
    .export opcode_add_sp_16
    .export opcode_add_hl_hl_16

    ; 16-bit arithmetics
    .section text.opcode_add_bc_16
    ; 09
opcode_add_bc_16:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(add_hl_bc)
    ldi pl, lo(add_hl_bc)
    jz
    ldi ph, hi(add_ix_bc)
    ldi pl, lo(add_ix_bc)
    js

add_ix_bc:
    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc)
    ld  a
    ldi pl, lo(z80_ix)
    ld  b
    add a, b
    st  a
    ldi pl, lo(z80_bc + 1)
    ld  a
    ldi pl, lo(z80_ix + 1)
    ld  b
    adc a, b
    st  a
    ldi pl, lo(set_add_flags)
    ldi ph, hi(set_add_flags)
    jmp

    .section text.add_hl_bc
add_hl_bc:
    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc)
    ld  a
    ldi pl, lo(z80_hl)
    ld  b
    add a, b
    st  a
    ldi pl, lo(z80_bc + 1)
    ld  a
    ldi pl, lo(z80_hl + 1)
    ld  b
    adc a, b
    st  a
    ldi pl, lo(set_add_flags)
    ldi ph, hi(set_add_flags)
    jmp

    .section text.add_iy_bc
add_iy_bc:
    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc)
    ld  a
    ldi pl, lo(z80_iy)
    ld  b
    add a, b
    st  a
    ldi pl, lo(z80_bc + 1)
    ld  a
    ldi pl, lo(z80_iy + 1)
    ld  b
    adc a, b
    st  a
    ldi pl, lo(set_add_flags)
    ldi ph, hi(set_add_flags)
    jmp

    .section text.opcode_add_de_16
    ; 19
opcode_add_de_16:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(add_hl_de)
    ldi pl, lo(add_hl_de)
    jz
    ldi ph, hi(add_iy_de)
    ldi pl, lo(add_iy_de)
    js
add_ix_de:
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    ld  a
    ldi pl, lo(z80_ix)
    ld  b
    add a, b
    st  a
    ldi pl, lo(z80_de + 1)
    ld  a
    ldi pl, lo(z80_ix + 1)
    ld  b
    adc a, b
    st  a
    ldi pl, lo(set_add_flags)
    ldi ph, hi(set_add_flags)
    jmp

    .section text.add_iy_de
add_iy_de:
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    ld  a
    ldi pl, lo(z80_iy)
    ld  b
    add a, b
    st  a
    ldi pl, lo(z80_de + 1)
    ld  a
    ldi pl, lo(z80_iy + 1)
    ld  b
    adc a, b
    st  a
    ldi pl, lo(set_add_flags)
    ldi ph, hi(set_add_flags)
    jmp
    .section text.add_hl_de
add_hl_de:
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    ld  a
    ldi pl, lo(z80_hl)
    ld  b
    add a, b
    st  a
    ldi pl, lo(z80_de + 1)
    ld  a
    ldi pl, lo(z80_hl + 1)
    ld  b
    adc a, b
    st  a
    ldi pl, lo(set_add_flags)
    ldi ph, hi(set_add_flags)
    jmp


    .section text.opcode_add_sp_16
    ; 39
opcode_add_sp_16:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(add_hl_sp)
    ldi pl, lo(add_hl_sp)
    jz
    ldi ph, hi(add_iy_sp)
    ldi pl, lo(add_iy_sp)
    js

add_ix_sp:
    ldi ph, hi(z80_sp)
    ldi pl, lo(z80_sp)
    ld  a
    ldi pl, lo(z80_ix)
    ld  b
    add a, b
    st  a
    ldi pl, lo(z80_sp + 1)
    ld  a
    ldi pl, lo(z80_ix + 1)
    ld  b
    adc a, b
    st  a
    ldi pl, lo(set_add_flags)
    ldi ph, hi(set_add_flags)
    jmp

    .section text.add_iy_sp
add_iy_sp:
    ldi ph, hi(z80_sp)
    ldi pl, lo(z80_sp)
    ld  a
    ldi pl, lo(z80_iy)
    ld  b
    add a, b
    st  a
    ldi pl, lo(z80_sp + 1)
    ld  a
    ldi pl, lo(z80_iy + 1)
    ld  b
    adc a, b
    st  a
    ldi pl, lo(set_add_flags)
    ldi ph, hi(set_add_flags)
    jmp

    .section text.add_hl_sp
add_hl_sp:
    ldi ph, hi(z80_sp)
    ldi pl, lo(z80_sp)
    ld  a
    ldi pl, lo(z80_hl)
    ld  b
    add a, b
    st  a
    ldi pl, lo(z80_sp + 1)
    ld  a
    ldi pl, lo(z80_hl + 1)
    ld  b
    adc a, b
    st  a

    ; S, Z, P are not affected
    ; H is set if carry from bit 11 - not implemented
    ; N is reset
    ; C is set to carry from bit 15
set_add_flags:
    mov a, 0
    adc a, 0
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  b
    mov pl, a
    ldi a, z80_sf | z80_zf | z80_pf
    and a, b
    or  a, pl
    ldi pl, lo(z80_f)
    st  a
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp


    .section text.opcode_add_hl_16
    ; 29
opcode_add_hl_hl_16:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(add_hl_hl)
    ldi pl, lo(add_hl_hl)
    jz
    ldi ph, hi(add_iy_iy)
    ldi pl, lo(add_iy_iy)
    js

add_ix_ix:
    ; first set flags
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  b
    ldi a, z80_sf | z80_zf | z80_pf
    and b, a
    ldi pl, lo(z80_ix + 1)
    ld  a
    shl a
    mov a, 0
    adc a, 0
    or  b, a
    ldi pl, lo(z80_f)
    st  b

    ; then actually shift and save
    ldi pl, lo(z80_ix)
    ld  b
    inc pl
    ld  a
    shl a
    shl b
    adc a, 0
    st  a
    dec pl
    st  b
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

    .section text.add_iy_iy
add_iy_iy:
    ; first set flags
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  b
    ldi a, z80_sf | z80_zf | z80_pf
    and b, a
    ldi pl, lo(z80_iy + 1)
    ld  a
    shl a
    mov a, 0
    adc a, 0
    or  b, a
    ldi pl, lo(z80_f)
    st  b

    ; then actually shift and save
    ldi pl, lo(z80_iy)
    ld  b
    inc pl
    ld  a
    shl a
    shl b
    adc a, 0
    st  a
    dec pl
    st  b
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

    .section text.add_hl_hl
add_hl_hl:
    ; first set flags
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  b
    ldi a, z80_sf | z80_zf | z80_pf
    and b, a
    ldi pl, lo(z80_hl + 1)
    ld  a
    shl a
    mov a, 0
    adc a, 0
    or  b, a
    ldi pl, lo(z80_f)
    st  b

    ; then actually shift and save
    ldi pl, lo(z80_hl)
    ld  b
    inc pl
    ld  a
    shl a
    shl b
    adc a, 0
    st  a
    dec pl
    st  b
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp



