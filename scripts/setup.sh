#!/bin/sh

set -e
set -x

# Usage: setup.sh [uuid|pxe] ARCH PATH
# Where uuid is $(lsblk --output UUID) that matches the uuid of 
# the target device, and pxe means to install to a local 
# directory /srv/ARCH or PATH instead of a device.

. ./functions.sh

[ -z $(sudo fdisk -l | grep sdc[[::digit:]]) ] || clearStick

makePart

sudo mke2fs $TARGET_DEVICE

strapIt
