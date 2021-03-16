#pragma once

#include "error.h"

/**
 * @param  path file/dir path
 * @param  de   result
 * @return bool, sets fat_last_error
 */
export u8 fat_find_path(u8 *path, struct FatDirEntry *de);
