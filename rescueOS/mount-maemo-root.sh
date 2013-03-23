#!/bin/sh
[ -d /mnt/maemo ] || mkdir /mnt/maemo/
if [ -e /run/maemo-root-mounted ] ; then
echo "A system script already mounted the rootfs of maemo to /mnt/maemo" ;
exit ; 
fi 
ubiattach /dev/ubi_ctrl -m 5
mount -t ubifs -o rw,bulk_read,no_chk_data_crc ubi0:rootfs /mnt/maemo && touch /run/maemo-root-mounted
