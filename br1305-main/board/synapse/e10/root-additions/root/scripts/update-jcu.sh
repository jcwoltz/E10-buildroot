#!/bin/sh

scp -P 22174 stfu@jcu.homelinux.org:UserMain.py /root/UserMain.py
chown root:root /root/UserMain.py
chmod 755 /root/UserMain.py
wget http://www.jcwoltz.com/e10/createSNAPSQLlite.txt
/usr/bin/sqlite3 dc.sqlite < createSNAPSQLlite.txt
#mkdir sc
/bin/sync
echo "Reboot to make sure all works. Don't dorget to install Snap Connect first"
