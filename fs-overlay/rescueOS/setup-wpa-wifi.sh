#!/bin/sh
ermsg()
{
echo $1
exit
}
ls /lib/firmware/ | grep wl1251 > /dev/null || ermsg "Firmware not found. Copy  wl1251-fw.bin, wl1251-nvs.bin from maemo.".
[ -e /run/wlan.conf ] ||  ermsg "Yeah, please run wpa_passphrase [essid] [password ] > /run/wlan.conf first."
modprobe wl1251_spi
#Works for my router, probably for yours too, if not, then not :-)

sleep 1;
wpa_supplicant -Dwext -iwlan0 -c/run/wlan.conf &

