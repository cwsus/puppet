#!/bin/bash

[ -c /sys/bus/usb/devices/usb1/authorized -o -c /sys/bus/usb/devices/usb1/authorized_default ] && exit
echo 0 > /sys/bus/usb/devices/usb1/authorized
echo 0 > /sys/bus/usb/devices/usb1/authorized_default

