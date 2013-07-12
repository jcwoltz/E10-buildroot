#!/bin/sh
#
# Check wlan0 and fix
# J.C. Woltz <jwoltz@gmail.com>
# 201111061658 initial version
#

/root/scripts/check-net.sh
netStat=$?
/sbin/ifconfig wlan0 > /dev/null
wnetStat=$?
if [ $wnetStat -eq 0 ]
then
	if [ $netStat -eq 0 ]
	then
		echo "Wireless and internet connection good"
		exit 0
	fi
	if [ $netStat -eq 3 ]
	then
		echo "Gateway up, check provider or remote ip"
		exit 3
	else
		ifdown wlan0 && ifup wlan0
		echo "returned: $?"
	fi
else
	echo "wlan0 not found. Is it plugged in?"
	exit 10
fi

