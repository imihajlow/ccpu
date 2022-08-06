    .global z80run

.export rst_00_handler
.export rst_08_handler
.export rst_10_handler
.export rst_18_handler
.export rst_20_handler
.export rst_28_handler
.export rst_30_handler
.export rst_38_handler

    .section init
    .align 0x10000

rst_00_handler:
rst_08_handler:
rst_10_handler:
rst_18_handler:
rst_20_handler:
rst_28_handler:
rst_30_handler:
rst_38_handler:
    ldi pl, lo(z80run)
