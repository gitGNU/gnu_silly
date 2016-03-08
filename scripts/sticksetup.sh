#!/bin/sh

set -e
#set -x

# Usage: `./sticksetup.sh [DEVICE]`
#  DEVICE => /dev/sd[a-z]
# Erases DEVICE partition table, makes a single Linux FS partition, and writes FS to partition
# DO NOT USE on a stick that containsvalued data!

TARGET_DEVICE="/dev/disk/by-uuid/$1"

echo "WARNING! This will destroy ALL DATA on the device $TARGET_DEVICE!"



[ -z $(sudo fdisk -l | grep sdc\n) ] || (echo "Existing partitions on $TARGET_DEVICE, aborting. Maybe run clearstick.sh first?" && return 1)


# non-interactively format 
## Potential problem: in Debian you have fdisk and partx available by default afaict. fdisk is 'for humans, not scripts' and partx 'is not an fdisk program – adding and removing partitions does not  change  the  disk'
# 'Note  that  partx(8)  provides  a  rich interface for
# scripts  to  print  disk  layouts,  fdisk  is  mostly
# designed  for  humans.' oic

# found this janky workaround: https://superuser.com/questions/332252/creating-and-formating-a-partition-using-a-bash-script
# better yet just use sfdisk :^)

#sudo sfdisk -- force /dev/sdc << EOF
#1,,83,*
#EOF

# Might be better to use parted though
PARTEND=$(($(sudo sfdisk -s $TARGET_DEVICE)/1000))
sudo parted -sma optimal /dev/sdc mkpart primary ext2 0 $PARTEND
sudo partprobe $TARGET_DEVICE


# write filesystem

sudo mke2fs $TARGET_DEVICE

return 0
