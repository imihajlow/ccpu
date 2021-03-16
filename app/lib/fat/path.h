#pragma once

#include "error.h"
#include "types.h"

/**
 * Allocates a file descriptor. Walks the path. Populates file descriptor with the information about the file/dir.
 *
 *
 * @param  path file/dir path
 * @return file descriptor
 */
import u8 fat_find_path(u8 *path);

import u8 fat_open_path(u8 *path);

import u8 fat_open_dir_path(u8 *path);
