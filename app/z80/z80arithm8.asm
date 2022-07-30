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


    .global z80_cf
    .global z80_nf
    .global z80_pf
    .global z80_hf
    .global z80_zf
    .global z80_sf

    .export opcode_arithm8_common
    .export opcode_arithm8_indir
    .export opcode_arithm8_imm
    .export opcode_inc_r
    .export opcode_inc_r_common
    .export opcode_dec_r
    .export opcode_dec_r_common
    .export opcode_inc_indirect
    .export opcode_dec_indirect

    ; The half-carry flag H is not supported!
    ; Parity with XOR is not supported!

    .section text.opcode_inc_indirect
    ; 34, DD 34, FD 34
opcode_inc_indirect:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(inc_indirect_hl)
    ldi pl, lo(inc_indirect_hl)
    jz ; no prefix
    ldi ph, hi(inc_indirect_iy)
    ldi pl, lo(inc_indirect_iy)
    js ; FD
    ; othrewise DD
inc_indirect_ix:
    ldi pl, lo(z80_imm0)
    ldi ph, hi(z80_imm0)
    ld  b
    mov a, b
    shl b
    exp b
    ldi pl, lo(z80_ix)
    ld  pl
    add a, pl
    ldi pl, lo(z80_ix + 1)
    ld  ph
    mov pl, a
    mov a, b
    adc ph, a
    ld  b
    inc b
    st  b
    ldi b, 0
    ldi ph, hi(set_flags_preserve_c)
    ldi pl, lo(set_flags_preserve_c)
    jmp

    .section text.inc_indirect_iy
inc_indirect_iy:
    ldi pl, lo(z80_imm0)
    ldi ph, hi(z80_imm0)
    ld  b
    mov a, b
    shl b
    exp b
    ldi pl, lo(z80_iy)
    ld  pl
    add a, pl
    ldi pl, lo(z80_iy + 1)
    ld  ph
    mov pl, a
    mov a, b
    adc ph, a
    ld  b
    inc b
    st  b
    ldi b, 0
    ldi ph, hi(set_flags_preserve_c)
    ldi pl, lo(set_flags_preserve_c)
    jmp

    .section text.inc_indirect_hl
inc_indirect_hl:
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  a
    inc a
    st  a
    ldi b, 0
    ldi ph, hi(set_flags_preserve_c)
    ldi pl, lo(set_flags_preserve_c)
    jmp


    .section text.opcode_dec_indirect
    ; 35, DD 35, FD 35
opcode_dec_indirect:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(dec_indirect_hl)
    ldi pl, lo(dec_indirect_hl)
    jz ; no prefix
    ldi ph, hi(dec_indirect_iy)
    ldi pl, lo(dec_indirect_iy)
    js ; FD
    ; othrewise DD
dec_indirect_ix:
    ldi pl, lo(z80_imm0)
    ldi ph, hi(z80_imm0)
    ld  b
    mov a, b
    shl b
    exp b
    ldi pl, lo(z80_ix)
    ld  pl
    add a, pl
    ldi pl, lo(z80_ix + 1)
    ld  ph
    mov pl, a
    mov a, b
    adc ph, a
    ld  b
    dec b
    st  b
    ldi b, z80_nf
    ldi ph, hi(set_flags_preserve_c)
    ldi pl, lo(set_flags_preserve_c)
    jmp

    .section text.dec_indirect_iy
dec_indirect_iy:
    ldi pl, lo(z80_imm0)
    ldi ph, hi(z80_imm0)
    ld  b
    mov a, b
    shl b
    exp b
    ldi pl, lo(z80_iy)
    ld  pl
    add a, pl
    ldi pl, lo(z80_iy + 1)
    ld  ph
    mov pl, a
    mov a, b
    adc ph, a
    ld  b
    dec b
    st  b
    ldi b, z80_nf
    ldi ph, hi(set_flags_preserve_c)
    ldi pl, lo(set_flags_preserve_c)
    jmp

    .section text.dec_indirect_hl
dec_indirect_hl:
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  a
    dec a
    st  a
    ldi b, z80_nf
    ldi ph, hi(set_flags_preserve_c)
    ldi pl, lo(set_flags_preserve_c)
    jmp

    .section text.opcode_inc_r
    ; 24, 2C, DD 24, DD 2C, FD 24, FD 2C
opcode_inc_r:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(opcode_inc_r_common)
    ldi pl, lo(opcode_inc_r_common)
    jz
    ldi ph, hi(inc_iyp)
    ldi pl, lo(inc_iyp)
    js ; FD
    ; else DD

    ; DD 24, FD 2C
inc_ixp:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    shr a
    shr a
    shr a
    ; a = 4 for IXh, a = 5 for IXl
    ldi pl, lo(z80_ix + 5)
    sub pl, a
    ld  a
    inc a
    st  a
    ldi b, 0
    ldi pl, lo(set_flags_preserve_c)
    ldi ph, hi(set_flags_preserve_c)
    jmp

    ; FD 24, FD 2C
inc_iyp:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    shr a
    shr a
    shr a
    ; a = 4 for IYh, a = 5 for IYl
    ldi pl, lo(z80_iy + 5)
    sub pl, a
    ld  a
    inc a
    st  a
    ldi b, 0
    ldi pl, lo(set_flags_preserve_c)
    ldi ph, hi(set_flags_preserve_c)
    jmp

    .section text.opcode_inc_r_common
    ; 04, 0C, 14, 1C, 24, 2C, 3C
    ; simple register increment, no prefix
opcode_inc_r_common:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    shr a
    shr a
    shr a
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  a
    inc a
    st  a
    ldi b, 0
    ldi pl, lo(set_flags_preserve_c)
    ldi ph, hi(set_flags_preserve_c)
    jmp

    .section text.opcode_dec_r
    ; 25, 2D, DD 25, DD 2D, FD 25, FD 2D
opcode_dec_r:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(opcode_dec_r_common)
    ldi pl, lo(opcode_dec_r_common)
    jz
    ldi ph, hi(dec_iyp)
    ldi pl, lo(dec_iyp)
    js ; FD
    ; else DD

    ; DD 24, FD 2C
dec_ixp:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    shr a
    shr a
    shr a
    ; a = 4 for IXh, a = 5 for IXl
    ldi pl, lo(z80_ix + 5)
    sub pl, a
    ld  a
    dec a
    st  a
    ldi b, z80_nf
    ldi pl, lo(set_flags_preserve_c)
    ldi ph, hi(set_flags_preserve_c)
    jmp

    ; FD 04, FD 0C
dec_iyp:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    shr a
    shr a
    shr a
    ; a = 4 for IYh, a = 5 for IYl
    ldi pl, lo(z80_iy + 5)
    sub pl, a
    ld  a
    dec a
    st  a
    ldi b, z80_nf
    ldi pl, lo(set_flags_preserve_c)
    ldi ph, hi(set_flags_preserve_c)
    jmp

    .section text.opcode_dec_r_common
    ; 05, 0D, 15, 1D, 25, 2D, 3D
    ; simple register decrement, no prefix
opcode_dec_r_common:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    shr a
    shr a
    shr a
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  a
    dec a
    st  a
    ldi b, z80_nf
    ldi pl, lo(set_flags_preserve_c)
    ldi ph, hi(set_flags_preserve_c)
    jmp


    .section text.opcode_arithm8_indir
opcode_arithm8_indir:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi pl, lo(arithm_indir_hl)
    ldi ph, hi(arithm_indir_hl)
    jz ; no prefix
    ldi pl, lo(arithm_indir_iy)
    ldi ph, hi(arithm_indir_iy)
    js ; FD
    ; else DD
arithm_indir_ix:
    ldi pl, lo(z80_imm0)
    ldi ph, hi(z80_imm0)
    ld  b
    mov a, b
    shl b
    exp b
    ldi pl, lo(z80_ix)
    ld  pl
    add a, pl
    ldi pl, lo(z80_ix + 1)
    ld  ph
    mov pl, a
    mov a, b
    adc ph, a
    ld  b
    ldi ph, hi(z80_indir_src)
    ldi pl, lo(z80_indir_src)
    st  b
    ldi ph, hi(opcode_arithm8_common)
    ldi pl, lo(opcode_arithm8_common)
    jmp

    .section text.arithm_indir_iy
arithm_indir_iy:
    ldi pl, lo(z80_imm0)
    ldi ph, hi(z80_imm0)
    ld  b
    mov a, b
    shl b
    exp b
    ldi pl, lo(z80_iy)
    ld  pl
    add a, pl
    ldi pl, lo(z80_iy + 1)
    ld  ph
    mov pl, a
    mov a, b
    adc ph, a
    ld  b
    ldi ph, hi(z80_indir_src)
    ldi pl, lo(z80_indir_src)
    st  b
    ldi ph, hi(opcode_arithm8_common)
    ldi pl, lo(opcode_arithm8_common)
    jmp

    .section text.arithm_indir_hl
arithm_indir_hl:
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  a
    ldi ph, hi(z80_indir_src)
    ldi pl, lo(z80_indir_src)
    st  a
    ldi ph, hi(opcode_arithm8_common)
    ldi pl, lo(opcode_arithm8_common)
    jmp

    .section text.opcode_arithm8_imm
opcode_arithm8_imm:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    ldi pl, lo(z80_indir_src)
    st  a

opcode_arithm8_common:
    ; current opcode is 10cccrrr or 11cccrrr
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  pl
    shr pl
    shr pl
    ldi ph, hi(op_jump_table)
    ldi a, 0xe
    and pl, a
    ld  a
    inc pl
    ld  ph
    mov pl, a
    jmp

    .section text.add_common
add_common:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    ldi b, 0x7
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  b
    ldi pl, lo(z80_a)
    ld  a
    add a, b
    st  a
    ldi b, 0 ; flag N is reset
    ldi pl, lo(set_flags)
    ldi ph, hi(set_flags)
    jmp

    .section text.sub_common
sub_common:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    ldi b, 0x7
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  b
    ldi pl, lo(z80_a)
    ld  a
    sub a, b
    st  a
    ldi b, z80_nf ; flag N is set
    ldi pl, lo(set_flags)
    ldi ph, hi(set_flags)
    jmp

    .section text.cp_common
cp_common:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    ldi b, 0x7
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  b
    ldi pl, lo(z80_a)
    ld  a
    sub a, b
    ldi b, z80_nf ; flag N is set
    ldi pl, lo(set_flags)
    ldi ph, hi(set_flags)
    jmp

    .section text.and_common
and_common:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    ldi b, 0x7
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  b
    ldi pl, lo(z80_a)
    ld  a
    and a, b
    st  a
    ldi b, z80_hf; flag H is set, N is reset
    ldi pl, lo(set_flags)
    ldi ph, hi(set_flags)
    jmp

    .section text.or_common
or_common:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    ldi b, 0x7
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  b
    ldi pl, lo(z80_a)
    ld  a
    or a, b
    st  a
    ldi b, 0 ; flags N and H are reset
    ldi pl, lo(set_flags)
    ldi ph, hi(set_flags)
    jmp

    .section text.xor_common
xor_common:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    ldi b, 0x7
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  b
    ldi pl, lo(z80_a)
    ld  a
    xor a, b
    st  a
    ldi b, 0 ; flags N and H are reset
    ldi pl, lo(set_flags)
    ldi ph, hi(set_flags)
    jmp

    .section text.adc_common
adc_common:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    ldi b, 0x7
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  b
    ldi pl, lo(z80_f)
    ld  a
    shr a ; set CCPU carry from Z80 carry
    ldi pl, lo(z80_a)
    ld  a
    adc a, b
    st  a
    ldi b, 0 ; flag N is reset
    ldi pl, lo(set_flags)
    ldi ph, hi(set_flags)
    jmp

    .section text.sbc_common
sbc_common:
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  a
    ldi b, 0x7
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  b
    ldi pl, lo(z80_f)
    ld  a
    shr a ; set CCPU carry from Z80 carry
    ldi pl, lo(z80_a)
    ld  a
    sbb a, b
    st  a
    ldi b, z80_nf ; flag N is set
    ldi pl, lo(set_flags)
    ldi ph, hi(set_flags)
    jmp



    .section text.op_jump_table
    .align 256
op_jump_table:
    dw  add_common
    dw  adc_common
    dw  sub_common
    dw  sbc_common
    dw  and_common
    dw  xor_common
    dw  or_common
    dw  cp_common

    ; transfer CCPU z,o,c,s flags to Z80 flags
    ; b is or'ed with the result (to set flag N, for example)
    .section text.set_flags
set_flags:
    ldi pl, lo(set_flags_z)
    ldi ph, hi(set_flags_z)
    jz
set_flags_nz:
    ldi pl, lo(set_flags_nz_o)
    ldi ph, hi(set_flags_nz_o)
    jo
set_flags_nz_no:
    ldi pl, lo(set_flags_nz_no_s)
    ldi ph, hi(set_flags_nz_no_s)
    js
set_flags_nz_no_ns:
    mov a, 0
    ldi pl, lo(set_flags_finish)
    ldi ph, hi(set_flags_finish)
    jmp
set_flags_nz_no_s:
    ldi a, z80_sf
    ldi pl, lo(set_flags_finish)
    ldi ph, hi(set_flags_finish)
    jmp
set_flags_nz_o:
    ldi pl, lo(set_flags_nz_o_s)
    ldi ph, hi(set_flags_nz_o_s)
    js
set_flags_nz_o_ns:
    ldi a, z80_pf
    ldi pl, lo(set_flags_finish)
    ldi ph, hi(set_flags_finish)
    jmp
set_flags_nz_o_s:
    ldi a, z80_pf | z80_sf
    ldi pl, lo(set_flags_finish)
    ldi ph, hi(set_flags_finish)
    jmp
set_flags_z:
    ldi pl, lo(set_flags_z_o)
    ldi ph, hi(set_flags_z_o)
    jo
set_flags_z_no:
    ldi pl, lo(set_flags_z_no_s)
    ldi ph, hi(set_flags_z_no_s)
    js
set_flags_z_no_ns:
    ldi a, z80_zf
    ldi pl, lo(set_flags_finish)
    ldi ph, hi(set_flags_finish)
    jmp
set_flags_z_no_s:
    ldi a, z80_zf | z80_sf
    ldi pl, lo(set_flags_finish)
    ldi ph, hi(set_flags_finish)
    jmp
set_flags_z_o:
    ldi pl, lo(set_flags_z_o_s)
    ldi ph, hi(set_flags_z_o_s)
    js
set_flags_z_o_ns:
    ldi a, z80_zf | z80_pf
    ldi pl, lo(set_flags_finish)
    ldi ph, hi(set_flags_finish)
    jmp
set_flags_z_o_s:
    ldi a, z80_zf | z80_pf | z80_sf

set_flags_finish:
    adc a, 0
    or  a, b
    ldi pl, lo(z80_f)
    ldi ph, hi(z80_f)
    st  a
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp


    ; transfer CCPU z,o,s flags to Z80 flags
    ; b is or'ed with the result (to set flag N, for example)
    ; Z80 flag C is preserved
    .section text.set_flags_preserve_c
set_flags_preserve_c:
    ldi pl, lo(set_flags_preserve_c_z)
    ldi ph, hi(set_flags_preserve_c_z)
    jz
set_flags_preserve_c_nz:
    ldi pl, lo(set_flags_preserve_c_nz_o)
    ldi ph, hi(set_flags_preserve_c_nz_o)
    jo
set_flags_preserve_c_nz_no:
    ldi pl, lo(set_flags_preserve_c_nz_no_s)
    ldi ph, hi(set_flags_preserve_c_nz_no_s)
    js
set_flags_preserve_c_nz_no_ns:
    mov a, 0
    ldi pl, lo(set_flags_preserve_c_finish)
    ldi ph, hi(set_flags_preserve_c_finish)
    jmp
set_flags_preserve_c_nz_no_s:
    ldi a, z80_sf
    ldi pl, lo(set_flags_preserve_c_finish)
    ldi ph, hi(set_flags_preserve_c_finish)
    jmp
set_flags_preserve_c_nz_o:
    ldi pl, lo(set_flags_preserve_c_nz_o_s)
    ldi ph, hi(set_flags_preserve_c_nz_o_s)
    js
set_flags_preserve_c_nz_o_ns:
    ldi a, z80_pf
    ldi pl, lo(set_flags_preserve_c_finish)
    ldi ph, hi(set_flags_preserve_c_finish)
    jmp
set_flags_preserve_c_nz_o_s:
    ldi a, z80_pf | z80_sf
    ldi pl, lo(set_flags_preserve_c_finish)
    ldi ph, hi(set_flags_preserve_c_finish)
    jmp
set_flags_preserve_c_z:
    ldi pl, lo(set_flags_preserve_c_z_o)
    ldi ph, hi(set_flags_preserve_c_z_o)
    jo
set_flags_preserve_c_z_no:
    ldi pl, lo(set_flags_preserve_c_z_no_s)
    ldi ph, hi(set_flags_preserve_c_z_no_s)
    js
set_flags_preserve_c_z_no_ns:
    ldi a, z80_zf
    ldi pl, lo(set_flags_preserve_c_finish)
    ldi ph, hi(set_flags_preserve_c_finish)
    jmp
set_flags_preserve_c_z_no_s:
    ldi a, z80_zf | z80_sf
    ldi pl, lo(set_flags_preserve_c_finish)
    ldi ph, hi(set_flags_preserve_c_finish)
    jmp
set_flags_preserve_c_z_o:
    ldi pl, lo(set_flags_preserve_c_z_o_s)
    ldi ph, hi(set_flags_preserve_c_z_o_s)
    js
set_flags_preserve_c_z_o_ns:
    ldi a, z80_zf | z80_pf
    ldi pl, lo(set_flags_preserve_c_finish)
    ldi ph, hi(set_flags_preserve_c_finish)
    jmp
set_flags_preserve_c_z_o_s:
    ldi a, z80_zf | z80_pf | z80_sf

set_flags_preserve_c_finish:
    or  a, b
    ldi pl, lo(z80_f)
    ldi ph, hi(z80_f)
    ld  b
    shr b
    adc a, 0
    st  a
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp


