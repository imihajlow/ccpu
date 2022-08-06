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

    .global inc_sp

    .export opcode_jp
    .export opcode_jp_c
    .export opcode_jp_nc
    .export opcode_jp_z
    .export opcode_jp_nz
    .export opcode_jp_pe
    .export opcode_jp_po
    .export opcode_jp_p
    .export opcode_jp_m

    .export opcode_jr
    .export opcode_jr_c
    .export opcode_jr_nc
    .export opcode_jr_z
    .export opcode_jr_nz
    .export opcode_jp_indir

    .export opcode_djnz

    .export opcode_call
    .export opcode_call_c
    .export opcode_call_nc
    .export opcode_call_z
    .export opcode_call_nz
    .export opcode_call_pe
    .export opcode_call_po
    .export opcode_call_p
    .export opcode_call_m

    .export opcode_ret
    .export opcode_ret_c
    .export opcode_ret_nc
    .export opcode_ret_z
    .export opcode_ret_nz
    .export opcode_ret_pe
    .export opcode_ret_po
    .export opcode_ret_p
    .export opcode_ret_m

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
    shl a
    shl a
    ldi ph, hi(opcode_jp)
    ldi pl, lo(opcode_jp)
    jc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; C2
opcode_jp_nz:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    shl a
    ldi ph, hi(opcode_jp)
    ldi pl, lo(opcode_jp)
    jnc
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

    ; 18
opcode_jr:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  b
    ldi pl, lo(z80_pc)
    ld  a
    add a, b
    st  a
    ldi pl, lo(z80_pc + 1)
    ld  a
    adc a, 0
    shl b
    sbb a, 0
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; 38
opcode_jr_c:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shr a
    ldi ph, hi(opcode_jr)
    ldi pl, lo(opcode_jr)
    jc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; 30
opcode_jr_nc:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shr a
    ldi ph, hi(opcode_jr)
    ldi pl, lo(opcode_jr)
    jnc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; 28
opcode_jr_z:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    shl a
    ldi ph, hi(opcode_jr)
    ldi pl, lo(opcode_jr)
    jc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; 20
opcode_jr_nz:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    shl a
    ldi ph, hi(opcode_jr)
    ldi pl, lo(opcode_jr)
    jnc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; E9, DD E9, FD E9
opcode_jp_indir:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    adc a, 0
    ldi ph, hi(jp_indir_hl)
    ldi pl, lo(jp_indir_hl)
    jz
    ldi ph, hi(jp_indir_iy)
    ldi pl, lo(jp_indir_iy)
    js
jp_indir_ix:
    ldi ph, hi(z80_ix)
    ldi pl, lo(z80_ix)
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

jp_indir_iy:
    ldi ph, hi(z80_iy)
    ldi pl, lo(z80_iy)
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

jp_indir_hl:
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
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

    ; 10
opcode_djnz:
    ldi ph, hi(z80_b)
    ldi pl, lo(z80_b)
    ld  a
    dec a
    st  a
    ldi ph, hi(opcode_jr)
    ldi pl, lo(opcode_jr)
    jnz
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; CD
opcode_call:
    ldi ph, hi(z80_sp)
    ldi pl, lo(z80_sp)
    ld  b
    ldi a, 2
    sub b, a
    st  b
    ldi pl, lo(z80_sp + 1)
    ld  a
    sbb a, 0
    st  a
    ldi pl, lo(z80_pc)
    ld  b
    ldi pl, lo(z80_sp)
    ld  pl
    mov ph, a
    st  b
    ldi ph, hi(z80_pc)
    ldi pl, lo(z80_pc + 1)
    ld  b
    ldi pl, lo(z80_sp)
    ld  pl
    inc pl
    adc a, 0
    mov ph, a
    st  b
    ldi ph, hi(opcode_jp)
    ldi pl, lo(opcode_jp)
    jmp

    ; DC
opcode_call_c:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shr a
    ldi ph, hi(opcode_call)
    ldi pl, lo(opcode_call)
    jc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; D4
opcode_call_nc:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shr a
    ldi ph, hi(opcode_call)
    ldi pl, lo(opcode_call)
    jnc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; CC
opcode_call_z:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    shl a
    ldi ph, hi(opcode_call)
    ldi pl, lo(opcode_call)
    jc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; C4
opcode_call_nz:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    shl a
    ldi ph, hi(opcode_call)
    ldi pl, lo(opcode_call)
    jnc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; EC
opcode_call_pe:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_pf
    and a, b
    ldi ph, hi(opcode_call)
    ldi pl, lo(opcode_call)
    jnz
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; E4
opcode_call_po:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_pf
    and a, b
    ldi ph, hi(opcode_call)
    ldi pl, lo(opcode_call)
    jz
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; FC
opcode_call_m:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    ldi ph, hi(opcode_call)
    ldi pl, lo(opcode_call)
    jc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; F4
opcode_call_p:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    ldi ph, hi(opcode_call)
    ldi pl, lo(opcode_call)
    jnc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; C9
opcode_ret:
    ldi ph, hi(z80_sp)
    ldi pl, lo(z80_sp)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    mov a, 0
    ld  b
    inc pl
    adc ph, a
    ld  a
    ldi ph, hi(z80_pc)
    ldi pl, lo(z80_pc)
    st  b
    inc pl
    st  a
    ldi ph, hi(inc_sp)
    ldi pl, lo(inc_sp)
    jmp

    ; D8
opcode_ret_c:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shr a
    ldi ph, hi(opcode_ret)
    ldi pl, lo(opcode_ret)
    jc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; D0
opcode_ret_nc:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shr a
    ldi ph, hi(opcode_ret)
    ldi pl, lo(opcode_ret)
    jnc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; C8
opcode_ret_z:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    shl a
    ldi ph, hi(opcode_ret)
    ldi pl, lo(opcode_ret)
    jc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; C0
opcode_ret_nz:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    shl a
    ldi ph, hi(opcode_ret)
    ldi pl, lo(opcode_ret)
    jnc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; E8
opcode_ret_pe:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_pf
    and a, b
    ldi ph, hi(opcode_ret)
    ldi pl, lo(opcode_ret)
    jnz
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; E0
opcode_ret_po:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    ldi b, z80_pf
    and a, b
    ldi ph, hi(opcode_ret)
    ldi pl, lo(opcode_ret)
    jz
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; F8
opcode_ret_m:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    ldi ph, hi(opcode_ret)
    ldi pl, lo(opcode_ret)
    jc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    ; F0
opcode_ret_p:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  a
    shl a
    ldi ph, hi(opcode_ret)
    ldi pl, lo(opcode_ret)
    jnc
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp
