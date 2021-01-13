#pragma once

#define KEY_ENT 0u8
#define KEY_RIGHT 1u8
#define KEY_0 2u8
#define KEY_LEFT 3u8
#define KEY_ESC 4u8
#define KEY_9 5u8
#define KEY_8 6u8
#define KEY_7 7u8
#define KEY_DOWN 8u8
#define KEY_6 9u8
#define KEY_5 10u8
#define KEY_4 11u8
#define KEY_UP 12u8
#define KEY_3 13u8
#define KEY_2 14u8
#define KEY_1 15u8
#define KEY_STAR 16u8
#define KEY_HASH 17u8
#define KEY_F2 18u8
#define KEY_F1 19u8

#define KEY_NO_KEY 0xffu8

import u8 keyboard_wait_key_released();

/*
    Same as keyboard_wait_key_released(), but does not wait for the key press.
    If no keys are pressed, just returns 0xff.
    If a key is pressed, waits for release and returns the key code.
*/
import u8 keyboard_get_if_pressed();
import u8 bit_mask_to_index[32];
