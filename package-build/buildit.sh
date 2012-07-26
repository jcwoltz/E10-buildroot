#!/bin/bash

#tld="/usr/local/src/git/E10-buildroot"
tld="$( cd "$( dirname "$0" )"/.. && pwd )"
ukernel="$tld/br1202-main/output/images/uImage"
urootfs="$tld/br1202-main/output/images/rootfs.jffs2"
nkernel="$tld/br-e10-next/output/images/uImage"
nrootfs="$tld/br-e10-next/output/images/rootfs.jffs2"
uboot="$tld/br1202-main/output/images/u-boot.bin"
uinitk="$tld/br-e10-recv/output/images/uImage"

uscript="$tld/br-e10-recv/board/synapse/e10/root-additions/root/upgrade.sh"

ufilesd="$tld/package-build/files"
uarchived="$tld/package-build/archive"


mkdir -p $ufilesd
mkdir -p $uarchived

echo "Cleaning old files..."
rm $ufilesd/*

echo "Copying files..."
cp $uinitk $ufilesd/uImage-e10i
cp $ukernel $ufilesd/
cp $urootfs $ufilesd/
cp $uscript $ufilesd/
cp $uboot $ufilesd/

echo "Compiling u-boot environment script"
mkimage -T script -C none -n 'E10 environment update' -A arm -d set-uboot-env $ufilesd/setenv.img
echo

DT=`date -u +%Y%m%d%H%M%S`
FILENAMES=e10-1202-$DT
FILENAMEN=e10-next-$DT
echo "Creating $FILENAMES.zip ..."
cd $ufilesd
zip -rD $uarchived/$FILENAMES ./*

echo "======================================================================"
echo "======================================================================"
echo
echo "Copying E10-Next files..."
cp $nkernel $ufilesd/
cp $nrootfs $ufilesd/
echo "Creating $FILENAMEN.zip ..."
zip -rD $uarchived/$FILENAMEN ./*
echo "======================================================================"
echo "======================================================================"

#HOSTNAME=`cat /etc/hostname`
if [ "wocs-m" == "$HOSTNAME" ]
then
	echo sending $FILENAMEN to hosting provider
	scp $uarchived/$FILENAMEN.zip $uarchived/$FILENAMES.zip iworryfo@jcwoltz.com:public_html/e10/
#	scp $uarchived/$FILENAMES.zip iworryfo@jcwoltz.com:public_html/e10/
	echo "Done!"
#	echo sending $FILENAMES to hosting provider
#	scp $uarchived/$FILENAMES.zip iworryfo@jcwoltz.com:public_html/e10/
#	echo "Done!"
fi
