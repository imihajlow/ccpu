; Matrix keyboard 5 rows (write) x 4 cols (read)
;   | 3   2   1   0
;  -+---------------
;  4| F1  F2  #   *
;  3| 1   2   3   ^
;  2| 4   5   6   v
;  1| 7   8   9   esc
;  0| <   0   >   ent
;
; Key code = row * 4 + col
    .export key_ent
    .export key_right
    .export key_0
    .export key_left
    .export key_esc
    .export key_9
    .export key_8
    .export key_7
    .export key_down
    .export key_6
    .export key_5
    .export key_4
    .export key_up
    .export key_3
    .export key_2
    .export key_1
    .export key_star
    .export key_hash
    .export key_f2
    .export key_f1

    .export keyboard_key_digit_map
    .export bit_mask_to_index

; wait until a key is released
; the key code (byte) is returned in keyboard_wait_key_released_result
    .export keyboard_wait_key_released
    .export keyboard_wait_key_released_result
    .export keyboard_wait_key_released_ret

    .const key_ent = 0
    .const key_right = 1
    .const key_0 = 2
    .const key_left = 3
    .const key_esc = 4
    .const key_9 = 5
    .const key_8 = 6
    .const key_7 = 7
    .const key_down = 8
    .const key_6 = 9
    .const key_5 = 10
    .const key_4 = 11
    .const key_up = 12
    .const key_3 = 13
    .const key_2 = 14
    .const key_1 = 15
    .const key_star = 16
    .const key_hash = 17
    .const key_f2 = 18
    .const key_f1 = 19

    .const keyboard = 0xff00

    .section bss
    .align 2
keyboard_wait_key_released_ret:
keyboard_wait_key_released_result: res 1
    .section text
keyboard_wait_key_released:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(keyboard_ret)
    ldi ph, hi(keyboard_ret)
    st a
    mov a, 0
    inc pl
    adc ph, a
    st b

    ; scan rows until a key is pressed (a column value is not 0xff)
keyboard_wait_key_released__wait_press:
    ldi pl, lo(keyboard)
    ldi ph, hi(keyboard)
    ldi a, 0xfe
    st a
    ld b
    inc b
    mov a, 0
    ldi pl, lo(keyboard_wait_key_released__pressed)
    ldi ph, hi(keyboard_wait_key_released__pressed)
    jnz

    ldi pl, lo(keyboard)
    ldi ph, hi(keyboard)
    ldi a, 0xfd
    st a
    ld b
    inc b
    ldi a, 4
    ldi pl, lo(keyboard_wait_key_released__pressed)
    ldi ph, hi(keyboard_wait_key_released__pressed)
    jnz

    ldi pl, lo(keyboard)
    ldi ph, hi(keyboard)
    ldi a, 0xfb
    st a
    ld b
    inc b
    ldi a, 8
    ldi pl, lo(keyboard_wait_key_released__pressed)
    ldi ph, hi(keyboard_wait_key_released__pressed)
    jnz

    ldi pl, lo(keyboard)
    ldi ph, hi(keyboard)
    ldi a, 0xf7
    st a
    ld b
    inc b
    ldi a, 12
    ldi pl, lo(keyboard_wait_key_released__pressed)
    ldi ph, hi(keyboard_wait_key_released__pressed)
    jnz

    ldi pl, lo(keyboard)
    ldi ph, hi(keyboard)
    ldi a, 0xef
    st a
    ld b
    inc b
    ldi a, 16
    ; last condition - jump to the loop begin
    ldi pl, lo(keyboard_wait_key_released__wait_press)
    ldi ph, hi(keyboard_wait_key_released__wait_press)
    jz

keyboard_wait_key_released__pressed:
    ; a - row * 4
    ; b - ~col_mask + 1
    dec b
    not b
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st a

keyboard_wait_key_released__wait_release:
    ldi pl, lo(keyboard)
    ldi ph, hi(keyboard)
    ld a
    inc a
    ldi pl, lo(keyboard_wait_key_released__wait_release)
    ldi ph, hi(keyboard_wait_key_released__wait_release)
    jnz

    ; all keys in the row are released
    ; b - col_mask (1..15)
    ; to prevent garbage, zero upper 4 bits
    ldi a, 0x0f
    and a, b
    ldi pl, lo(bit_mask_to_index)
    ldi ph, hi(bit_mask_to_index)
    add pl, a
    ld b
    ; b - col index
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a
    ; a - row * 4
    add a, b
    ; store the result
    ldi pl, lo(keyboard_wait_key_released_result)
    ldi ph, hi(keyboard_wait_key_released_result)
    st a

    ; return
    ldi pl, lo(keyboard_ret)
    ldi ph, hi(keyboard_ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

; mapping from a col mask to a col index: lower index has priority
    .align 32 ; guarantees no ph overflow
bit_mask_to_index:
    db 0 ; 0
    db 0 ; 1
    db 1 ; 2
    db 0 ; 3
    db 2 ; 4
    db 0 ; 5
    db 1 ; 6
    db 0 ; 7
    db 3 ; 8
    db 0 ; 9
    db 1 ; 10
    db 0 ; 11
    db 2 ; 12
    db 0 ; 13
    db 1 ; 14
    db 0 ; 15
    db 4 ; 16
    db 0 ; 17
    db 1 ; 18
    db 0 ; 19
    db 2 ; 20
    db 0 ; 21
    db 1 ; 22
    db 0 ; 23
    db 3 ; 24
    db 0 ; 25
    db 1 ; 26
    db 0 ; 27
    db 2 ; 28
    db 0 ; 29
    db 1 ; 30
    db 0 ; 31

; Mapping from a key code to a digit. Keys which are not digits are 0xff
    .align 32 ; guarantees no ph overflow
keyboard_key_digit_map:
    db 0xff
    db 0xff
    db 0
    db 0xff
    db 0xff
    db 9
    db 8
    db 7
    db 0xff
    db 6
    db 5
    db 4
    db 0xff
    db 3
    db 2
    db 1
    db 0xff
    db 0xff
    db 0xff
    db 0xff

    .section data
    .align 2
keyboard_ret: res 2
tmp: res 1
