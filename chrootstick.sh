#!/bin/bash

#Usage: `chrootstick [DEVICE]`
# chroot into prepared stick and set up installed system to be bootable

sudo chroot $MOUNTPOINT 

# This should fail if strapstick.sh did not succeed
[ -e /strap-status ]


