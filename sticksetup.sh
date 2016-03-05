#!/bin/sh

set -e

[ $PWD -eq $MOUNTPART] && echo "$PWD is not chroot, exiting" && exit

grub-install $TARGET_DEVICE && update-grub

FSTAB_STRING="$(blkid $TARGET_PART) / ext4 defaults,errors=remount-ro 0 1"

echo $FSTAB_STRING >> /etc/fstab

echo "lilbooty" > /etc/hostname

dpkg-reconfigure locales

passwd

adduser user

apt-get clean

update-initramfs -u -k all

exit
