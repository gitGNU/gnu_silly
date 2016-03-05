#!/bin/sh
set -e


TARGET_DEVICE=$1
MOUNTPOINT="./temp-mount-stick" && echo "targeting $1 at $MOUNTPOINT"

[-e $MOUNTPOINT] || echo "mountpoint not found, creating it..." && mkdir $MOUNTPOINT
[-d $MOUNTPOINT] || echo "mountpoint is not a directory, aborting"
su -c "mount $TARGET_DEVICE ./temp-mountpoint" || echo "could not mount $TARGET_DEVICE at $MOUNTPOINT" && false

# Thanks to https://www.linuxquestions.org/questions/debian-26/how-to-install-debian-using-debootstrap-4175465295/
[-e $MOUNTPOINT/strap-status] || debootstrap --include linux-image-amd64,grub-pc,locales --arch amd64 unstable /mnt/deboot http://ftp.us.debian.org/debian && mkdir $MOUNTPOINT/strap-status

chroot $MOUNTPOINT 'sh sticksetup.sh'


