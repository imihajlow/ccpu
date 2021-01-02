; Test low RAM. High RAM must be functional. To check high ram, use memcheck.asm
.export main
.global __seg_ramtext_begin
.global __seg_ramtext_end
.global __seg_ramtext_origin_begin
.global __seg_ramtext_origin_end

.global memcpy
.global memcpy_arg0
.global memcpy_arg1
.global memcpy_arg2

.section text
main:
    ; load ramtext
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

    ldi pl, lo(high_start)
    ldi ph, hi(high_start)
    jmp

.section ramtext
high_start:
    ldi pl, lo(pointer)
    ldi ph, hi(pointer)
    ldi a, 55
    st a
    inc pl
    inc a
    st a
    ldi pl, lo(pointer)
    ldi ph, hi(pointer)
    ld a
    inc pl
    ld b
    sub b, a
    ldi pl, 55
    sub a, pl
    ldi pl, lo(blink)
    ldi ph, hi(blink)
    jnz
    ldi a, 1
    sub a, b
    jnz

    ldi pl, 0x02
    ldi ph, 0xff
    ldi a, 0xf9 ; enable all segments and lo RAM
    st a

    ldi pl, lo(pointer)
    ldi ph, hi(pointer)
    mov a, 0
    st a
    inc pl
    st a
write_loop:
    ldi pl, lo(pointer)
    ldi ph, hi(pointer)
    ; P = pointer
    ld b
    inc pl
    ld a
    ; a:b = [pointer]
    inc b
    adc a, 0
    ; [pointer] += 1
    st a
    dec pl
    st b

    dec b
    sbb a, 0
    ldi pl, lo(write_end)
    ldi ph, hi(write_end)
    js ; [pointer] >= 0x8000
    mov ph, a
    mov a, b
    mov pl, a
    st a ; [[pointer]] = lo([pointer])
    ldi pl, lo(write_loop)
    ldi ph, hi(write_loop)
    jmp
write_end:
    ldi pl, lo(pointer)
    ldi ph, hi(pointer)
    mov a, 0
    st a
    inc pl
    st a

read_loop:
    ldi pl, lo(pointer)
    ldi ph, hi(pointer)
    ; P = pointer
    ld b
    inc pl
    ld a
    ; a:b = [pointer]
    inc b
    adc a, 0
    ; [pointer] += 1
    st a
    dec pl
    st b

    dec b
    sbb a, 0
    ldi pl, lo(read_end)
    ldi ph, hi(read_end)
    js ; [pointer] >= 0x8000
    mov ph, a
    mov a, b
    mov pl, a
    ld b
    sub a, b
    ldi pl, lo(read_error)
    ldi ph, hi(read_error)
    jnz
    ldi pl, lo(read_loop)
    ldi ph, hi(read_loop)
    jmp

read_end:
    ldi pl, lo(high_start)
    ldi ph, hi(high_start)
    jmp

read_error:
blink:
    ldi pl, lo(value)
    ldi ph, hi(value)
    ld b
    not b
    st b
    ldi a, 0x06
    and b, a
    ldi pl, 0x02
    ldi ph, 0xff
    ldi a, 0xf8
    or a, b
    st a
    ldi pl, lo(counter)
    ldi ph, hi(counter)
    ldi b, lo(10000)
    ldi a, hi(10000)
delay_loop:
    nop
    nop
    ldi pl, lo(counter)
    ldi ph, hi(counter)
    st b
    inc pl
    st a
    dec b
    sbb a, 0
    ldi pl, lo(delay_loop)
    ldi ph, hi(delay_loop)
    jnc


    ldi pl, lo(blink)
    ldi ph, hi(blink)
    jmp

.section bss
.align 2
pointer:
counter: res 2
value: res 1
