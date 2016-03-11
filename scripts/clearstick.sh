#!/bin/sh

#Usage: `./clearstick [DEVICE] purge`
#DEVICE => /dev/sd[a-z]
#Zaps the partition table of DEVICE and optionally wipe the device.

TARGET_DEVICE="/dev/disk/by-uuid/$1"



[ $2 = 'purge' ] && dd if=/dev/zero of=$TARGET_DEVICE

