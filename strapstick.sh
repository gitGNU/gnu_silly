#!/bin/sh
set -e

# Usage: `sh strapstick.sh /dev/somedevice`
# Mounts the specified somedevice and debootstraps it


TARGET_DEVICE=$1
echo "$TARGET_DEVICE set to $1"

# Hardcoded for now, later we'll extract the relevant data from `lsblk` and construct this $TARGET_PART dynamically
# Or perhaps not, since prepstick.sh will only make one partition

TARGET_PART=/dev/sdc1

echo $TARGET_PART || (echo "no TARGET_PART" && false)

MOUNTPOINT="./temp-mount-stick" && echo "targeting $TARGET_PART at $MOUNTPOINT"
# [ $(grep $TARGET_PART /etc/mtab) ] 
[ -e $MOUNTPOINT ] || (echo "mountpoint not found, creating it..." && mkdir $MOUNTPOINT && echo "Mountpoint created at $MOUNTPOINT")
[ -d $MOUNTPOINT ] || (echo "mountpoint is not a directory, aborting" && return "ENODIR")
sudo mount $TARGET_PART ./temp-mount-stick || (echo "could not mount $TARGET_PART at $MOUNTPOINT" && return "ENOHORSE")

# Thanks to https://www.linuxquestions.org/questions/debian-26/how-to-install-debian-using-debootstrap-4175465295/
[ -e $MOUNTPOINT/strap-status ] || (sudo debootstrap --include linux-image-amd64,grub-pc,locales --arch amd64 stable $MOUNTPOINT http://ftp.us.debian.org/debian  && touch $MOUNTPOINT/strap-status)




