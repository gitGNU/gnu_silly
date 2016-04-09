#!/bin/sh
set -e
set -x
# Usage: `sh strapstick.sh /dev/somedevice`
# Mounts the specified somedevice and debootstraps it


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

# Copyright © 2016 Andrew Kane <akane@freegeekseattle.org> 

. ./functions.sh

TARGET_DEVICE="/dev/disk/by-uuid/$1"

devicePresent $TARGET_DEVICE

[ debootstrap --help ]

# Hardcoded for now, later we'll extract the relevant data from `lsblk` and construct this $TARGET_PART dynamically
# Or perhaps not, since prepstick.sh will only make one partition

TARGET_PART=$TARGET_DEVICE1

echo $TARGET_PART || (echo "no TARGET_PART" && false)

MOUNTPOINT="./temp-mount-stick" && echo "targeting $TARGET_PART at $MOUNTPOINT"
# [ $(grep $TARGET_PART /etc/mtab) ] 
[ -e $MOUNTPOINT ] || (echo "mountpoint not found, creating it..." && mkdir $MOUNTPOINT && echo "Mountpoint created at $MOUNTPOINT")
[ -d $MOUNTPOINT ] || (echo "mountpoint is not a directory, aborting" && return "ENODIR")
sudo mount $TARGET_PART ./temp-mount-stick || (echo "could not mount $TARGET_PART at $MOUNTPOINT" && return "ENOHORSE")

# Thanks to https://www.linuxquestions.org/questions/debian-26/how-to-install-debian-using-debootstrap-4175465295/
strapping amd64 $MOUNTPOINT




