#!/bin/sh

mnt="/data/local/tmp/chrootarch"
busybox mount -o remount,dev,suid /data

mount -o bind /dev $mnt/dev/
busybox mount -t proc proc $mnt/proc/
busybox mount -t sysfs sysfs $mnt/sys/
busybox mount -t devpts devpts $mnt/dev/pts/
busybox mount -o bind /sdcard $mnt/media/sdcard
busybox mount -t tmpfs /cache $mnt/var/cache

# /dev/shm for Electron apps
busybox mount -t tmpfs -o size=256M tmpfs $mnt/dev/shm

# chroot into Arch
busybox chroot $mnt /bin/su - root
