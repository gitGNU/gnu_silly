#!/bin/sh

#Usage: `./clearstick [DEVICE] purge`
#DEVICE => /dev/sd[a-z]
#Zaps the partition table of DEVICE and optionally wipe the device.

TARGET_DEVICE="/dev/disk/by-uuid/$1"



[ $2 = 'purge' ] && dd if=/dev/zero of=$TARGET_DEVICE

for PARTITION_NUM in $(sudo parted -s $TARGET_DEVICE print |grep ^[[:space]][[:digit:]] | cut -c 1-5 ) ; do
    sudo fdisk $TARGET_DEVICE rm $PARTITION_NUM ;
    done
    
