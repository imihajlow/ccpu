# IO interfaces

## IO board

0xFF00 - keyboard (write rows, read columns).

0xFF02 - CR (control register, write only). Bits 0 to 7:
	* raml_ena - enable lo RAM (1) or ROM (0, default);
	* l_ena - enable left expansion board;
	* r_ena - enable right expansion board;
	* ram_a_ena - enable 0xA000 RAM segment;
	* ram_b_ena - enable 0xB000 RAM segment;
	* ram_c_ena - enable 0xC000 RAM segment;
	* ram_d_ena - enable 0xD000 RAM segment;
	* ram_e_ena - enable 0xE000 RAM segment;

## VGA board

0xD000 - color segment.

0xE000 - char segment.

Lower 12 bits of address: 5 bit row (bits 7-11), 7 bits column (bits 0-10).

Color encoding: lower 4 bits - foreground color, upper 4 bits - background color.

Color encoding is 4 bit IRGB.
