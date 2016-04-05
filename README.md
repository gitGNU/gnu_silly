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
  Debian or Trisquel? IMO Debian main is 'free enough', but ymmv.
  
## What's included in this project
  
  * scripts for producing USB-HDD filesystem for working on laptops (using debootstrap and friends)
  * PXE images for use with [PXE Install Server](https://github.com/freegeek-seattle/install_pxeserver)
  * automation around building Libreboot images
  
## Caveats
  
  * as of 20160306 the scripts don't work. 
    They are dangerous in the wrong hands, so don't run them if you don't know what you are doing.
    Don't run them even if you *do* know what you are doing, but do use them as a guide for entering commands into the shell if that helps.
    
  * Intel chipset T60 and X60 Tablet have 32-bit memory controller. These machines can't use the full 4GB RAM if you put 2x2GB sticks in them. 
  ** As of 20160405 it appears that the machines run OK with 2x2GB or 1x2GB + 1x1GB but further testing is needed.
  
  
## TODO
  
  *  First version of scripts will only support MBR and not add swap; in future GPT and UEFI support is desirable.
  * Add some customization: 
  ** libreboot_grub.cfg
  ** thinkfan configs + script to go full-speed on AC
  
  
  
  
