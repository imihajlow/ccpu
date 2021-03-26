#!/bin/bash

IMAGE=image.img
NBLOCKS=$((65536 * 2))

dd if=/dev/zero of=${IMAGE} bs=512 count=${NBLOCKS}
DEV=`hdiutil attach -nomount ${IMAGE} | xargs`
fdisk -f /dev/zero -b 512 -S ${NBLOCKS} -yr ${DEV} << EOM
1,$((NBLOCKS - 1)),0x0b,*,0,0,0,0,0,0
0,0,0x00,-,0,0,0,0,0,0
0,0,0x00,-,0,0,0,0,0,0
0,0,0x00,-,0,0,0,0,0,0
EOM

mkdir -p mnt
newfs_msdos -F 16 -S 512 -c 4 ${DEV}s1
mount -t msdos ${DEV}s1 mnt
cp "$@" mnt
umount mnt
hdiutil detach ${DEV}
