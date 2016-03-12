#!/bin/sh

oneArg () {
    [ $# -ne 1 ] && return 1
    return 0
    }

devicePresent () {
    [ -e $1 ] || { echo "No such device node as $TARGET_DEVICE" ; return 1 ; }
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
    [ $BOOT_TYPE -eq "pxe" ] || KERNEL_VERSION="linux-image-$ARCH"
    local PACKAGELIST="grub-pc,locales,$KERNEL_VERSION"
    # If you add packages to $PACKAGELIST, add them at the beginning
    # This is fragile because of those stupid commas
    sudo debootstrap --include $PACKAGELIST --arch $ARCH stable $MOUNTPOINT http://ftp.us.debian.org/debian 
    return 0
    }
    

