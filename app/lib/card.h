#pragma once

#define CARD_SUCCESS 0u8
#define CARD_ERROR_TIMEOUT 1u8
#define CARD_ERROR_RESET_FAILED 2u8
#define CARD_ERROR_ACMD_FAILED 3u8
#define CARD_ERROR_ACMD41_FAILED 4u8
#define CARD_ERROR_BAD_DATA_RESPONSE 5u8
#define CARD_ERROR_WRITE_ERROR 6u8
#define CARD_ERROR_CRC_ERROR 7u8
#define CARD_ERROR_BLOCK_CMD_FAILED 0xffu8

#define CARD_BLOCK_SIZE 512u16

import u8 card_init();
import u8 card_power_off();
import u8 card_read_block(u32 block_index, u8 *dst);
import u8 card_write_block(u32 block_index, u8 *src);

