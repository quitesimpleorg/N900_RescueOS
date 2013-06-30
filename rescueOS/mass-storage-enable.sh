#!/bin/bash
rmmod g_nokia 
nodenr=$(cat /run/internal_nodenr)
modprobe g_file_storage file=/dev/mmcblk"$nodenr"p2,/dev/mmcblk"$nodenr"p1 stall=0 removable=1



