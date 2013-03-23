#!/bin/bash
rmmod g_nokia 
#stuff changes when sd card is inserted
if [ -e /sys/block/mmcblk0 ] && [ -e /sys/block/mmcblk1 ] ; then 
	modprobe g_file_storage file=/dev/mmcblk1p2,/dev/mmcblk1p1 stall=0 removable=1
else
	modprobe g_file_storage file=/dev/mmcblk0p2,/dev/mmcblk0p1 stall=0 removable=1
fi


