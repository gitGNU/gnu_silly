#!/bin/sh

oneArg () {
    [ $# -ne 1 ] && return 1
    return 0
    }

devicePresent () {
    local TARGET_DEVICE=$1
    [ -z $TARGET_DEVICE ] && { echo "TARGET_DEVICE unbound" ; return 1 ; }
    [ -b $1 ] || { echo "No such device node as $TARGET_DEVICE" ; return 1 ; }
    return 0
    }

    
strapIt () {
    # Usage: `strapping [pxe|phy] $ARCH MOUNTPOINT`
    # where $ARCH is a port listed at https://www.debian.org/ports/
    # all of which should be listed in ./arches.txt;
    # $MOUNTPOINT is the path where system will be installed;
    # and 'pxe' or 'phy' selects PXE or physical-device booting
    # with 'phy' as default.
    # Example `strapping amd64 /mnt/debian-mountpoint/`
    local ARCH=$1
    grep $ARCH ../scripts/arches.txt || return 1
    local MOUNTPOINT=$2
    $3{=:"phy"}
    local BOOT_TYPE=$3
    [ $BOOT_TYPE = "pxe" ] || KERNEL_VERSION=", linux-image-$ARCH"
    local PACKAGELIST="grub-pc,locales$KERNEL_VERSION"
    # This is ugly and dumb, but if $3 != 'phy' then KERNEL_VERSION will be unbound, 
    # This is because PXE needs the kernel separate so don't install it in rootfs
    # If you add packages to $PACKAGELIST, add them at the beginning
    # This is fragile because of those stupid commas; comma at the end will make it break it
    sudo debootstrap --include $PACKAGELIST --arch $ARCH stable $MOUNTPOINT http://ftp.us.debian.org/debian 
    return 0
    }
    
makePart () {
    PARTEND=$(($(sudo sfdisk -s $TARGET_DEVICE)/1000))
    sudo parted -sma optimal /dev/sdc mkpart primary ext2 0 $PARTEND
    sudo partprobe $TARGET_DEVICE
    }

clearStick () {
    #Usage: `./clearstick [DEVICE] purge`
    #DEVICE => /dev/sd[a-z]
    #Zaps the partition table of DEVICE and optionally wipe the device.

    local TARGET_DEVICE="/dev/disk/by-uuid/$1"
    [ $2 = 'purge' ] && dd if=/dev/zero of=$TARGET_DEVICE

    for PARTITION_NUM in $(sudo parted -s $TARGET_DEVICE print |grep ^[[:space]][[:digit:]] | cut -c 1-5 ) ; do
    sudo fdisk $TARGET_DEVICE rm $PARTITION_NUM ;
    done
    
    }

get_UUID () {
    # Usage: First run the script, then insert the stick when prompted.
    DEVICES=$(grep UUID /etc/fstab)
    }
