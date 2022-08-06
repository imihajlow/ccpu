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

    .export shift

    .section text.shift
    ; parity is not implemented!
shift:
    ; 00100rrr - SLA
    ; 00101rrr - SRA
    ; 00111rrr - SRL
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    ldi b, 0x20
    and b, a
    ldi ph, hi(z80_not_implemented)
    ldi pl, lo(z80_not_implemented)
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
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    ldi b, 0x07
    and a, b
    ldi b, 6
    sub b, a
    ldi ph, hi(srl_reg)
    ldi pl, lo(srl_reg)
    jnz
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(srl_hl)
    ldi pl, lo(srl_hl)
    jz
    ldi ph, hi(srl_iy)
    ldi pl, lo(srl_iy)
    js
srl_ix:
    ldi ph, hi(z80_imm1)
    ldi pl, lo(z80_imm1)
    ld  b
    ldi pl, lo(z80_ix)
    ld  a
    add a, b
    ldi pl, lo(z80_ix + 1)
    ld  ph
    mov pl, a
    mov a, 0
    adc ph, a
    shl b
    sbb ph, a
    ld  a
    shr a
    st  a
    ldi ph, hi(srl_set_flags)
    ldi pl, lo(srl_set_flags)
    jmp

srl_iy:
    ldi ph, hi(z80_imm1)
    ldi pl, lo(z80_imm1)
    ld  b
    ldi pl, lo(z80_iy)
    ld  a
    add a, b
    ldi pl, lo(z80_iy + 1)
    ld  ph
    mov pl, a
    mov a, 0
    adc ph, a
    shl b
    sbb ph, a
    ld  a
    shr a
    st  a
    ldi ph, hi(srl_set_flags)
    ldi pl, lo(srl_set_flags)
    jmp

srl_hl:
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  a
    shr a
    st  a
    ldi ph, hi(srl_set_flags)
    ldi pl, lo(srl_set_flags)
    jmp

srl_reg:
    ; a = reg number
    ldi ph, hi(z80_regs_origin)
    ldi pl, lo(z80_regs_origin)
    sub pl, a
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
    ldi ph, hi(z80_not_implemented)
    ldi pl, lo(z80_not_implemented)
    jmp
sra:
    ldi ph, hi(z80_not_implemented)
    ldi pl, lo(z80_not_implemented)
    jmp
