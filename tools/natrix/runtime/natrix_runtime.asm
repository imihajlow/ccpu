    .export __cc_r_sp

    .global __seg_stack_end ; provided by the linker
    .global main

    ; start-up code
    .section init
    ; point SP to the end of stack segment
    ldi pl, lo(__cc_r_sp)
    ldi ph, hi(__cc_r_sp)
    ldi a, lo(__seg_stack_end)
    st a
    inc pl
    ldi a, hi(__seg_stack_end)
    st a

    ; call main
    ldi pl, lo(main)
    ldi ph, hi(main)
    jmp
main_exit:
    ldi pl, lo(main_exit)
    ldi ph, hi(main_exit)
    jmp

    .section text

; bit shifts of word values
; __cc_sh_val = __cc_sh_val >> __cc_sh_count
__cc_asr:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

    ldi pl, lo(__cc_sh_count)
    ld b
    inc pl
    ld a
    ldi pl, lo(return_val_sign)
    ldi ph, hi(return_val_sign)
    add a, 0
    jnz ; count >= 256
    ldi a, 15
    sub a, b ; 15 - lo(count)
    jc ; 15 < lo(count)

    ldi a, 8
    sub b, a ; lo(count) - 8
    ldi pl, lo(__cc_asr_count_lt_8)
    ldi ph, hi(__cc_asr_count_lt_8)
    jc ; lo(count) < 8
    sub b, a
    ; b = count - 16

    ; lo(val) := hi(val)
    ; hi(val) := sign(val)
    ldi pl, lo(__cc_sh_val + 1)
    ldi ph, hi(__cc_sh_val)
    ld a
    dec pl
    st a
    inc pl
    shl a ; sign -> carry
    exp a
    st a
__cc_asr_count_lt_8:
    ; b = count - 8

    ldi a, 8
    add b, a
    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jz ; count == 0

    ; b = count
__cc_asr_loop:
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val)
    ld a
    shr a
    st a
    inc pl
    ld a
    sar a
    st a
    ldi pl, lo(__cc_asr_loop_end)
    ldi ph, hi(__cc_asr_loop_end)
    jnc
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val)
    ld a
    ldi pl, 0x80
    or a, pl
    ldi pl, lo(__cc_sh_val)
    st a
__cc_asr_loop_end:
    ldi pl, lo(__cc_asr_loop)
    ldi ph, hi(__cc_asr_loop)
    dec b
    jnz ; count != 0

    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp

return_val_sign:
    ldi pl, lo(__cc_sh_val + 1)
    ldi ph, hi(__cc_sh_val)
    ld a
    shl a ; sign -> carry
    exp a
    st a
    dec pl
    st a
    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp

    ; __cc_sh_val = __cc_sh_val >> __cc_sh_count
__cc_lsr:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

    ldi pl, lo(__cc_sh_count)
    ld b
    inc pl
    ld a
    ldi pl, lo(return_0)
    ldi ph, hi(return_0)
    add a, 0
    jnz ; count >= 256
    ldi a, 15
    sub a, b ; 15 - lo(count)
    jc ; 15 < lo(count)

    ldi a, 8
    sub b, a ; lo(count) - 8
    ldi pl, lo(__cc_lsr_count_lt_8)
    ldi ph, hi(__cc_lsr_count_lt_8)
    jc ; lo(count) < 8
    sub b, a
    ; b = count - 16

    ; lo(val) := hi(val)
    ; hi(val) := 0
    ldi pl, lo(__cc_sh_val + 1)
    ldi ph, hi(__cc_sh_val)
    ld a
    dec pl
    st a
    inc pl
    mov a, 0
    st a
__cc_lsr_count_lt_8:
    ; b = count - 8

    ldi a, 8
    add b, a
    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jz ; count == 0

    ; b = count
__cc_lsr_loop:
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val)
    ld a
    shr a
    st a
    inc pl
    ld a
    shr a
    st a
    ldi pl, lo(__cc_lsr_loop_end)
    ldi ph, hi(__cc_lsr_loop_end)
    jnc
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val)
    ld a
    ldi pl, 0x80
    or a, pl
    ldi pl, lo(__cc_sh_val)
    st a
__cc_lsr_loop_end:
    ldi pl, lo(__cc_asr_loop)
    ldi ph, hi(__cc_asr_loop)
    dec b
    jnz ; count != 0

    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp


    ; __cc_sh_val = __cc_sh_val << __cc_sh_count
__cc_asl:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

    ldi pl, lo(__cc_sh_count)
    ld b
    inc pl
    ld a
    ldi pl, lo(return_0)
    ldi ph, hi(return_0)
    add a, 0
    jnz ; count >= 256
    ldi a, 15
    sub a, b ; 15 - lo(count)
    jc ; 15 < lo(count)

    ldi a, 8
    sub b, a ; lo(count) - 8
    ldi pl, lo(__cc_asl_count_lt_8)
    ldi ph, hi(__cc_asl_count_lt_8)
    jc ; lo(count) < 8
    sub b, a
    ; b = count - 16

    ; hi(val) := lo(val)
    ; lo(val) := 0
    ldi pl, lo(__cc_sh_val)
    ldi ph, hi(__cc_sh_val)
    ld a
    inc pl
    st a
    dec pl
    mov a, 0
    st a
__cc_asl_count_lt_8:
    ; b = count - 8

    ldi a, 8
    add b, a
    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jz ; count == 0

    ; b = count
__cc_asl_loop:
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val + 1)
    ld a
    shl a
    st a
    dec pl
    ld a
    shl a
    st a
    ldi pl, lo(__cc_asl_loop_end)
    ldi ph, hi(__cc_asl_loop_end)
    jnc
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val + 1)
    ld a
    ldi pl, 0x01
    or a, pl
    ldi pl, lo(__cc_sh_val + 1)
    st a
__cc_asl_loop_end:
    ldi pl, lo(__cc_asl_loop)
    ldi ph, hi(__cc_asl_loop)
    dec b
    jnz ; count != 0

    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp

return_0:
    ldi pl, lo(__cc_sh_val)
    ldi ph, hi(__cc_sh_val)
    mov a, 0
    st a
    inc pl
    st a
exit:
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section bss
    .align 32 ; all internal data have same hi byte
__cc_r_sp: res 2
__cc_sh_val: res 2
__cc_sh_count: res 2
int_ret: res 2
