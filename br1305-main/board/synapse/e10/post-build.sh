#!/bin/bash

TARGETDIR=$1
SOUCREDIR=board/synapse/e10/root-additions

#echo `/bin/date` $1 $2 >> ~/jtmp
rm $TARGETDIR/var/log
mkdir $TARGETDIR/var/log
rm $TARGETDIR/var/spool
mkdir -p $TARGETDIR/var/spool/cron/crontabs
cp -av $SOUCREDIR/* $TARGETDIR >> debug.log
date -u +%Y%m%d%H%M%S > $TARGETDIR/etc/jc-version
chmod 755 $TARGETDIR/etc/init.d/*
echo UTC > $TARGETDIR/etc/TZ
echo "/dev/mtdblock4  /var/log        jffs2   rw,relatime       0 0" >> $TARGETDIR/etc/fstab
#echo `/bin/date` $1 $2 >> ~/jtmp
