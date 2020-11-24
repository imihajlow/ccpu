.export delay_5ms
.export delay_100ms
.export delay_60us

    .section text


; one nop - 2 clock cycles, 6.6 uS
; delay at least 5 ms at 300 kHz - ~1500 cycles
delay_5ms:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    st a
    inc pl
    st b

    ldi a, 63
delay_5ms_loop: ; 24 clock cycles
    nop
    nop
    nop
    nop
    nop
    nop
    dec a
    ldi pl, lo(delay_5ms_loop)
    ldi ph, hi(delay_5ms_loop)
    jnz

    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

; ~30000 cycles
delay_100ms:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    st a
    inc pl
    st b

    ldi a, 5
    ldi b, 0
delay_100ms_loop: ; 24 clock cycles
    nop
    nop
    nop
    nop
    nop
    nop
    dec b
    sbb a, 0
    ldi pl, lo(delay_100ms_loop)
    ldi ph, hi(delay_100ms_loop)
    jns

    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

; ~18 cycles
delay_60us: ; should not modify registers!!!
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    jmp

    .section bss
    .align 2
delay_return: res 2
