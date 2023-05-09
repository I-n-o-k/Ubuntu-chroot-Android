#! /bin/sh

# first you need install busybox magisk module for runing ubuntu on android

# Create a directory for chroot envrionment
mkdir /data/local/ubuntu
cd /data/local/ubuntu

# Download rootfs 
wget https://github.com/I-n-o-k/Ubuntu-20.04-chroot-Android/raw/master/ubuntu-focal-arm64-rootfs.tar.gz

# Extract rootfs
tar xpvf ubuntu-focal-arm64-rootfs.tar.gz

# Create a directory for Mountpoint internal storage
mkdir sdcard

# Download startup script 
wget https://raw.githubusercontent.com/I-n-o-k/Ubuntu-20.04-chroot-Android/master/start-ubuntu.sh
chmod +x start-ubuntu.sh

# Now you just execute the script and connect with ssh
# Use localhost as ip
# example ssh root@localhost
# default password root is inok
# you can aslo change that password , by use command passwd root
