#pragma once
#include "keyboard.h"

import u16 entropy;

/**
 * Same as keyboard_wait_key_released(), but user interaction is also used to get entropy.
 */
import u8 keyboard_wait_key_released_entropy();
