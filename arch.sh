#!/data/data/com.termux/files/usr/bin/sh

mnt="/data/local/tmp/chrootarch"

# Make sure required mount points exist
mkdir -p "$mnt"/dev/pts
mkdir -p "$mnt"/dev/shm
mkdir -p "$mnt"/proc
mkdir -p "$mnt"/sys
mkdir -p "$mnt"/media/sdcard

# Clean up mounts from a previous failed start
umount "$mnt/dev/shm" 2>/dev/null
umount "$mnt/dev/pts" 2>/dev/null
umount "$mnt/proc" 2>/dev/null
umount "$mnt/sys" 2>/dev/null
umount "$mnt/dev" 2>/dev/null
umount "$mnt/media/sdcard" 2>/dev/null

# Mount required filesystems
busybox mount -o bind /dev "$mnt/dev"
busybox mount -t proc proc "$mnt/proc"
busybox mount -t sysfs sysfs "$mnt/sys"
busybox mount -t devpts devpts "$mnt/dev/pts"

# Shared storage
busybox mount -o bind /sdcard "$mnt/media/sdcard"

# /dev/shm
busybox mount -t tmpfs -o size=256M tmpfs "$mnt/dev/shm"

# DNS
cp /etc/resolv.conf "$mnt/etc/resolv.conf" 2>/dev/null

# Enter Arch
#busybox chroot "$mnt" /bin/su - root
busybox chroot $mnt /bin/su - owo -c "export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4713 && dbus-launch --exit-with-session startxfce4"
