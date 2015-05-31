#!/bin/bash

set -e

target="$1"

delfiles="
  $target/etc/init.d/rcK
  $target/etc/init.d/S20urandom
  $target/etc/init.d/S40network
  $target/etc/securetty"

for file in $delfiles ; do 
  [ ! -e "$file" ] || rm "$file"
done

[ ! -e "$target/usr/share/getopt" ] || rm -r "$target/usr/share/getopt"

ln -sf "/rescueOS/usbnetworking-enable.sh" "$target/sbin/usbne"
ln -sf "/rescueOS/usbnetworking-disable.sh" "$target/sbin/usbnd"
ln -sf "/rescueOS/charge21.bash" "$target/sbin/chargebat"
ln -sf "/rescueOS/mount-maemo-root.sh" "$target/sbin/mmr"
ln -sf "/rescueOS/umount-maemo-root.sh" "$target/sbin/ummr"
ln -sf "/rescueOS/mass-storage-enable.sh" "$target/sbin/mse"
ln -sf "/rescueOS/mass-storage-disable.sh" "$target/sbin/msd"
ln -sf "/rescueOS/enableftp.sh" "$target/sbin/enftp"


