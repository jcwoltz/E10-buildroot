#!/usr/bin/python

import sys
import os
import os.path
import shutil
import traceback

SILENT = ' 2> /dev/null'
PREFIX = 'RunUsb: '

cmds = [ 'mount /dev/sda1 /mnt',
         'mount -t vfat /dev/sda1 /mnt',
         'mount /dev/sda2 /mnt',
         'mount -t vfat /dev/sda2 /mnt',
         'mount /dev/sda /mnt' ]

def mountUsb():
    os.system('mdev -s') # scan for missing devs
    for cmd in cmds:
        rv = os.system(cmd + SILENT)
        if rv == 0:
            print PREFIX + cmd
            return True
        else:
            pass
    return False


def umountUsb():
    rv = os.system('umount /mnt' + SILENT)
    if rv == 0:
        return True
    return False


def runScript(filepath):
    if os.path.exists(filepath) and os.path.isfile(filepath):
        print PREFIX + 'Running Script'
        prevDir = os.getcwd()
        os.chdir('/mnt')
        try:
            rv = execfile(filepath, globals())
            if rv:
                print 'errno = ', rv
        except:
            traceback.print_exc()
        os.chdir(prevDir)
        print PREFIX + 'End of script'
    else:
        pass

def setRedLed(value):
    os.system("echo "+str(value)+" >> /sys/class/leds/redled/brightness")

def runUsb():
    print 'RunUsb...'
    setRedLed(1)
    if mountUsb():
        try:
            #shutil.copy('RunMe.py', '/mnt')
            runScript('/mnt/RunMe.py')
        except:
            traceback.print_exc()
    umountUsb()
    print PREFIX + 'done'
    setRedLed(0)

if __name__ == '__main__':
    runUsb()
