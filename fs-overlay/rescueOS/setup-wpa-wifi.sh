#!/bin/sh
ermsg()
{
echo $1
exit
}
[ -e /run/wlan.conf ] ||  ermsg "Yeah, please run wpa_passphrase [essid] [password ] > /run/wlan.conf first."
modprobe wl1251_spi
#Works for my router, probably for yours too, if not, then not :-)

sleep 1;
wpa_supplicant -Dwext -iwlan0 -c/run/wlan.conf &

