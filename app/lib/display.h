#pragma once

#define DISPLAY_LINE_1 (u8)0x00
#define DISPLAY_LINE_2 (u8)0x40

import s8 display_init();
import s8 display_clear();
import s8 display_set_address(u8 address);
import s8 display_print(u8 *string);
import s8 display_print_byte(u8 byte);
import s8 display_print_char(u8 char);
