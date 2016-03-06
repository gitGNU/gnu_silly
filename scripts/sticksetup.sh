#!/bin/sh

set -e

# Usage: `./sticksetup.sh [DEVICE]`
#  DEVICE => /dev/sd[a-z]
# Erases DEVICE, makes a single Linux FS partition, and writes FS to partition


TARGET_DEVICE = $1

# non-interactively format 
## Potential problem: in Debian you have fdisk and partx available by default afaict. fdisk is 'for humans, not scripts' and partx 'is not an fdisk program – adding and removing partitions does not  change  the  disk'
# 'Note  that  partx(8)  provides  a  rich interface for
       scripts  to  print  disk  layouts,  fdisk  is  mostly
       designed  for  humans.' oic
# found this janky workaround: https://superuser.com/questions/332252/creating-and-formating-a-partition-using-a-bash-script
# better yet just use sfdisk :^)

# sfdisk $TARGET_DEVICE <<EOF
# 0,+
,83
;
;
EOF
# write filesystem

mke2fs $TARGET_DEVICE

return 0
