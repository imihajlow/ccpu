    .global display_init
    .global display_print
    .global display_print_byte
    .global display_print_arg
    .global display_set_address
    .global display_set_address_arg
    .global keyboard_wait_key_released
    .global keyboard_wait_key_released_result

    .global key_ent
    .global key_right
    .global key_0
    .global key_left
    .global key_esc
    .global key_9
    .global key_8
    .global key_7
    .global key_down
    .global key_6
    .global key_5
    .global key_4
    .global key_up
    .global key_3
    .global key_2
    .global key_1
    .global key_star
    .global key_hash
    .global key_f2
    .global key_f1

    .global keyboard_key_digit_map

    .global display_print_bcdf
    .global display_print_bcdf_arg
    .global display_print_bcdf_width

    .global bcdf_normalize
    .global bcdf_normalize_arg

    .global bcdf_add
    .global bcdf_sub
    .global bcdf_mul
    .global bcdf_op_a
    .global bcdf_op_b
    .global bcdf_op_r

    .section text
    nop
test:
    ldi pl, lo(display_print_bcdf_width)
    ldi ph, hi(display_print_bcdf_width)
    ldi b, 16
    st b

    ldi a, 15
copy_loop_a:
    ldi ph, hi(test_bcdf_a)
    ldi pl, lo(test_bcdf_a)
    add pl, a
    ld b
    ldi ph, hi(bcdf_op_a)
    ldi pl, lo(bcdf_op_a)
    add pl, a
    st b
    dec a
    ldi pl, lo(copy_loop_a)
    ldi ph, hi(copy_loop_a)
    jnc

    ldi a, 15
copy_loop_b:
    ldi ph, hi(test_bcdf_b)
    ldi pl, lo(test_bcdf_b)
    add pl, a
    ld b
    ldi ph, hi(bcdf_op_b)
    ldi pl, lo(bcdf_op_b)
    add pl, a
    st b
    dec a
    ldi pl, lo(copy_loop_b)
    ldi ph, hi(copy_loop_b)
    jnc

    ldi pl, lo(bcdf_mul)
    ldi ph, hi(bcdf_mul)
    jmp

    ldi a, 15
copy_loop_r:
    ldi ph, hi(bcdf_op_r)
    ldi pl, lo(bcdf_op_r)
    add pl, a
    ld b
    ldi ph, hi(display_print_bcdf_arg)
    ldi pl, lo(display_print_bcdf_arg)
    add pl, a
    st b
    dec a
    ldi pl, lo(copy_loop_r)
    ldi ph, hi(copy_loop_r)
    jnc

    ; print the result with different width
    ldi pl, lo(display_print_bcdf_width)
    ldi ph, hi(display_print_bcdf_width)
    ldi a, 6
    st a
display_loop:
    ldi pl, lo(display_print_bcdf_width)
    ldi ph, hi(display_print_bcdf_width)
    ld a
    inc a
    st a
    ldi b, 16
    sub b, a
    ldi pl, lo(finish)
    ldi ph, hi(finish)
    js ; 16 < width

    ldi pl, lo(display_set_address)
    ldi ph, hi(display_set_address)
    jmp ; cause newline in the simulator

    ldi pl, lo(display_print_bcdf)
    ldi ph, hi(display_print_bcdf)
    jmp

    ldi pl, lo(display_loop)
    ldi ph, hi(display_loop)
    jmp

    .export finish
finish:
    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp

    .align 16
test_bcdf_a:
    db 0x0 ; sign
    db 2 ; exp
    db 1
    db 2
    db 9
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0

test_bcdf_b:
    db 0x0 ; sign
    db -1 ; exp
    db 1
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0
    db 0

