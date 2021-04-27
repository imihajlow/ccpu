#pragma once

#include "error.h"
#include "types.h"

/**
 * Allocates a file descriptor. Walks the path. Populates file descriptor with the information about the file/dir.
 *
 * @param  path file/dir path
 * @param  mode open mode
 * @return file descriptor
 */
import u8 fat_find_path(u8 *path, u8 mode);

import u8 fat_open_path(u8 *path, u8 mode);
