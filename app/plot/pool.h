#pragma once

#define POOL_CHUNK_SIZE 32u16
#define POOL_CAPACITY 16u16

import u8 pool_init();
import u8 *pool_alloc();
import u8 pool_free(u8* chunk);
