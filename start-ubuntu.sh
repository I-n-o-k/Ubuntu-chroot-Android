#!/bin/sh

# The path of Ubuntu rootfs
UBUNTUPATH="/data/local/ubuntu"

# Fix setuid issue
busybox mount -o remount,dev,suid /data

busybox mount --bind /dev $UBUNTUPATH/dev
busybox mount --bind /sys $UBUNTUPATH/sys
busybox mount --bind /proc $UBUNTUPATH/proc
busybox mount -t devpts devpts $UBUNTUPATH/dev/pts

# Mount sdcard
busybox mount --bind /sdcard $UBUNTUPATH/sdcard

# chroot into Ubuntu (connect with ssh)# chroot into Ubuntu (connect with ssh)
busybox chroot $UBUNTUPATH /bin/su - root -c "apt update && apt install -y openssh-client openssh-server"
busybox chroot $UBUNTUPATH /bin/su - root /etc/init.d/ssh stop
busybox chroot $UBUNTUPATH /bin/su - root /etc/init.d/ssh start

