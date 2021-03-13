    .export copy_to_loram
    .export copy_to_loram_arg0
    .export copy_to_loram_ret
    .export loload_buf

    .section ramtext.loload
copy_to_loram:
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
    mov a, 0 ; counter
copy_loop:
        ldi ph, hi(loload_buf)
        mov pl, a
        ld b
        ldi ph, hi(dst_hi)
        ldi pl, lo(dst_hi)
        ld ph
        mov pl, a
        st b
        inc a
        ldi pl, lo(copy_loop)
        ldi ph, hi(copy_loop)
        jnc

    ldi pl, lo(0xff02)
    ldi ph, hi(0xff02)
    ldi a, 0x3e ; enable segments A-C, both boards, disble lo RAM
    st a

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section bss.loload
    .align 2
ret:
    res 2
copy_to_loram_arg0:
copy_to_loram_ret:
dst_hi:
    res 1

    .align 256
loload_buf:
    res 256
