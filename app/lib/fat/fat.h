#pragma once

#include "error.h"
#include "name.h"
#include "types.h"

import u8 fat_last_error;

/**
 Returns bool, sets fat_last_error on failure.
 */
import u8 fat_init();

/**
 Open a directory
 @param dir - dir entry or 0 for root dir.
 Returns dir descriptor or FAT_BAD_DESC on error, sets fat_last_error on failure.
 */
import u8 fat_open_dir(struct FatDirEntry *dir);

/**
 Returns 1 on success, 0 on fail (or when no entries are left), sets fat_last_error on failure.
 */
import u8 fat_get_next_dir_entry(u8 dir_desc, struct FatDirEntry *dst, u8 attr_skip_mask);


/**
 Returns file descriptor or FAT_BAD_DESC on error, sets fat_last_error on failure.
 */
import u8 fat_open_file(struct FatDirEntry *dir, u8 *name);

/**
 Returns number of bytes actually read, sets fat_last_error on failure.
*/
import u16 fat_read(u8 fd, u8 *dst, u16 len);

/**
 Returns number of bytes actually written, sets fat_last_error on failure.
*/
import u16 fat_write(u8 fd, u8 *src, u16 len);

/**
 Set file size to the current read/write pointer.
 Returns bool, sets fat_last_error on failure.
 */
import u8 fat_truncate(u8 fd);

/**
 Set file size to the current read/write pointer.
 Returns bool, sets fat_last_error on failure.
 */
import u8 fat_seek_end(u8 fd);

import u8 fat_close(u8 fd);

/**
 Returns 0xffffffff and sets fat_last_error on error.
 */
import u32 fat_get_size(u8 fd);

/**
 * Look into directory entry for name inside parent and fill dst if it's a dir.
 * @return        1 on success, 0 on fail, sets fat_last_error on failure.
 */
import u8 fat_change_dir(struct FatDirEntry *parent, u8 *name, struct FatDirEntry *dst);
