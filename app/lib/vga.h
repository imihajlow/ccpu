#pragma once

#define VGA_ROWS 30u8
#define VGA_COLS 80u8

#define COLOR_BLACK 0u8
#define COLOR_BLUE 1u8
#define COLOR_GREEN 2u8
#define COLOR_CYAN 3u8
#define COLOR_RED 4u8
#define COLOR_MAGENTA 5u8
#define COLOR_BROWN 6u8
#define COLOR_GRAY 7u8
#define COLOR_DARK_GRAY 8u8
#define COLOR_LIGHT_BLUE 9u8
#define COLOR_LIGHT_GREEN 10u8
#define COLOR_LIGHT_CYAN 11u8
#define COLOR_LIGHT_RED 12u8
#define COLOR_LIGHT_MAGENTA 13u8
#define COLOR_YELLOW 14u8
#define COLOR_WHITE 15u8

#define VGA_OFFSET_COL 1u8
#define VGA_OFFSET_ROW 128u8

#define COLOR(fg, bg) ((fg) + ((bg) << 4u8))
#define VGA_OFFSET(col, row) ((u16)(col) + ((u16)(row) << 7u8))

import u8 vga_char_seg[4096];
import u8 vga_color_seg[4096];

/*
    Clear the screen with the given color and char 0.
 */
import u8 vga_clear(u8 color);

/*
    Display a null-terminated string. Colors are not modified.
 */
import u8 vga_put_text(u8 col, u8 row, u8 *text);

/*
    Display a decimal number.
 */
import u8 vga_put_decimal_u16(u8 col, u8 row, u16 val);
