    .export lorun
    .export lorun_ret

    .section ramtext.lorun
lorun_ret:
lorun:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(0xff02)
    ldi ph, hi(0xff02)
    ldi a, 0x3f ; enable segments A-C, both boards, lo RAM
    st a

    mov a, 0
    mov pl, a
    mov ph, a
    jmp

    ldi pl, lo(0xff02)
    ldi ph, hi(0xff02)
    ldi a, 0x3e ; enable segments A-C, both boards, disable lo RAM
    st a

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp


    .section bss.lorun
    .align 2
ret:
    res 2
