#!/bin/sh

# The path of Ubuntu rootfs
UBUNTUPATH="/data/local/ubuntu"

# Fix setuid issue
busybox mount -o remount,dev,suid /data

mkdir $UBUNTUPATH/dev
mkdir $UBUNTUPATH/dev/pts
mkdir $UBUNTUPATH/sys
mkdir $UBUNTUPATH/proc

busybox mount --bind /dev $UBUNTUPATH/dev
busybox mount --bind /sys $UBUNTUPATH/sys
busybox mount --bind /proc $UBUNTUPATH/proc
busybox mount -t devpts devpts $UBUNTUPATH/dev/pts

# config ssh
sed -i -E 's/#?PasswordAuthentication .*/PasswordAuthentication yes/g' "$UBUNTUPATH/etc/ssh/sshd_config"
sed -i -E 's/#?PermitRootLogin .*/PermitRootLogin yes/g' "$UBUNTUPATH/etc/ssh/sshd_config"
sed -i -E 's/#?AcceptEnv .*/AcceptEnv LANG/g' "$UBUNTUPATH/etc/ssh/sshd_config"

# Mount sdcard
busybox mount --bind /sdcard $UBUNTUPATH/sdcard

# Create normal user 
user="user"
passwd="user"
busybox chroot $UBUNTUPATH /bin/su - root -c "adduser --disabled-password --gecos GECOS ${user}"
busybox chroot $UBUNTUPATH /bin/su - root -c "${user:}${user} /home/${user}"

# set password for user
busybox chroot $UBUNTUPATH /bin/su - root -c "echo ${user}:${passwd} | chpasswd"

# set password for root (default password for root is root)
busybox chroot $UBUNTUPATH /bin/su - root -c "echo root:root | chpasswd"

# add normal user to sudo group
busybox chroot $UBUNTUPATH /bin/su - root -c "apt update && apt install -y sudo && adduser $user sudo"

# chroot into Ubuntu (connect with ssh)# chroot into Ubuntu (connect with ssh)
busybox chroot $UBUNTUPATH /bin/su - root -c "apt update && apt install -y openssh-client openssh-server"
busybox chroot $UBUNTUPATH /bin/su - root /etc/init.d/ssh stop
busybox chroot $UBUNTUPATH /bin/su - root /etc/init.d/ssh start

