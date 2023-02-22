#!/bin/bash
#Edit the lines between the #####'s
#Use the following command to list GRUB boot entries (you need to update it with the correct path to 'grub.cfg'):
#sed -n '/menuentry/s/.*\(["'\''].*["'\'']\).*/\1/p' /path/to/grub.cfg
set -e

#####
GRUB_BOOT_DIR="/var/media/armbi_root/boot/" #Point to the partition holding grub
ADDON_LOCATION="/storage/.kodi/addons/script.reboot2oos-le" #Point to the location of the addon in LibreELEC if different
REBOOT_TO="Armbian GNU/Linux" #other os
DEFAULT_OS="LibreELEC" #libreelec
#####

GRUB_CONFIG_FILE=$GRUB_BOOT_DIR"grub/grub.cfg"
GRUB_DEFAULT=$(sed -n '/menuentry/s/.*\(["'\''].*["'\'']\).*/\1/p' $GRUB_CONFIG_FILE |grep -F "$DEFAULT_OS" | tail -n1 | sed 's/^.\(.*\).$/\1/')
MENU_ENTRY=$(sed -n '/menuentry/s/.*\(["'\''].*["'\'']\).*/\1/p' $GRUB_CONFIG_FILE |grep -F "$REBOOT_TO" | tail -n1 | sed 's/^.\(.*\).$/\1/')
echo "GRUB default boot OS: $GRUB_DEFAULT"
echo "Reboot once to: $MENU_ENTRY"
echo "Addon directory location: $ADDON_LOCATION"
echo "GRUB boot directory location: $GRUB_BOOT_DIR"
echo "GRUB config file: $GRUB_CONFIG_FILE"
echo "grub-set-default command: grub-set-default --boot-directory=$GRUB_BOOT_DIR $GRUB_DEFAULT"
echo "grub-reboot command: grub-reboot --boot-directory=$GRUB_BOOT_DIR $MENU_ENTRY"
#$ADDON_LOCATION/bin/grub-set-default --boot-directory=$GRUB_BOOT_DIR $GRUB_DEFAULT
$ADDON_LOCATION/bin/grub-reboot --boot-directory=$GRUB_BOOT_DIR $MENU_ENTRY
reboot
