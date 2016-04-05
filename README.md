#   Seattle Iteration : Libre Laptops for Youth
  
## What we are doing

  We are starting with a pile of Lenovo laptops with the factory BIOS. Our remit: Liberate these laptops.
  We mean to make these as RyF as possible per https://www.fsf.org/resources/hw/endorsement/respects-your-freedom

## How we are doing it

### First off:

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

 
  
### First we examine the machines. 

Boot into a Debian Live image and run...
  
  * dmidecode
  * lspci
  * lsusb
  * hwinfo
  * lshw
  * other?
  
  ... and save the result in a file.
  
  Next we find a UUID for the machine. The UUID can be that of the motherboard as reported by dmidecode or can be a serial number, etc.
  MAC address will also work (even though not guaranteed universally unique, should be unique among vendor models).
  Bind UUID to a human-usable memorable name for convenience, and record it in this directory in file ./silly-hosts.txt
  
  Shred and remove hard disk drives if any. Test RAM and fill up slots as availability permits.
  When the hardware is ready, test it. SMART and Memtest86, what else?
  
### When hardware is profiled and ready, it's time to re-flash.
  
1. First, backup the existing BIOS image.
	
  https://www.coreboot.org/Board:lenovo/x60/Installation#Back_up_the_original_proprietary_firmware
  
  BIOS images are specific to the unit. When the backup is made, name it after the UUID *and name* of the machine from whence it came.
  
2. When the BIOS backup is done, you are almost ready to flash. 
  
  https://libreboot.org/docs/install/index.html#flashrom_lenovobios
  
  Follow the directions, read the scripts, remember that there are two steps (i945lenovo_firstflash and i945lenovo_secondflash).
  This process may not be rendered non-interactive because of the two steps requiring a reboot between them.
  
3. When the flash is complete it's time to install the OS. iirc Libreboot uses GRUB2 as payload, so installing may require some GRUB hacking in order to coax the machines to use the install media.
   Here's how to get GRUB to boot your install media:
   1. Enter GRUB command line by pressing `c' at the menu.
   2. type `ls` to get a list of available devices.
   3. type `set root=(DEVICE,PARTITION)` where DEVICE is something like `usb0` and PARTITION looks like `msdos1`. You can tab-complete these. When $root is set it enables you to enter paths with the selected device / partition as the root, i.e. /live/boot/vmlinuz instead of (hd0, msdos1)/live/boot/vmlinuz
   4. use `ls` to inspect the filesystem and find the files vmlinuz and initrd.gz. On a Debian-like install dingus this will be under /live or under /install. Since you are installing, use /install.
   5. type `[command] [path-to-vmlinuz]` where [command] is each of `linux` and `initrd`, e.g. `linux /live/boot/vmlinuz`
   6. type `boot`  and GRUB should boot into the installer. If it fails, file an issue here please.
   
## What's included in this project
  
  * scripts for producing USB-HDD filesystem for working on laptops (using debootstrap and friends)
  * PXE images for use with [PXE Install Server](https://github.com/freegeek-seattle/install_pxeserver)
  * automation around building Libreboot images
  * configuration to make the Libreboot experience nicer and/or more secure
    1. add libreboot_grub.cfg
    2. thinkfan config and possibly automation to customize same
    3. bootloader only in cbfs for really-full-disk encryption: https://libreboot.org/docs/gnulinux/encrypted_trisquel.html

  
  
  
  
