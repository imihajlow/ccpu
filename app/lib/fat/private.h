#pragma once
#include "types.h"
#define FAT_MIN_LAST_CLUSTER 0xFFF8u16
#define MAX_FILE_DESC 4u8

struct Partition {
    u8 boot; // 0x00
    u8 start_h; // 0x01
    u8 start_s; // 0x08
    u8 start_c; // 0x00
    u8 sys_id; // 0x06
    u8 end_h;  // 0x07
    u8 end_s; // 0x60
    u8 end_c; // 0xe4
    u32 rel_sector; // 0x00000027
    u32 n_sectors; // 0x0001e4d9
};

struct BPB {
        u8 jump[3];
        u8 oem_id[8];
        u16 bytes_per_sector; // 0x0200
    u8 sectors_per_cluster; // 0x04
    u16 n_reserved_sectors; // 0x0001
    u8 n_fats; // 0x02
    u16 n_dir_entries; // 0x0200
    u16 total_sectors; // 0x0000
        u8 media_descriptor_type; // 0xf8
    u16 sectors_per_fat; // 0x0079
        u16 sectors_per_track; // 0x0020
        u16 n_heads; // 0x0010
    u32 n_hidden_sectors; // 0x00000027
    u32 large_sectors; // 0x0001e4d9
};

struct FatInfo {
    u32 fat0_offset;
    u32 fat1_offset;
    u16 sectors_per_fat;
    u32 root_dir_block;
    u8 log_sectors_per_cluster;
    u8 sectors_per_cluster;
    u16 n_dir_entries;
    u32 data_offset;
    u16 n_clusters;
};

struct FileDescriptor {
    u8 is_free;
    u8 is_stale; // an old open file descriptor becomes stale when the card is mounted
    u16 last_cluster_len; // number of bytes in the last cluster in the chain
    u32 block_addr; // current block
    u8 block_in_cluster; // block index in current cluster
    u16 index_in_block; // read/write pointer in current block
    u16 next_cluster; // value from the FAT
    u16 cur_cluster; // index in the FAT
    struct FatDirEntry dir_entry;
    u32 dir_entry_block_addr; // block index on disc
    u16 dir_entry_index_in_block; // offset inside the block
    u8 is_root; // for directory descriptors: if this is a root directory (a special case)
    u8 dir_entry_modified; // need to write out the dir entry on file close
    u32 abs_offset; // absolute read/write pointer
    u8 filler[5];
};

import struct FileDescriptor fat_private_file_desc[MAX_FILE_DESC];


// Find file in dir by name and fill out dir_entry-related fields in file descriptor
// returns bool
import u8 fat_private_find_file(struct FatDirEntry *dir, u8 *name, struct FileDescriptor *pfd, u8 mode);

// Finds a free slot, clears free flag
// returns fd or FAT_BAD_DESC on error
import u8 fat_private_get_free_fd(struct FileDescriptor **ppfd);

// returns bool
import u8 fat_private_init_fd(struct FileDescriptor *pfd);

// returns nothing
import u8 fat_private_init_root_dir(struct FileDescriptor *pfd);

