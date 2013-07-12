#!/bin/sh
#
# Check connection to internet
# J.C. Woltz <jwoltz@gmail.com>
# 201110091254 initial version
#

TESTIP=8.8.8.8

/sbin/route -n | /bin/grep UG | /usr/bin/cut -d ' ' -f 1 > /dev/null
if [ $? -eq 0 ]
then
	GW=`/sbin/route -n | /bin/grep UG | /usr/bin/cut -d " " -f 10`
	/bin/ping -c 1 $GW > /dev/null
	if [ $? -eq 0 ]
	then
		/bin/ping -c 2 $TESTIP > /dev/null
		if [ $? -eq 0 ]
		then
			exit 0
		else
			echo "Gateway up, $TESTIP unreachable"
			exit 3
		fi
	else
		echo "Unable to ping gateway"
		exit 2
	fi
else
	echo "Could not find default gateway"
	exit 1
fi

