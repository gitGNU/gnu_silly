#!/bin/sh

set -e

# Usage: `./sticksetup.sh [DEVICE]`
#  DEVICE => /dev/sd[a-z]
# Erases DEVICE, makes a single Linux FS partition, and writes FS to partition


TARGET_DEVICE = $1

# non-interactively format 

# write filesystem

mke2fs $TARGET_DEVICE

return 0
