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

    .export opcode_push

    .export opcode_pop_af
    .export opcode_pop_bc
    .export opcode_pop_de
    .export opcode_pop_hl_common

    .export inc_sp

    ; PUSH and POP instructions

    .section text.opcode_push
    ; F5, C5, D5, E5, DD E5, FD E5
opcode_push:
    ; adjust SP
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

    ; jump to the corresponding function
    ldi pl, lo(z80_current_opcode)
    ld  a
    shr a
    shr a
    shr a
    ; C5 -> 18, D5 -> 1A, etc.
    ldi ph, hi(jump_table_push)
    ldi pl, lo(jump_table_push - 0x18)
    add pl, a
    ld  a
    inc pl
    ld  ph
    mov pl, a
    jmp

    .section text.jump_table_push
    .align 16
jump_table_push:
    dw push_bc
    dw push_de
    dw push_hl_common
    dw push_af

    .section text.push_bc
push_bc:
    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc)
    ld  b
    inc pl
    ld  a
    ldi pl, lo(z80_tmp)
    st  a
    ldi ph, hi(st_on_stack)
    ldi pl, lo(st_on_stack)
    jmp

    .section text.push_de
push_de:
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    ld  b
    inc pl
    ld  a
    ldi pl, lo(z80_tmp)
    st  a
    ldi ph, hi(st_on_stack)
    ldi pl, lo(st_on_stack)
    jmp

    .section text.push_af
push_af:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  b
    ldi pl, lo(z80_a)
    ld  a
    ldi pl, lo(z80_tmp)
    st  a
    ldi ph, hi(st_on_stack)
    ldi pl, lo(st_on_stack)
    jmp

    .section text.push_hl_common
push_hl_common:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(push_hl)
    ldi pl, lo(push_hl)
    jz ; no prefix
    ldi ph, hi(push_iy)
    ldi pl, lo(push_iy)
    js ; FD

push_ix:
    ldi ph, hi(z80_ix)
    ldi pl, lo(z80_ix)
    ld  b
    inc pl
    ld  a
    ldi pl, lo(z80_tmp)
    st  a
    ldi ph, hi(st_on_stack)
    ldi pl, lo(st_on_stack)
    jmp

    .section text.push_iy
push_iy:
    ldi ph, hi(z80_iy)
    ldi pl, lo(z80_iy)
    ld  b
    inc pl
    ld  a
    ldi pl, lo(z80_tmp)
    st  a
    ldi ph, hi(st_on_stack)
    ldi pl, lo(st_on_stack)
    jmp

    .section text.push_hl
push_hl:
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  b
    inc pl
    ld  a
    ldi pl, lo(z80_tmp)
    st  a

    ; [z80_sp] <- b
    ; [z80_sp + 1] <- [z80_tmp]
st_on_stack:
    ldi ph, hi(z80_sp)
    ldi pl, lo(z80_sp)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    st  b
    ldi ph, hi(z80_tmp)
    ldi pl, lo(z80_tmp)
    ld  b
    ldi pl, lo(z80_sp + 1)
    ld  a
    dec pl
    ld  pl
    inc pl
    adc a, 0
    mov ph, a
    st  b
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

    .section text.opcode_pop_bc
opcode_pop_bc:
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
    ldi ph, hi(z80_bc)
    ldi pl, lo(z80_bc)
    st  b
    inc pl
    st  a
    ldi ph, hi(inc_sp)
    ldi pl, lo(inc_sp)
    jmp

    .section text.opcode_pop_de
opcode_pop_de:
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
    ldi ph, hi(z80_de)
    ldi pl, lo(z80_de)
    st  b
    inc pl
    st  a
    ldi ph, hi(inc_sp)
    ldi pl, lo(inc_sp)
    jmp

    .section text.opcode_pop_af
opcode_pop_af:
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
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    st  b
    ldi pl, lo(z80_a)
    st  a
    ldi ph, hi(inc_sp)
    ldi pl, lo(inc_sp)
    jmp

    .section text.opcode_pop_hl_common
opcode_pop_hl_common:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(pop_hl)
    ldi pl, lo(pop_hl)
    jz
    ldi ph, hi(pop_iy)
    ldi pl, lo(pop_iy)
    js

pop_ix:
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
    ldi ph, hi(z80_ix)
    ldi pl, lo(z80_ix)
    st  b
    inc pl
    st  a
    ldi ph, hi(inc_sp)
    ldi pl, lo(inc_sp)
    jmp

    .section text.pop_iy
pop_iy:
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
    ldi ph, hi(z80_iy)
    ldi pl, lo(z80_iy)
    st  b
    inc pl
    st  a
    ldi ph, hi(inc_sp)
    ldi pl, lo(inc_sp)
    jmp

    .section text.pop_hl
pop_hl:
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
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    st  b
    inc pl
    st  a

inc_sp:
    ldi ph, hi(z80_sp)
    ldi pl, lo(z80_sp)
    ld  b
    ldi a, 2
    add b, a
    st  b
    ldi pl, lo(z80_sp + 1)
    ld  a
    adc a, 0
    st  a
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp
