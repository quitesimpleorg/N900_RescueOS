#!/bin/sh
ermsg()
{
echo "Couldn't unmount. Most likely your fault. Are you in /mnt/maemo?";
exit;
}

sync
umount /mnt/maemo || ermsg 
ubidetach -m 5
rm /run/maemo-root-mounted
