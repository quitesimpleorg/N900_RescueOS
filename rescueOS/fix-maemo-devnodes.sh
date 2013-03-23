#!/bin/sh
#might fix some devices nodes if they have been messed up.
#atm we don't care whether they exist already or not...
#mknod parts by Pali

sh /rescueOS/mount-maemo-root.sh
if [ ! -e /run/maemo-root-mounted ] ; then
echo "mount of maemo root failed, giving up."
exit
fi 


mknod /mnt/maemo/dev/console c 5 1
mknod /mnt/maemo/dev/fb0 c 29 0
mknod /mnt/maemo/dev/fb1 c 29 1
mknod /mnt/maemo/dev/fb2 c 29 2
mknod /mnt/maemo/dev/full c 1 7
mknod /mnt/maemo/dev/kmem c 1 2
mknod /mnt/maemo/dev/mem c 1 1
mknod /mnt/maemo/dev/mtd0 c 90 0
mknod /mnt/maemo/dev/mtd0ro c 90 1
mknod /mnt/maemo/dev/mtd1 c 90 2
mknod /mnt/maemo/dev/mtd1ro c 90 3
mknod /mnt/maemo/dev/mtd2 c 90 4
mknod /mnt/maemo/dev/mtd2ro c 90 5
mknod /mnt/maemo/dev/mtd3 c 90 6
mknod /mnt/maemo/dev/mtd3ro c 90 7
mknod /mnt/maemo/dev/mtd4 c 90 8
mknod /mnt/maemo/dev/mtd4ro c 90 9
mknod /mnt/maemo/dev/mtd5 c 90 10
mknod /mnt/maemo/dev/mtd5ro c 90 11
mknod /mnt/maemo/dev/null c 1 3
mknod /mnt/maemo/dev/port c 1 4
mknod /mnt/maemo/dev/random c 1 8
mknod /mnt/maemo/dev/tty c 5 0
mknod /mnt/maemo/dev/ttyS0 c 4 64
mknod /mnt/maemo/dev/ttyS1 c 4 65
mknod /mnt/maemo/dev/ttyS2 c 4 66
mknod /mnt/maemo/dev/tty0 c 4 0
mknod /mnt/maemo/dev/urandom c 1 9
mknod /mnt/maemo/dev/zero c 1 5

mknod /mnt/maemo/dev/loop0 b 7 0
mknod /mnt/maemo/dev/loop1 b 7 1
mknod /mnt/maemo/dev/loop2 b 7 2
mknod /mnt/maemo/dev/loop3 b 7 3
mknod /mnt/maemo/dev/loop4 b 7 4
mknod /mnt/maemo/dev/loop5 b 7 5
mknod /mnt/maemo/dev/loop6 b 7 6
mknod /mnt/maemo/dev/loop7 b 7 7
mknod /mnt/maemo/dev/ram0 b 1 0
mknod /mnt/maemo/dev/ram1 b 1 1
mknod /mnt/maemo/dev/ram10 b 1 10
mknod /mnt/maemo/dev/ram11 b 1 11
mknod /mnt/maemo/dev/ram12 b 1 12
mknod /mnt/maemo/dev/ram13 b 1 13
mknod /mnt/maemo/dev/ram14 b 1 14
mknod /mnt/maemo/dev/ram15 b 1 15
mknod /mnt/maemo/dev/ram16 b 1 16
mknod /mnt/maemo/dev/ram2 b 1 2
mknod /mnt/maemo/dev/ram3 b 1 3
mknod /mnt/maemo/dev/ram4 b 1 4
mknod /mnt/maemo/dev/ram5 b 1 5
mknod /mnt/maemo/dev/ram6 b 1 6
mknod /mnt/maemo/dev/ram7 b 1 7
mknod /mnt/maemo/dev/ram8 b 1 8
mknod /mnt/maemo/dev/ram9 b 1 9

ln -s /proc/kcore /mnt/maemo/dev/core
ln -s ram1 /mnt/maemo/dev/ram

mkdir /mnt/maemo/dev/pts
chmod 755 /mnt/maemo/dev/pts

chmod 600 /mnt/maemo/dev/console
chmod 660 /mnt/maemo/dev/fb0
chmod 660 /mnt/maemo/dev/fb1
chmod 660 /mnt/maemo/dev/fb2
chmod 666 /mnt/maemo/dev/full
chmod 640 /mnt/maemo/dev/kmem
chmod 660 /mnt/maemo/dev/loop0
chmod 660 /mnt/maemo/dev/loop1
chmod 660 /mnt/maemo/dev/loop2
chmod 660 /mnt/maemo/dev/loop3
chmod 660 /mnt/maemo/dev/loop4
chmod 660 /mnt/maemo/dev/loop5
chmod 660 /mnt/maemo/dev/loop6
chmod 660 /mnt/maemo/dev/loop7
chmod 640 /mnt/maemo/dev/mem
chmod 600 /mnt/maemo/dev/mtd0
chmod 600 /mnt/maemo/dev/mtd0ro
chmod 600 /mnt/maemo/dev/mtd1
chmod 600 /mnt/maemo/dev/mtd1ro
chmod 600 /mnt/maemo/dev/mtd2
chmod 600 /mnt/maemo/dev/mtd2ro
chmod 600 /mnt/maemo/dev/mtd3
chmod 600 /mnt/maemo/dev/mtd3ro
chmod 600 /mnt/maemo/dev/mtd4
chmod 600 /mnt/maemo/dev/mtd4ro
chmod 600 /mnt/maemo/dev/mtd5
chmod 600 /mnt/maemo/dev/mtd5ro
chmod 666 /mnt/maemo/dev/null
chmod 640 /mnt/maemo/dev/port
chmod 660 /mnt/maemo/dev/ram0
chmod 660 /mnt/maemo/dev/ram1
chmod 660 /mnt/maemo/dev/ram10
chmod 660 /mnt/maemo/dev/ram11
chmod 660 /mnt/maemo/dev/ram12
chmod 660 /mnt/maemo/dev/ram13
chmod 660 /mnt/maemo/dev/ram14
chmod 660 /mnt/maemo/dev/ram15
chmod 660 /mnt/maemo/dev/ram16
chmod 660 /mnt/maemo/dev/ram2
chmod 660 /mnt/maemo/dev/ram3
chmod 660 /mnt/maemo/dev/ram4
chmod 660 /mnt/maemo/dev/ram5
chmod 660 /mnt/maemo/dev/ram6
chmod 660 /mnt/maemo/dev/ram7
chmod 660 /mnt/maemo/dev/ram8
chmod 660 /mnt/maemo/dev/ram9
chmod 666 /mnt/maemo/dev/random
chmod 666 /mnt/maemo/dev/tty
chmod 660 /mnt/maemo/dev/ttyS0
chmod 660 /mnt/maemo/dev/ttyS1
chmod 660 /mnt/maemo/dev/ttyS2
chmod 600 /mnt/maemo/dev/tty0
chmod 444 /mnt/maemo/dev/urandom
chmod 666 /mnt/maemo/dev/zero

chown root:tty /mnt/maemo/dev/console
chown root:video /mnt/maemo/dev/fb0
chown root:video /mnt/maemo/dev/fb1
chown root:video /mnt/maemo/dev/fb2
chown root:root /mnt/maemo/dev/full
chown root:kmem /mnt/maemo/dev/kmem
chown root:disk /mnt/maemo/dev/loop0
chown root:disk /mnt/maemo/dev/loop1
chown root:disk /mnt/maemo/dev/loop2
chown root:disk /mnt/maemo/dev/loop3
chown root:disk /mnt/maemo/dev/loop4
chown root:disk /mnt/maemo/dev/loop5
chown root:disk /mnt/maemo/dev/loop6
chown root:disk /mnt/maemo/dev/loop7
chown root:kmem /mnt/maemo/dev/mem
chown root:root /mnt/maemo/dev/mtd0
chown root:root /mnt/maemo/dev/mtd0ro
chown root:root /mnt/maemo/dev/mtd1
chown root:root /mnt/maemo/dev/mtd1ro
chown root:root /mnt/maemo/dev/mtd2
chown root:root /mnt/maemo/dev/mtd2ro
chown root:root /mnt/maemo/dev/mtd3
chown root:root /mnt/maemo/dev/mtd3ro
chown root:root /mnt/maemo/dev/mtd4
chown root:root /mnt/maemo/dev/mtd4ro
chown root:root /mnt/maemo/dev/mtd5
chown root:root /mnt/maemo/dev/mtd5ro
chown root:root /mnt/maemo/dev/null
chown root:kmem /mnt/maemo/dev/port
chown root:disk /mnt/maemo/dev/ram0
chown root:disk /mnt/maemo/dev/ram1
chown root:disk /mnt/maemo/dev/ram10
chown root:disk /mnt/maemo/dev/ram11
chown root:disk /mnt/maemo/dev/ram12
chown root:disk /mnt/maemo/dev/ram13
chown root:disk /mnt/maemo/dev/ram14
chown root:disk /mnt/maemo/dev/ram15
chown root:disk /mnt/maemo/dev/ram16
chown root:disk /mnt/maemo/dev/ram2
chown root:disk /mnt/maemo/dev/ram3
chown root:disk /mnt/maemo/dev/ram4
chown root:disk /mnt/maemo/dev/ram5
chown root:disk /mnt/maemo/dev/ram6
chown root:disk /mnt/maemo/dev/ram7
chown root:disk /mnt/maemo/dev/ram8
chown root:disk /mnt/maemo/dev/ram9
chown root:root /mnt/maemo/dev/random
chown root:tty /mnt/maemo/dev/tty
chown root:dialout /mnt/maemo/dev/ttyS0
chown root:dialout /mnt/maemo/dev/ttyS1
chown root:dialout /mnt/maemo/dev/ttyS2
chown root:tty /mnt/maemo/dev/tty0
chown root:root /mnt/maemo/dev/urandom
chown root:root /mnt/maemo/dev/zero