#!/bin/sh
sh /rescueOS/mass-storage-disable.sh 
modprobe g_nokia
ifconfig usb0 down
ifconfig usb0 192.168.2.15 up
ifconfig usb0 netmask 255.255.255.0
#route add default gw 192.168.178.14  
route add 192.168.2.14 usb0
