# script.reboot2oos-le
LibreELEC port of script.reboot2oos-oe by teeedubb 

**Original author [teeedubb](https://github.com/teeedubb/teeedubb-xbmc-repo)**

**Original forum [[RELEASE] Reboot2oOS - Reboot once to another OS.](https://forum.kodi.tv/showthread.php?tid=172715)**
 
### Readme
This addon will reboot your machine once into another OS of your choice then boot back into your default OS. 
It uses GRUB so a working multi-boot setup with GRUB is required. This addon has been tested with GRUB 2.04. 
Updates to GRUB can break this addon.
Manual editing files contained within the zip is required to get this addon working (preferably before installation).


#### Install: On the GRUB holding OS
get a list of OS's recognised by GRUB with the following command:

```
sed -n '/menuentry/s/.*\(["'\''].*["'\'']\).*/\1/p' /boot/grub/grub.cfg
```

Edit the file /etc/default/grub and change the line

* /etc/default/grub
```
GRUB_DEFAULT=
to
GRUB_DEFAULT=saved
```

Now update GRUB and make the script executable:
```
update-grub
```

#### Install: Inside the package

Edit the name= tag to your liking. I currently have it named WIN10.
* script.reboot2oos\addon.xml
```
name=
```

This is the message that is contained in the Yes/No dialog
* script.reboot2oos\default.py
```
dialog1 = "Reboot to WIN10..."
dialog2 = "KODI needs to reboot for WIN10"
```

The entries correspond to your GRUB menu entries - REBOOT_TO= is the OS you want to reboot once to, DEFAULT_OS= is your default OS. 
Use the output from the list of OS's.

* script.reboot2oos\bin\reboot2oos.sh
```
GRUB_BOOT_DIR="" #Point to the partition holding grub
ADDON_LOCATION="/storage/.kodi/addons/script.reboot2oos-le" #Point to the location of the addon in LibreELEC
REBOOT_TO=
DEFAULT_OS=
```

The addon icon can be changed based on your needs. 
* script.reboot2oos\icon.png

Install the addon, you are good to go.


Optional: The lib folder should be added automaticaly but if not add this to
* ~/.config/autostart.sh
```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/storage/.kodi/addons/script.reboot2oos-oe/bin/lib
```

Now select 'WIN10' under Programs to use the addon and reboot once to the OS of your choice.

### Compiling GRUB 2.04 for LE
If you need to recompile do the following

```
apt-get build-dep grub2
wget ftp://ftp.gnu.org/gnu/grub/grub-2.04.tar.gz
tar -xvf grub-2.04.tar.gz
cd grub-2.04/
./configure -prefix=/storage/.kodi/addons/script.reboot2oos-oe --sbindir=/storage/.kodi/addons/script.reboot2oos-oe/bin --disable-grub-mkfont
make -j4
```
We need the following files:
* grub-editenv
* grub-probe
* grub-reboot
* grub-set-default
* grub-mkconfig_lib

Additionally you need following shared libs:
* libdevmapper-event.so.1.02.1
* libdevmapper.so.1.02.1
* libpcre.so.3
* libselinux.so.1