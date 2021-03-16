#pragma once

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
