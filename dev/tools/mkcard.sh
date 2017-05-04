#! /bin/sh
# mkcard.sh v0.6
# (c) Copyright 2009 Graeme Gregory <dp@xora.org.uk>
# (c) Copyright 2013 Koen Kooi <koen@dominion.thruhere.net>
# (c) Copyright 2017 AbdAllah MEZITI <abdallah.meziti.pro@gmail.com>
# Licensed under terms of GPLv2
#
# Parts of the procudure base on the work of Denys Dmytriyenko
# http://wiki.omap.com/index.php/MMC_Boot_Format

export LC_ALL=C

if [ $# -ne 1 ]; then
	echo "Usage: $0 <drive>"
	exit 1;
fi

DRIVE=$1

dd if=/dev/zero of=$DRIVE bs=1M count=1

SIZE=`fdisk -l $DRIVE | grep Disk | grep bytes | awk '{print $5}'`

echo DISK SIZE - $SIZE bytes

CYLINDERS=`echo $SIZE/255/63/512 | bc`

echo CYLINDERS - $CYLINDERS

echo ===========
echo PARTIONNING
echo ===========
# sfdisk reads lines of the form : <start> <size> <id> <bootable>

{
echo ,63MiB,0x0C,*
echo ,,,-
} | sfdisk $DRIVE

# or

# sudo sfdisk $DRIVE << EOF
# ,63MiB,0x0C,*
# ,,,-
# EOF

# sudo sfdisk $DRIVE << EOF
# 8192,63MiB,0x0C,*
# 137216,4GiB,,-
# EOF


sleep 1


#if [ -x /sbin/kpartx ]; then
#	kpartx -a -v ${DRIVE}
#fi

# handle various device names.
# note something like fdisk -l /dev/loop0 | egrep -E '^/dev' | cut -d' ' -f1 
# won't work due to https://bugzilla.redhat.com/show_bug.cgi?id=649572

PARTITION1=${DRIVE}1
if [ ! -b ${PARTITION1} ]; then
	PARTITION1=${DRIVE}p1
fi

DRIVE_NAME=`basename $DRIVE`
DEV_DIR=`dirname $DRIVE`

if [ ! -b ${PARTITION1} ]; then
	PARTITION1=$DEV_DIR/mapper/${DRIVE_NAME}p1
fi

PARTITION2=${DRIVE}2
if [ ! -b ${PARTITION2} ]; then
	PARTITION2=${DRIVE}p2
fi
if [ ! -b ${PARTITION2} ]; then
	PARTITION2=$DEV_DIR/mapper/${DRIVE_NAME}p2
fi

echo ==========
echo FORMATTING
echo ==========
# now make partitions.
if [ -b ${PARTITION1} ]; then
	umount ${PARTITION1}
	mkfs.vfat -F32 -n "BOOT" ${PARTITION1}
else
	echo "Cant find boot partition in /dev"
fi

if [ -b ${PARITION2} ]; then
	umount ${PARTITION2}
	mkfs.ext4  -L "RootFs" ${PARTITION2} 
else
	echo "Cant find rootfs partition in /dev"
fi

if [ -x /sbin/kpartx ]; then
	kpartx -d -v ${DRIVE}
fi
