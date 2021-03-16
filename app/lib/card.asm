    .export card_is_present
    .export card_is_present_ret

    .export card_power_off

    .export card_init
    .export card_init_ret

    .export card_read_block
    .export card_read_block_arg0
    .export card_read_block_arg1
    .export card_read_block_ret

    .export card_write_block
    .export card_write_block_arg0
    .export card_write_block_arg1
    .export card_write_block_ret

    .export cache_block

    .const SPI_DATA = 0xFD02
    .const SPI_CTRL = 0xFD03

    .const SPI_CTRL_N_CARD_DETECT = 1
    .const SPI_CTRL_WRITE_PROTECT = 2
    .const SPI_CTRL_N_CARD_CS = 4
    .const SPI_CTRL_EN_3V3 = 8

    .const CARD_SUCCESS = 0
    .const CARD_ERROR_TIMEOUT = 1
    .const CARD_ERROR_RESET_FAILED = 2
    .const CARD_ERROR_ACMD_FAILED = 3
    .const CARD_ERROR_ACMD41_FAILED = 4
    .const CARD_ERROR_BAD_DATA_RESPONSE = 5
    .const CARD_ERROR_WRITE_ERROR = 6
    .const CARD_ERROR_CRC_ERROR = 7
    .const CARD_ERROR_NO_CARD = 8
    .const CARD_ERROR_NOT_INITIALIZED = 9
    .const CARD_ERROR_LOCKED = 10
    .const CARD_ERROR_OUT_OF_RANGE = 11
    .const CARD_ERROR_BLOCK_CMD_FAILED = 12

    .const DATA_RSP_ACCEPTED = 0x05
    .const DATA_RSP_CRC_ERROR = 0x0b
    .const DATA_RSP_WRITE_ERROR = 0x0d

    .const TIMEOUT_BLOCK = 20

    .section text.card_is_present
card_is_present:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(SPI_CTRL)
    ldi ph, hi(SPI_CTRL)
    ld a
    shr a ; bit 0 - N_CARD_DETECT

    mov a, 0
    sbb a, 0
    inc a
    ldi pl, lo(card_is_present_ret)
    ldi ph, hi(card_is_present_ret)
    st a

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section text.card_power_off
card_power_off:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(SPI_CTRL)
    ldi ph, hi(SPI_CTRL)
    ldi a, SPI_CTRL_N_CARD_CS
    st a

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section text.card_init
card_init:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(card_init_ret)
    ldi ph, hi(card_init_ret)
    mov a, 0 ; CARD_SUCCESS
    st a

    ; check for card
    ldi pl, lo(SPI_CTRL)
    ldi ph, hi(SPI_CTRL)
    ld b
    shr b ; N_CARD_DETECT = 1
    ldi b, CARD_ERROR_NO_CARD
    ldi pl, lo(error)
    ldi ph, hi(error)
    jc

    ; power on
    ; SPI_CTRL = SPI_CTRL_EN_3V3 | SPI_CTRL_N_CARD_CS
    ldi pl, lo(SPI_CTRL)
    ldi ph, hi(SPI_CTRL)
    ldi a, SPI_CTRL_EN_3V3 | SPI_CTRL_N_CARD_CS
    st a

    ldi pl, lo(delay_1ms)
    ldi ph, hi(delay_1ms)
    jmp

    ; 80 SPI clocks
    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    ldi a, 0xff
    st a
    st a
    st a
    st a
    st a

    st a
    st a
    st a
    st a
    st a

    ; SPI_CTRL = SPI_CTRL_EN_3V3
    inc pl
    ldi a, SPI_CTRL_EN_3V3
    st a

    ; CMD0, soft reset
    dec pl
    ldi a, 0x40
    st a
    mov a, 0
    st a
    st a
    st a
    st a
    ldi a, 0x95
    st a

    ; wait for responce 4 times
    ldi b, 0xff
    st b
    ld a
    inc a
    ldi pl, lo(cmd0_rsp)
    ldi ph, hi(cmd0_rsp)
    jnz

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st b
    ld a
    inc a
    ldi pl, lo(cmd0_rsp)
    ldi ph, hi(cmd0_rsp)
    jnz

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st b
    ld a
    inc a
    ldi pl, lo(cmd0_rsp)
    ldi ph, hi(cmd0_rsp)
    jnz

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st b
    ld a
    inc a
    ldi pl, lo(cmd0_rsp)
    ldi ph, hi(cmd0_rsp)
    jnz

    ; timeout
    ldi b, CARD_ERROR_TIMEOUT
    ldi pl, lo(error)
    ldi ph, hi(error)
    jmp

cmd0_rsp:
    ; a = response + 1
    dec a
    dec a
    ldi b, CARD_ERROR_RESET_FAILED
    ldi pl, lo(error)
    ldi ph, hi(error)
    jnz

    ; a = 0
    ; send FF
    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    dec a
    st a

ready_loop:
        ; ACMD41 = CMD55 + CMD41

        ; CMD55
        ldi pl, lo(SPI_DATA)
        ldi ph, hi(SPI_DATA)
        ldi a, 0x40 | 55
        st a
        mov a, 0
        st a
        st a
        st a
        st a
        dec a
        st a

        ; wait until bit 7 is set
    cmd55_ready_loop:
            ldi pl, lo(SPI_DATA)
            ldi ph, hi(SPI_DATA)
            st a
            ld b
            and b, a
            ldi pl, lo(cmd55_ready_loop)
            ldi ph, hi(cmd55_ready_loop)
            js

        ; b = response
        ldi a, 0xfe
        and a, b
        ldi b, CARD_ERROR_ACMD_FAILED
        ldi pl, lo(error)
        ldi ph, hi(error)
        jnz

        ; send FF
        ldi pl, lo(SPI_DATA)
        ldi ph, hi(SPI_DATA)
        ldi a, 0xff
        st a

        ; CMD41
        ldi pl, lo(SPI_DATA)
        ldi ph, hi(SPI_DATA)
        ldi a, 0x40 | 41
        st a
        mov a, 0
        st a
        st a
        st a
        st a
        dec a
        st a

        ; wait until bit 7 is set
    cmd41_ready_loop:
            ldi pl, lo(SPI_DATA)
            ldi ph, hi(SPI_DATA)
            st a
            ld b
            and b, a
            ldi pl, lo(cmd41_ready_loop)
            ldi ph, hi(cmd41_ready_loop)
            js

        ; send FF
        ldi pl, lo(SPI_DATA)
        ldi ph, hi(SPI_DATA)
        ldi a, 0xff
        st a

        ; b = response
        mov a, b
        add a, 0
        ldi pl, lo(finish)
        ldi ph, hi(finish)
        jz ; response == 0

        dec a
        ldi b, CARD_ERROR_ACMD41_FAILED
        ldi pl, lo(error)
        ldi ph, hi(error)
        jnz ; response != 1

        ldi pl, lo(ready_loop)
        ldi ph, hi(ready_loop)
        jmp

error:
    ; power off
    ldi pl, lo(SPI_CTRL)
    ldi ph, hi(SPI_CTRL)
    mov a, 0
    st a
soft_error:
    ldi pl, lo(card_init_ret)
    ldi ph, hi(card_init_ret)
    st b
finish:
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

block_error:
    ; a = response + 2


    .section text.card_read_block
card_read_block:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(card_init_ret)
    ldi ph, hi(card_init_ret)
    mov a, 0 ; CARD_SUCCESS
    st a

    ; check for card
    ldi pl, lo(SPI_CTRL)
    ldi ph, hi(SPI_CTRL)
    ld b
    shr b ; N_CARD_DETECT = 1
    ldi b, CARD_ERROR_NO_CARD
    ldi pl, lo(error)
    ldi ph, hi(error)
    jc

    ; shift block index by 1
    ldi pl, lo(card_read_block_arg0 + 1)
    ldi ph, hi(card_read_block_arg0 + 1)
    ld b
    inc pl
    ld a
    shl a
    shl b
    adc a, 0
    st a
    mov a, b
    ldi pl, lo(card_read_block_arg0)
    ld b
    shl b
    adc a, 0
    st b
    inc pl
    st a

    ; CMD17
    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    ldi a, 0x40 | 17
    st a ; CMD17
    ldi pl, lo(card_read_block_arg0 + 2)
    ldi ph, hi(card_read_block_arg0 + 2)
    ld a
    dec pl
    ld b
    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st a ; addr[3]
    st b ; addr[2]
    ldi pl, lo(card_read_block_arg0)
    ldi ph, hi(card_read_block_arg0)
    ld a
    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st a ; addr[1]
    mov a, 0
    st a ; addr[0]
    dec a
    st a ; CRC

    ; wait for responce 4 times
    ldi b, 0xff
    st b
    ld a
    inc a
    ldi pl, lo(cmd17_rsp)
    ldi ph, hi(cmd17_rsp)
    jnz

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st b
    ld a
    inc a
    ldi pl, lo(cmd17_rsp)
    ldi ph, hi(cmd17_rsp)
    jnz

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st b
    ld a
    inc a
    ldi pl, lo(cmd17_rsp)
    ldi ph, hi(cmd17_rsp)
    jnz

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st b
    ld a
    inc a
    ldi pl, lo(cmd17_rsp)
    ldi ph, hi(cmd17_rsp)
    jnz

    ; timeout
    ldi b, CARD_ERROR_TIMEOUT
    ldi pl, lo(soft_error)
    ldi ph, hi(soft_error)
    jmp

cmd17_rsp:
    ; a = response + 1
    dec a
    ldi pl, lo(cmd17_success)
    ldi ph, hi(cmd17_success)
    jz

    ; send FF
    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    ldi b, 0xff
    st b

    shr a
    ldi pl, lo(soft_error)
    ldi ph, hi(soft_error)
    ldi b, CARD_ERROR_NOT_INITIALIZED
    jc ; card is in idle state

    ldi b, CARD_ERROR_BLOCK_CMD_FAILED
    jmp

cmd17_success:

    ldi b, TIMEOUT_BLOCK
read_block_rsp_loop:
        dec b
        ldi pl, lo(read_block_timeout)
        ldi ph, hi(read_block_timeout)
        jc

        ldi pl, lo(SPI_DATA)
        ldi ph, hi(SPI_DATA)
        ldi a, 0xff
        st a
        ld a
        inc a
        ldi pl, lo(read_block_rsp_loop)
        ldi ph, hi(read_block_rsp_loop)
        jz ; response = 0xff

    ; a = response + 1
    inc a
    ldi pl, lo(block_error)
    ldi ph, hi(block_error)
    jnz ; response is not a valid data token (0xFE)

    mov a, 0
read_block_loop_1:
        ldi pl, lo(SPI_DATA)
        ldi ph, hi(SPI_DATA)
        ldi b, 0xff
        st b
        ld b
        ldi ph, hi(cache_block)
        mov pl, a
        st b
        inc a
        ldi pl, lo(read_block_loop_1)
        ldi ph, hi(read_block_loop_1)
        jnc
read_block_loop_2:
        ldi pl, lo(SPI_DATA)
        ldi ph, hi(SPI_DATA)
        ldi b, 0xff
        st b
        ld b
        ldi ph, hi(cache_block + 256)
        mov pl, a
        st b
        inc a
        ldi pl, lo(read_block_loop_2)
        ldi ph, hi(read_block_loop_2)
        jnc

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    dec a
    st a ; CRC
    st a ; CRC

    st a ; final transfer

    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp


read_block_timeout:
    ldi b, CARD_ERROR_TIMEOUT
    ldi pl, lo(error)
    ldi ph, hi(error)
    jmp

.section text.card_write_block
card_write_block:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(card_init_ret)
    ldi ph, hi(card_init_ret)
    mov a, 0 ; CARD_SUCCESS
    st a

    ; check for card
    ldi pl, lo(SPI_CTRL)
    ldi ph, hi(SPI_CTRL)
    ld b
    shr b ; N_CARD_DETECT = 1
    ldi b, CARD_ERROR_NO_CARD
    ldi pl, lo(error)
    ldi ph, hi(error)
    jc

    ; shift block index by 1
    ldi pl, lo(card_write_block_arg0 + 1)
    ldi ph, hi(card_write_block_arg0 + 1)
    ld b
    inc pl
    ld a
    shl a
    shl b
    adc a, 0
    st a
    mov a, b
    ldi pl, lo(card_write_block_arg0)
    ld b
    shl b
    adc a, 0
    st b
    inc pl
    st a

    ; CMD24
    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    ldi a, 0x40 | 24
    st a ; CMD24
    ldi pl, lo(card_write_block_arg0 + 2)
    ldi ph, hi(card_write_block_arg0 + 2)
    ld a
    dec pl
    ld b
    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st a ; addr[3]
    st b ; addr[2]
    ldi pl, lo(card_write_block_arg0)
    ldi ph, hi(card_write_block_arg0)
    ld a
    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st a ; addr[1]
    mov a, 0
    st a ; addr[0]
    dec a
    st a ; CRC

    ; wait for responce 4 times
    ldi b, 0xff
    st b
    ld a
    inc a
    ldi pl, lo(cmd24_rsp)
    ldi ph, hi(cmd24_rsp)
    jnz

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st b
    ld a
    inc a
    ldi pl, lo(cmd24_rsp)
    ldi ph, hi(cmd24_rsp)
    jnz

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st b
    ld a
    inc a
    ldi pl, lo(cmd24_rsp)
    ldi ph, hi(cmd24_rsp)
    jnz

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    st b
    ld a
    inc a
    ldi pl, lo(cmd24_rsp)
    ldi ph, hi(cmd24_rsp)
    jnz

    ; timeout
    ldi b, CARD_ERROR_TIMEOUT
    ldi pl, lo(soft_error)
    ldi ph, hi(soft_error)
    jmp

cmd24_rsp:
    ; a = response + 1
    dec a
    ldi pl, lo(cmd24_success)
    ldi ph, hi(cmd24_success)
    jz

    ; send FF
    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    ldi b, 0xff
    st b

    shr a
    ldi pl, lo(soft_error)
    ldi ph, hi(soft_error)
    ldi b, CARD_ERROR_NOT_INITIALIZED
    jc ; card is in idle state

    ldi b, CARD_ERROR_BLOCK_CMD_FAILED
    jmp

cmd24_success:

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    ldi a, 0xff
    st a ; send FF
    st a ; send FF
    dec a
    st a ; data token - 0xFE

    mov a, 0
send_block_loop1:
        ldi ph, hi(cache_block)
        mov pl, a
        ld b
        ldi pl, lo(SPI_DATA)
        ldi ph, hi(SPI_DATA)
        st b
        inc a
        ldi pl, lo(send_block_loop1)
        ldi ph, hi(send_block_loop1)
        jnc
send_block_loop2:
        ldi ph, hi(cache_block + 256)
        mov pl, a
        ld b
        ldi pl, lo(SPI_DATA)
        ldi ph, hi(SPI_DATA)
        st b
        inc a
        ldi pl, lo(send_block_loop2)
        ldi ph, hi(send_block_loop2)
        jnc

    ldi pl, lo(SPI_DATA)
    ldi ph, hi(SPI_DATA)
    dec a
    st a ; CRC
    st a ; CRC
    st a ; read data response
    ld b

send_block_busy_loop:
        ldi pl, lo(SPI_DATA)
        ldi ph, hi(SPI_DATA)
        ldi a, 0xff
        st a
        ld a
        inc a
        ldi pl, lo(send_block_busy_loop)
        ldi ph, hi(send_block_busy_loop)
        jnz ; loop if response is not 0xff - busy

    ; b - data response
    ldi a, 0x1f ; meaningful bits
    and a, b

    ldi pl, DATA_RSP_ACCEPTED
    sub pl, a
    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jz

    ldi pl, DATA_RSP_WRITE_ERROR
    sub pl, a
    ldi pl, lo(soft_error)
    ldi ph, hi(soft_error)
    ldi b, CARD_ERROR_WRITE_ERROR
    jz

    ldi pl, DATA_RSP_CRC_ERROR
    sub pl, a
    ldi pl, lo(soft_error)
    ldi ph, hi(soft_error)
    ldi b, CARD_ERROR_CRC_ERROR
    jz

    ldi b, CARD_ERROR_BAD_DATA_RESPONSE
    jmp

    .section text.delay
delay_1ms:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(delay_ret)
    ldi ph, hi(delay_ret)
    st b
    inc pl
    st a

    ldi a, 0x02
    ldi b, 0x00
delay_loop: ; 7 cycles, 2 uS @ 3.5 MHz
        dec b
        sbb a, 0
        ldi pl, lo(delay_loop)
        ldi ph, hi(delay_loop)
        jnc

    ldi pl, lo(delay_ret)
    ldi ph, hi(delay_ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section bss.card
    .align 4
ret:
    res 2
card_init_ret:
card_read_block_ret:
card_write_block_ret:
card_is_present_ret:
    res 2
card_read_block_arg0:
card_write_block_arg0:
    res 4
card_read_block_arg1:
card_write_block_arg1:
    res 2
delay_ret:
    res 2

    .section bss.card_block
    .align 256
cache_block:
    res 512
