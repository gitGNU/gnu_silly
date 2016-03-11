#!/bin/sh

handleArgs () {
    [ $# -ne 1 ] || return 1
    }

devicePresent () {
    [ -e $TARGET_DEVICE ] || echo "No such device node as $TARGET_DEVICE" && return "ENODEV" 
    }
