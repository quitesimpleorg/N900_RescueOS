#!/bin/sh
[ -e /lib/firmware/$FIRMWARE ] || echo -1 > /sys/$DEVPATH/loading
/sbin/mdev
