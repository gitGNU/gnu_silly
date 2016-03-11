# Debian-stick install scripts

## What is this stuff?

The scripts in this directory will install Debian to a device (intended use is USB sticks) using debootstrap.
This is NOT a live image. Debian will be installed to the disk as with a normal hard disk.

Before beginning you will need to get the UUID of the stick. You can use the `blkid` command to accomplish this.
Each of the scripts takes the UUID as argument in order to avoid writing to the wrong device by accident.

The scripts are not meant to be called independently, but instead called from install-debian.sh

## Why is this stuff?

The idea is to make it easy for anyone to generate a tool for flashing Libreboot to Thinkpads (or other hardware supported by Libreboot to the same extent.)
The scripts make a real filesystem on the stick so that the user can keep track of the devices being flashed.
The onstick/ subdirectory contains more scripts that will be written to the stick during installation; these will download or update Libreboot, introspect the local hardware, and do other tasks to support the methods outlined in ../README.md
