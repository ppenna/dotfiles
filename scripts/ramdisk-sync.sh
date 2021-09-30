#! /bin/sh 

TARGET=$2

BACKUP='rsync -avz --recursive --delete --force --exclude="*.o" --exclude="*.a" --exclude="*.swp"'

case "$1" in
	start)
		echo "Copying Files to RAM Disk"
		mount -t tmpfs -o size=8G tmpfs /mnt/ && \
		$BACKUP $TARGET/ /mnt/ && \
		mount -t tmpfs -o size=8G tmpfs $TARGET && \
		$BACKUP /mnt/ $TARGET/
	;;
	sync)
		echo "Syncing Files from RAM Disk to Hard Disk"
		$BACKUP $TARGET/ /mnt/
	;;
	discard)
		echo "Discarding Files in RAM Disk"
		umount $TARGET/ && \
		umount /mnt
	;;
	stop)
		echo "Syncing Files from RAM Disk to Hard Disk"
		umount $TARGET/ && \
		$BACKUP /mnt/ $TARGET/ && \
		umount /mnt
	;;
		*)
		echo "Usage: ramdisk-sync {start|stop}"
		exit 1
	;;
esac
