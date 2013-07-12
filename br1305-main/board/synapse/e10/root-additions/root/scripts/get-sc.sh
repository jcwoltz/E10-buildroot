#!/bin/sh

cd /root
wget http://www.jcwoltz.com/e10/install-sc.sh
chmod 755 install-sc.sh
./install-sc.sh
rm ./install-sc.sh
