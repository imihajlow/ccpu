#pragma once

#define FAT_OK 0u8
#define FAT_ERROR_CARD 1u8
#define FAT_ERROR_UNSUPPORTED_TYPE 2u8
#define FAT_ERROR_UNSUPPORTED_SECTOR_SIZE 3u8
#define FAT_ERROR_TOO_MANY_FATS 4u8


#define FAT_FILE_ATTR_READ_ONLY 1u8
#define FAT_FILE_ATTR_HIDDEN 2u8
#define FAT_FILE_ATTR_SYSTEM 4u8
#define FAT_FILE_ATTR_VOLUME_ID 8u8
#define FAT_FILE_ATTR_DIRECTORY 16u8
#define FAT_FILE_ATTR_ARCHIVE 32u8
#define FAT_FILE_ATTR_LONG_FILENAME 0x0Fu8
struct FatDirEntry {
    u8 filename[11];
    u8 attrs;
    u8 _reserved;
    u8 create_dsec;
    u16 create_time;
    u16 create_date;
    u16 access_date;
    u16 cluster_hi; // 0x0000
    u16 modify_time;
    u16 modify_date;
    u16 cluster_lo; // 0x0004
    u32 size;
};

import u8 fat_init();

#define FAT_BAD_DESC 0xFFu8

/**
 Open a directory
 @param dir - dir entry or 0 for root dir.
 Returns dir descriptor or FAT_BAD_DESC on error.
 */
import u8 fat_open_dir(struct FatDirEntry *dir);

/**
 Returns 1 on success, 0 on fail (or when no entries are left)
 */
import u8 fat_get_next_dir_entry(u8 dir_desc, struct FatDirEntry *dst, u8 attr_skip_mask);


import u8 fat_open_file(struct FatDirEntry *dir, u8 *name);

import u16 fat_read(u8 fd, u8 *dst, u16 len);

import u16 fat_write(u8 fd, u8 *src, u16 len);

/**
 Set file size to the current read/write pointer.
 */
import u8 fat_truncate(u8 fd);

import u8 fat_seek_end(u8 fd);

import u8 fat_close(u8 fd);

import u8 to_fat_name(u8 *dst, u8 *src);

import u8 from_fat_name(u8 *dst, u8 *src);

/**
 * Look into directory entry for name inside parent and fill dst if it's a dir.
 * @return        1 on success, 0 on fail.
 */
import u8 fat_change_dir(struct FatDirEntry *parent, u8 *name, struct FatDirEntry *dst);
