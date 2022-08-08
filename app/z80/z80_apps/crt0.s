    .module crt0
    .globl  _main

    .area _CODE
    ;; Initialise global variables
    call    gsinit
    call    _main
    jp  _exit

    ;; Ordering of segments for the linker.
    .area   _CODE
    .area   _HOME
    .area   _INITIALIZER
    .area   _GSINIT
    .area   _GSFINAL

    .area   _DATA
    .area   _INITIALIZED
    .area   _BSEG
    .area   _BSS
    .area   _HEAP

    .area   _CODE
_exit::
    ;; Exit - special code to the emulator
    halt

    .area   _GSINIT
gsinit::

    ; Default-initialized global variables.
        ld      bc, #l__DATA
        ld      a, b
        or      a, c
        jr      Z, zeroed_data
        ld      hl, #s__DATA
        ld      (hl), #0x00
        dec     bc
        ld      a, b
        or      a, c
        jr      Z, zeroed_data
        ld      e, l
        ld      d, h
        inc     de
        ldir
zeroed_data:

    ; Explicitly initialized global variables.
    ld  bc, #l__INITIALIZER
    ld  a, b
    or  a, c
    jr  Z, gsinit_next
    ld  de, #s__INITIALIZED
    ld  hl, #s__INITIALIZER
    ldir

gsinit_next:

    .area   _GSFINAL
    ret

