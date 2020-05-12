.section text
    nop
start:
    ldi b, 0x80
    ldi a, 0x00
loop:
    ; b:a - address
    mov pl, a
    mov a, b
    mov ph, a
    mov a, 0

    ; write
    ; cycle size is 9 to prevent any possible binary patterns from appearing
    ldi b, 0x01
    st  b   ; +0

    inc pl
    adc ph, a
    shl b
    st  b   ; +1

    inc pl
    adc ph, a
    shl b
    st  b   ; +2

    inc pl
    adc ph, a
    st  b   ; +3

    inc pl
    adc ph, a
    shl b
    st  b   ; +4

    inc pl
    adc ph, a
    shl b
    st  b   ; +5

    inc pl
    adc ph, a
    shl b
    st  b   ; +6

    inc pl
    adc ph, a
    shl b
    st  b   ; +7

    inc pl
    adc ph, a
    shl b
    st  b   ; +8

    ldi a, 8
    sub pl, a
    mov a, 0
    sbb ph, a

    ; check
    ldi a, 0x01
    ld  b
    sub b, a
    mov a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(fail)
    ldi pl, lo(fail)
    jnz
    mov pl, a
    mov a, b
    mov ph, a
    mov a, 0
    inc pl
    adc ph, a

    ldi a, 0x02
    ld  b
    sub b, a
    mov a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(fail)
    ldi pl, lo(fail)
    jnz
    mov pl, a
    mov a, b
    mov ph, a
    mov a, 0
    inc pl
    adc ph, a

    ldi a, 0x04
    ld  b
    sub b, a
    mov a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(fail)
    ldi pl, lo(fail)
    jnz
    mov pl, a
    mov a, b
    mov ph, a
    mov a, 0
    inc pl
    adc ph, a

    ldi a, 0x04
    ld  b
    sub b, a
    mov a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(fail)
    ldi pl, lo(fail)
    jnz
    mov pl, a
    mov a, b
    mov ph, a
    mov a, 0
    inc pl
    adc ph, a

    ldi a, 0x08
    ld  b
    sub b, a
    mov a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(fail)
    ldi pl, lo(fail)
    jnz
    mov pl, a
    mov a, b
    mov ph, a
    mov a, 0
    inc pl
    adc ph, a

    ldi a, 0x10
    ld  b
    sub b, a
    mov a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(fail)
    ldi pl, lo(fail)
    jnz
    mov pl, a
    mov a, b
    mov ph, a
    mov a, 0
    inc pl
    adc ph, a

    ldi a, 0x20
    ld  b
    sub b, a
    mov a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(fail)
    ldi pl, lo(fail)
    jnz
    mov pl, a
    mov a, b
    mov ph, a
    mov a, 0
    inc pl
    adc ph, a

    ldi a, 0x40
    ld  b
    sub b, a
    mov a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(fail)
    ldi pl, lo(fail)
    jnz
    mov pl, a
    mov a, b
    mov ph, a
    mov a, 0
    inc pl
    adc ph, a

    ldi a, 0x80
    ld  b
    sub b, a
    mov a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(fail)
    ldi pl, lo(fail)
    jnz
    mov pl, a
    mov a, b
    mov ph, a
    mov a, 0
    inc pl
    adc ph, a

    mov a, ph
    mov b, a
    mov a, pl
    ldi ph, hi(loop)
    ldi pl, lo(loop)
    jmp
fail:
    ; check if failed address is 0xff00 and repeat the loop
    ldi ph, hi(error)
    ldi pl, lo(error)
    add a, 0
    jnz
    ldi a, 0xf0
    sub b, a
    jnz
    ldi ph, hi(start)
    ldi pl, lo(start)
    jmp

.align 0x400
error:
    ldi ph, hi(error)
    ldi pl, lo(error)
    jmp
