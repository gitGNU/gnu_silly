#!/bin/sh

set -e
set -x
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
# Usage: setup.sh [uuid|pxe] ARCH PATH
# Where uuid is $(lsblk --output UUID) that matches the uuid of 
# the target device, and pxe means to install to a local 
# directory /srv/ARCH or PATH instead of a device.

. ./functions.sh

[ -z $(sudo fdisk -l | grep sdc[[::digit:]]) ] || clearStick

makePart

sudo mke2fs $TARGET_DEVICE

strapIt
