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

    .export shift
    .export opcode_rlca

    .section text.shift
    ; parity is not implemented!
shift:
    ; 00100rrr - SLA
    ; 00101rrr - SRA
    ; 00111rrr - SRL
    ; 00000rrr - RLC
    ; 00010rrr - RL
    ; 00001rrr - RRC
    ; 00011rrr - RR

    ; set tmp as destination address
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    ldi b, 7
    and a, b
    ldi b, 6
    sub b, a
    ldi ph, hi(shift_reg)
    ldi pl, lo(shift_reg)
    jnz
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(shift_hl)
    ldi pl, lo(shift_hl)
    jz ; no prefix
    ldi ph, hi(shift_iy)
    ldi pl, lo(shift_iy)
    js ; FD
    ; othrewise DD
shift_ix:
    ldi pl, lo(z80_imm1)
    ldi ph, hi(z80_imm1)
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
    adc a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(z80_tmp)
    ldi pl, lo(z80_tmp)
    st  a
    inc pl
    st  b
    ldi ph, hi(shift_select)
    ldi pl, lo(shift_select)
    jmp
shift_iy:
    ldi pl, lo(z80_imm1)
    ldi ph, hi(z80_imm1)
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
    adc a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(z80_tmp)
    ldi pl, lo(z80_tmp)
    st  a
    inc pl
    st  b
    ldi ph, hi(shift_select)
    ldi pl, lo(shift_select)
    jmp
shift_hl:
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    inc pl
    ld  b
    ldi pl, lo(z80_tmp)
    st  a
    inc pl
    st  b
    ldi ph, hi(shift_select)
    ldi pl, lo(shift_select)
    jmp
shift_reg:
    ldi ph, hi(z80_tmp)
    ldi pl, lo(z80_tmp)
    ldi b, lo(z80_regs_origin)
    sub b, a
    st  b
    inc pl
    mov a, ph
    st  a
shift_select:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    ldi b, 0x20
    and b, a
    ldi ph, hi(cb_rotate)
    ldi pl, lo(cb_rotate)
    jz
    ldi b, 0x18
    and b, a
    ldi ph, hi(sla)
    ldi pl, lo(sla)
    jz
    ldi a, 0x10
    and a, b
    ldi ph, hi(sra)
    ldi pl, lo(sra)
    jz
srl:
    ldi ph, hi(z80_tmp)
    ldi pl, lo(z80_tmp)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  a
    shr a
    st  a
srl_set_flags:
    mov a, 0
    ldi ph, hi(srl_reg_nz)
    ldi pl, lo(srl_reg_nz)
    jnz
    ldi a, z80_zf
srl_reg_nz:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    adc a, 0
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp


sla:
    ldi ph, hi(z80_tmp)
    ldi pl, lo(z80_tmp)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  a
    shl a
    st  a
    ldi b, 0
    ldi ph, hi(set_flags)
    ldi pl, lo(set_flags)
    jmp

sra:
    ldi ph, hi(z80_tmp)
    ldi pl, lo(z80_tmp)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  a
    sar a
    st  a
    ldi b, 0
    ldi ph, hi(set_flags)
    ldi pl, lo(set_flags)
    jmp

    ; 07
opcode_rlca:
    ldi ph, hi(z80_a)
    ldi pl, lo(z80_a)
    ld  a
    shl a
    adc a, 0
    st  a
    shr a
    ldi pl, lo(z80_f)
    ld  b
    mov a, 0
    adc a, 0
    mov pl, a
    ldi a, z80_sf | z80_zf | z80_pf
    and a, b
    or  a, pl
    ldi pl, lo(z80_f)
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; a - opcode
    ; 00000rrr - RLC
    ; 00010rrr - RL
    ; 00001rrr - RRC
    ; 00011rrr - RR
cb_rotate:
    shr a
    shr a
    shr a
    shl a
    ldi ph, hi(cb_rotate_table)
    ldi pl, lo(cb_rotate_table)
    add pl, a
    ld  a
    inc pl
    ld  ph
    mov pl, a
    jmp

opcode_rlc:
    ldi ph, hi(opcode_rlc)
    ldi pl, lo(opcode_rlc)
    jmp

opcode_rrc:
    ldi ph, hi(opcode_rrc)
    ldi pl, lo(opcode_rrc)
    jmp

opcode_rl:
    ; b := c'
    ; P = x
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  b
    ldi pl, lo(z80_tmp)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ldi a, z80_cf
    and b, a
    ; a := [x]
    ld  a
    ; (c, a) := a << 1
    shl a
    ; [x] := a
    st  a
    ; a := c << 1
    mov a, 0
    adc a, 0
    shl a
    ; b := b | a
    or  b, a
    ; a := [x]
    ld  a
    ; (c, b) := b >> 1
    shr b
    ; a += c
    adc a, 0
    ; [x] := a
    st  a
rx_check_flags:
    ldi ph, hi(rl_set_flags_s)
    ldi pl, lo(rl_set_flags_s)
    js
    ldi ph, hi(rl_set_flags_store)
    ldi pl, lo(rl_set_flags_store)
    jnz
rl_set_flags_z:
    ; z implies no s
    ldi a, z80_zf
    or  b, a
    jmp
rl_set_flags_s:
    ; s implies no z
    ldi a, z80_sf
    or  b, a
rl_set_flags_store:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

opcode_rr:
    ; b := c ? 0x80 : 0x00
    ; P = x
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  b
    ldi pl, lo(z80_tmp)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ldi a, 0x80
    shr b
    exp b
    and b, a
    ; a := [x]
    ld  a
    ; (a, c) = a >> 1
    shr a
    ; [x] := a
    st  a
    ; a := c
    mov a, 0
    adc a, 0
    ; b |= a
    or  b, a
    ; a := [x]
    ld  a
    ; a ^= b
    xor a, b
    ; b := b & 1
    shl b
    shr b
    ; a ^= b
    xor a, b
    ; [x] = a
    st a
    ldi ph, hi(rx_check_flags)
    ldi pl, lo(rx_check_flags)
    jmp

    .section text.cb_rotate_table
    .align 8
cb_rotate_table:
    dw opcode_rlc
    dw opcode_rrc
    dw opcode_rl
    dw opcode_rr

