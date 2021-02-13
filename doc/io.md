# IO interfaces

## IO board

0xFF00 - keyboard (write rows, read columns).

0xFF02 - CR (control register, write only). Bits 0 to 7:
	* bit 0 - raml_ena - enable lo RAM (1) or ROM (0, default);
	* bit 1 - l_ena - enable left expansion board;
	* bit 2 - r_ena - enable right expansion board;
	* bit 3 - ram_a_ena - enable 0xA000 RAM segment;
	* bit 4 - ram_b_ena - enable 0xB000 RAM segment;
	* bit 5 - ram_c_ena - enable 0xC000 RAM segment;
	* bit 6 - ram_d_ena - enable 0xD000 RAM segment;
	* bit 7 - ram_e_ena - enable 0xE000 RAM segment.

## VGA board

0xD000 - color segment.

0xE000 - char segment.

Lower 12 bits of address: 5 bit row (bits 7-11), 7 bits column (bits 0-10).

Color encoding: lower 4 bits - foreground color, upper 4 bits - background color.

Color encoding is 4 bit IRGB.

## Vario board

0xFE00 - PS/2 data (RW). RDY is blocked if data reception or transmission is in progress.

0xFE01 - PS/2 status. RDY is blocked if data reception or transmission is in progress. Write any value to reset. Read:
	* bit 0 - has_data;
	* bit 1 - recv_valid;
	* bit 2 - send_ack (0 = valid ACK).

0xFE02 - SPI data (RW). Write initiates transmission. RDY is blocked when data transfer is in progress.

0xFE03 - memory card control:
	* bit 0 - n_card_detect (RO);
	* bit 1 - write_protect (RO);
	* bit 2 - n_card_cs (WO);
	* bit 3 - en_3v3 (WO).

### PS/2 algorithm

Read data:
```
	status = read(0xFE01)
	if status & has_data:
		if status & recv_valid:
			data = read(0xFE00)
		else:
			handle error
		write(0xFE01, 0)
```

Write data:
```
	write(0xFE00, data)
	status = read(0xFE01)
	if (status & send_ack) == 0:
		success
	else:
		fail
```
