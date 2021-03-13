    ; Startup code from programs loaded into lo RAM

    ; provided by the linker
    .global __seg_stack_end

    .global __cc_int_sh_val_zeroes_before
    .global __cc_int_sh_val_zeroes_after

    .global __cc_r_sp

    .global main

    ; start-up code
    .section init
    .align 0x10000 ; make sure this is at address 0
    ; save return address
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ; point SP to the end of stack segment
    ldi pl, lo(__cc_r_sp)
    ldi ph, hi(__cc_r_sp)
    ldi a, lo(__seg_stack_end)
    st a
    inc pl
    ldi a, hi(__seg_stack_end)
    st a

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

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section bss
    .align 2
ret: res 2
