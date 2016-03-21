#!/bin/bash
set -e
set -x
#Usage: `chrootstick [DEVICE]`
# chroot into prepared stick and set up installed system to be bootable
MOUNTPOINT="./temp-mount-stick"
TARGET_DEVICE="/dev/disk/by-uuid/$1"

sudo chroot $MOUNTPOINT 

# Some tests to save us from insanity: 

## strapstick.sh writes strap-status file
[ -e /strap-status ]
# Don't overwrite these if they exist
[ -e /etc/hosts ] || ${cat ./hosts.txt > /etc/hosts; echo 'creating hostfile'>&2 }
[ -e /etc/network/interfaces ] || cat ./interfaces > /etc/network/interfaces

## Are we in chroot?
[ $PWD -eq $MOUNTPART ] && (echo "$PWD is not chroot, exiting" && return 1)
# Use hostname check instead
# Actually let's use fstab:

# if uuid mounted at / -ne TARGET_DEVICE, then we're not in chroot!

# Bootloader
grub-install $TARGET_DEVICE && update-grub

# Device Nodes

# apt-get install makedev
# mount none /proc -t proc
# cd /dev
# MAKEDEV generic

# Mounts
FSTAB_STRING="$(blkid $TARGET_PART) / ext4 defaults,errors=remount-ro 0 1"
[ -e $MOUNTPOINT/etc/fstab ] || cat ./fstab > /etc/fstab ]
echo $FSTAB_STRING >> /etc/fstab

mount -a



# Configuration

echo "lilbooty" > /etc/hostname

dpkg-reconfigure locales tzdata




passwd

adduser user

apt-get clean

update-initramfs -u -k all

return 0

# From https://www.debian.org/releases/stable/i386/apds03.html.en





