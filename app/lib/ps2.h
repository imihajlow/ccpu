#pragma once

#define PS2_DATA *((u8*)0xFD00)
#define PS2_STATUS *((u8*)0xFD01)

#define PS2_STATUS_HAS_DATA 1u8
#define PS2_STATUS_RECV_VALID 2u8
#define PS2_STATUS_SEND_ACK 4u8

#define PS2_LED_SCROLL 1u8
#define PS2_LED_NUM 2u8
#define PS2_LED_CAPS 4u8

#define PS2_DELAY_250_MS (0u8 << 5u8)
#define PS2_DELAY_500_MS (1u8 << 5u8)
#define PS2_DELAY_750_MS (2u8 << 5u8)
#define PS2_DELAY_1000_MS (3u8 << 5u8)

// CPTS = characters per ten seconds
#define PS2_RATE_300_CPTS 0u8
#define PS2_RATE_267_CPTS 1u8
#define PS2_RATE_240_CPTS 2u8
#define PS2_RATE_218_CPTS 3u8
#define PS2_RATE_207_CPTS 4u8
#define PS2_RATE_185_CPTS 5u8
#define PS2_RATE_171_CPTS 6u8
#define PS2_RATE_160_CPTS 7u8
#define PS2_RATE_150_CPTS 8u8
#define PS2_RATE_133_CPTS 9u8
#define PS2_RATE_120_CPTS 10u8
#define PS2_RATE_109_CPTS 11u8
#define PS2_RATE_100_CPTS 12u8
#define PS2_RATE_92_CPTS 13u8
#define PS2_RATE_86_CPTS 14u8
#define PS2_RATE_80_CPTS 15u8
#define PS2_RATE_75_CPTS 16u8
#define PS2_RATE_67_CPTS 17u8
#define PS2_RATE_60_CPTS 18u8
#define PS2_RATE_55_CPTS 19u8
#define PS2_RATE_50_CPTS 20u8
#define PS2_RATE_46_CPTS 21u8
#define PS2_RATE_43_CPTS 22u8
#define PS2_RATE_40_CPTS 23u8
#define PS2_RATE_37_CPTS 24u8
#define PS2_RATE_33_CPTS 25u8
#define PS2_RATE_30_CPTS 26u8
#define PS2_RATE_27_CPTS 27u8
#define PS2_RATE_25_CPTS 28u8
#define PS2_RATE_23_CPTS 29u8
#define PS2_RATE_21_CPTS 30u8
#define PS2_RATE_20_CPTS 31u8

#define PS2_READ_EMPTY 0xffu8
#define PS2_CODE_RESEND 0xFEu8
#define PS2_CODE_BAT_PASSED 0xAAu8
#define PS2_CODE_BAT_ERROR 0xFCu8
#define PS2_CODE_BAT_ERROR_2 0xFDu8
#define PS2_CODE_ACK 0xFAu8
#define PS2_CODE_BUFFER_OVERRUN 0x00u8

import u8 ps2_read();
import u8 ps2_reset();
import u8 ps2_set_led_mask(u8 mask);
import u8 ps2_set_rate(u8 mask);
