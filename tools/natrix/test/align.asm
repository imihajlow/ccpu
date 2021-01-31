	; Test file which contains misaligned data
	.export aligned_254_1
	.export aligned_255_1
	.export aligned_255_2
	.export aligned_255_3
	.export aligned_255_4
.section text
.align 256
	db 0xf5
	db 0xf6
	db 0xf7
	db 0xf8
	db 0xf9
	res 249
aligned_254_1:
	db 0x99
aligned_255_1:
aligned_255_2:
aligned_255_3:
aligned_255_4:
	db 0xa1
	db 0x05
	db 0x06
	db 0x07
	db 0x08
	db 0x09

