#!/bin/sh


set -x

. ~/Projects/SILLY/scripts/functions.sh

oneArg narf derp
echo "oneArg returns $?" 

devicePresent /dev/sdd

strapIt sparc /dev/null phy
echo "strapIt returns $?"
