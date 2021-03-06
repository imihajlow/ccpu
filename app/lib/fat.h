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
/*
 Returns dir descriptor or FAT_BAD_DESC on error.
 */
import u8 fat_open_dir();

/*
 Returns 1 on success, 0 on fail (or when no entries are left)
 */
import u8 fat_get_next_dir_entry(u8 dir_desc, struct FatDirEntry *dst);

import u8 fat_close_dir(u8 dir_desc);

import u8 fat_open_file(struct FatDirEntry *dsc);

import u16 fat_read(u8 fd, u8 *dst, u16 len);

import u8 fat_close_file(u8 fd);
