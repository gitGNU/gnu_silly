#   Seattle Iteration : Libre Laptops for Youth
  
## What we are doing

  We are starting with a pile of Lenovo laptops with the factory BIOS. Our remit: Liberate these laptops.
  We mean to make these as RyF as possible per https://www.fsf.org/resources/hw/endorsement/respects-your-freedom

## How we are doing it

 
  
  First we examine the machines. Boot into a Debian Live image and run:
  
  dmidecode
  lspci
  lsusb
  hwinfo if avail
  other?
  
  Next we find a UUID for the machine. The UUID can be that of the motherboard as reported by dmidecode or can be a serial number, etc.
  MAC address will also work (even though not guaranteed universally unique, should be unique among vendor models).
  Bind UUID to a human-usable memorable name for convenience, and record it in this directory in file ./silly-hosts.txt
  
  Shred and remove hard disk drives if any. Test RAM and fill up slots as availability permits.
  When the hardware is ready, test it. SMART and Memtest86, what else?
  
  When hardware is profiled and ready, it's time to re-flash.
  
  First, backup the existing BIOS image.
	
  https://www.coreboot.org/Board:lenovo/x60/Installation#Back_up_the_original_proprietary_firmware
  
  BIOS images are specific to the unit. When the backup is made, name it after the UUID *and name* of the machine from whence it came.
  
  When the BIOS backup is done, you are almost ready to flash. 
  
  https://libreboot.org/docs/install/index.html#flashrom_lenovobios
  
  Follow the directions, read the scripts, remember that there are two steps (i945lenovo_firstflash and i945lenovo_secondflash).
  This process may not be rendered non-interactive because of the two steps requiring a reboot between them.
  
  When the flash is complete it's time to install the OS. iirc Libreboot uses GRUB2 as payload, so installing may require some GRUB hacking in order to coax the machines to use the install media.
  Debian or Trisquel? IMO Debian main is 'free enough', but ymmv.
  
  ## What's included in this project
  
  * scripts for producing USB-HDD filesystem for working on laptops (using debootstrap and friends)
  * PXE images for use with [PXE Install Server](https://github.com/freegeek-seattle/install_pxeserver)
  * automation around building Libreboot images
  
  
  
