#pragma once

#define PS2_KEY_RELEASE 0x80u8

#define PS2_KEY_NONE 0u8
#define PS2_KEY_A 'A'
#define PS2_KEY_B 'B'
#define PS2_KEY_C 'C'
#define PS2_KEY_D 'D'
#define PS2_KEY_E 'E'
#define PS2_KEY_F 'F'
#define PS2_KEY_G 'G'
#define PS2_KEY_H 'H'
#define PS2_KEY_I 'I'
#define PS2_KEY_J 'J'
#define PS2_KEY_K 'K'
#define PS2_KEY_L 'L'
#define PS2_KEY_M 'M'
#define PS2_KEY_N 'N'
#define PS2_KEY_O 'O'
#define PS2_KEY_P 'P'
#define PS2_KEY_Q 'Q'
#define PS2_KEY_R 'R'
#define PS2_KEY_S 'S'
#define PS2_KEY_T 'T'
#define PS2_KEY_U 'U'
#define PS2_KEY_V 'V'
#define PS2_KEY_W 'W'
#define PS2_KEY_X 'X'
#define PS2_KEY_Y 'Y'
#define PS2_KEY_Z 'Z'
#define PS2_KEY_0 '0'
#define PS2_KEY_1 '1'
#define PS2_KEY_2 '2'
#define PS2_KEY_3 '3'
#define PS2_KEY_4 '4'
#define PS2_KEY_5 '5'
#define PS2_KEY_6 '6'
#define PS2_KEY_7 '7'
#define PS2_KEY_8 '8'
#define PS2_KEY_9 '9'
#define PS2_KEY_BACKQUOTE '`'
#define PS2_KEY_DASH '-'
#define PS2_KEY_EQUALS '='
#define PS2_KEY_LBRACE '['
#define PS2_KEY_RBRACE ']'
#define PS2_KEY_SEMICOLON ';'
#define PS2_KEY_QUOTE '"'
#define PS2_KEY_BACKSLASH '\\'
#define PS2_KEY_PIPE '|'
#define PS2_KEY_COMMA ','
#define PS2_KEY_DOT '.'
#define PS2_KEY_SLASH '/'
#define PS2_KEY_SPACE ' '
#define PS2_KEY_ESCAPE 121u8
#define PS2_KEY_F1 1u8
#define PS2_KEY_F2 2u8
#define PS2_KEY_F3 3u8
#define PS2_KEY_F4 4u8
#define PS2_KEY_F5 5u8
#define PS2_KEY_F6 6u8
#define PS2_KEY_F7 7u8
#define PS2_KEY_F8 8u8
#define PS2_KEY_F9 9u8
#define PS2_KEY_F10 10u8
#define PS2_KEY_F11 11u8
#define PS2_KEY_F12 12u8
#define PS2_KEY_BACKSPACE 13u8
#define PS2_KEY_TAB 14u8
#define PS2_KEY_CAPSLOCK 15u8
#define PS2_KEY_ENTER 16u8
#define PS2_KEY_LSHIFT 17u8
#define PS2_KEY_RSHIFT 18u8
#define PS2_KEY_LCTRL 19u8
#define PS2_KEY_LALT 20u8
#define PS2_KEY_LWIN 21u8
#define PS2_KEY_RALT 22u8
#define PS2_KEY_RWIN 23u8
#define PS2_KEY_MENU 24u8
#define PS2_KEY_RCTRL 25u8
#define PS2_KEY_INSERT 26u8
#define PS2_KEY_DELETE 27u8
#define PS2_KEY_HOME 28u8
#define PS2_KEY_END 29u8
#define PS2_KEY_PAGEUP 30u8
#define PS2_KEY_PAGEDOWN 31u8
#define PS2_KEY_LEFT 97u8
#define PS2_KEY_RIGHT 98u8
#define PS2_KEY_UP 99u8
#define PS2_KEY_DOWN 100u8
#define PS2_KEY_NUMLOCK 101u8
#define PS2_KEY_NUM_DIV 102u8
#define PS2_KEY_NUM_MUL 103u8
#define PS2_KEY_NUM_SUB 104u8
#define PS2_KEY_NUM_ADD 105u8
#define PS2_KEY_NUM_ENTER 106u8
#define PS2_KEY_NUM_DOT 107u8
#define PS2_KEY_NUM_0 108u8
#define PS2_KEY_NUM_1 109u8
#define PS2_KEY_NUM_2 110u8
#define PS2_KEY_NUM_3 111u8
#define PS2_KEY_NUM_4 112u8
#define PS2_KEY_NUM_5 113u8
#define PS2_KEY_NUM_6 114u8
#define PS2_KEY_NUM_7 115u8
#define PS2_KEY_NUM_8 116u8
#define PS2_KEY_NUM_9 117u8
#define PS2_KEY_SCROLLLOCK 118u8
#define PS2_KEY_PAUSE 119u8
#define PS2_KEY_PRINT 120u8

import u8 ps2_init();
import u8 ps2_get_key_event();
import u8 ps2_wait_key_pressed();
