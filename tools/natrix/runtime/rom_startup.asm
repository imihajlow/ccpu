    ; Startup code from programs in ROM

    ; provided by the linker
    .global __seg_stack_end
    .global __seg_ramtext_begin
    .global __seg_ramtext_end
    .global __seg_ramtext_origin_begin
    .global __seg_ramtext_origin_end

    .global memcpy
    .global memcpy_arg0
    .global memcpy_arg1
    .global memcpy_arg2
    .global memcpy_ret

    .global __cc_int_sh_val_zeroes_before
    .global __cc_int_sh_val_zeroes_after

    .global __cc_r_sp

    .global main

    ; start-up code
    .section init
    .align 0x10000 ; make sure this is at address 0
    nop
    ; enable all memory segments except for d and e
    ldi ph, 0xff
    ldi pl, 0x02
    ldi a, 0x3e
    st a
    ; point SP to the end of stack segment
    ldi pl, lo(__cc_r_sp)
    ldi ph, hi(__cc_r_sp)
    ldi a, lo(__seg_stack_end)
    st a
    inc pl
    ldi a, hi(__seg_stack_end)
    st a

    ; populate ramtext secion
    ldi pl, lo(memcpy_arg0)
    ldi ph, hi(memcpy_arg0)
    ldi a, lo(__seg_ramtext_begin)
    ldi b, hi(__seg_ramtext_begin)
    st a
    inc pl
    st b

    ldi pl, lo(memcpy_arg1)
    ldi ph, hi(memcpy_arg1)
    ldi a, lo(__seg_ramtext_origin_begin)
    ldi b, hi(__seg_ramtext_origin_begin)
    st a
    inc pl
    st b

    ldi pl, lo(memcpy_arg2)
    ldi ph, hi(memcpy_arg2)
    ldi a, lo(__seg_ramtext_end - __seg_ramtext_begin)
    ldi b, hi(__seg_ramtext_end - __seg_ramtext_begin)
    st a
    inc pl
    st b

    ldi pl, lo(memcpy)
    ldi ph, hi(memcpy)
    jmp

    ; initialize zeroes
    ldi pl, lo(__cc_int_sh_val_zeroes_before)
    ldi ph, hi(__cc_int_sh_val_zeroes_before)
    mov a, 0
    st a
    inc pl
    st a
    inc pl
    st a

    ldi pl, lo(__cc_int_sh_val_zeroes_after)
    st a
    inc pl
    st a
    inc pl
    st a
    inc pl


    ; call main
    ldi pl, lo(main)
    ldi ph, hi(main)
    jmp
main_exit:
    ldi pl, lo(main_exit)
    ldi ph, hi(main_exit)
    jmp
