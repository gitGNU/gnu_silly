#!/bin/sh

set -e
#set -x

# Usage: `./sticksetup.sh [DEVICE]`
#  DEVICE => /dev/sd[a-z]
# Erases DEVICE partition table, makes a single Linux FS partition, and writes FS to partition
# DO NOT USE on a stick that contains valued data!
# This file is part of SILLY

# SILLY is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# SILLY is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with SILLY.  If not, see <http://www.gnu.org/licenses/>.
TARGET_DEVICE="/dev/disk/by-uuid/$1"

echo "WARNING! This will destroy ALL DATA on the device $TARGET_DEVICE!"



[ -z $(sudo fdisk -l | grep sdc[[::digit:]]) ] || (echo "Existing partitions on $TARGET_DEVICE, aborting. Maybe run clearstick.sh first?" && return 1)


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
