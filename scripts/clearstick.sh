#!/bin/sh

# Usage: `./clearstick [DEVICE] purge`
# DEVICE => /dev/sd[a-z]
# Zap the partition table of DEVICE and optionally wipe the device.

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


TARGET_DEVICE="/dev/disk/by-uuid/$1"



[ $2 = 'purge' ] && dd if=/dev/zero of=$TARGET_DEVICE

for PARTITION_NUM in $(sudo parted -s $TARGET_DEVICE print |grep ^[[:space]][[:digit:]] | cut -c 1-5 ) ; do
    sudo fdisk $TARGET_DEVICE rm $PARTITION_NUM ;
    done
    
