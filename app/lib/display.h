#pragma once

#define DISPLAY_LINE_1 (u8)0x00
#define DISPLAY_LINE_2 (u8)0x40

import u8 display_init();
import u8 display_clear();
import u8 display_set_address(u8 address);
import u8 display_print(u8 *string);
import u8 display_print_byte(u8 byte);
import u8 display_print_char(u8 char);
import u8 display_load_cg_ram(u8 *data); // data should contain 64 bytes - the whole CGRAM
