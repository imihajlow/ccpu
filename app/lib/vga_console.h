#pragma once
#include "vga.h"

import u8 vga_console_init(u8 color);

import u8 vga_console_print(u8 *text);

import u8 vga_console_putchar(u8 char);

import u8 vga_console_newline();

import u8 vga_console_return();
