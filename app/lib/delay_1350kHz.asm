.export delay_5ms
.export delay_100ms
.export delay_60us

    .section text.lcd_delay

; one clock cycle - 750nS
; one nop - 2 clock cycles, 1.5 uS
; delay at least 5 ms at 1.35 MHz - ~6700 cycles
delay_5ms:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    st a
    inc pl
    st b

    ldi b, 255
delay_5ms_loop: ; 28 clock cycles
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    dec b
    ldi pl, lo(delay_5ms_loop)
    ldi ph, hi(delay_5ms_loop)
    jnc

    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

; ~134000 cycles
delay_100ms:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    st a
    inc pl
    st b

    ldi a, hi(4467)
    ldi b, lo(4467)
delay_100ms_loop: ; 30 clock cycles
    nop
    nop
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
    jnc

    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

; 80 cycles
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
    nop
    nop
    nop
    jmp

    .section bss.lcd_delay
    .align 2
delay_return: res 2
