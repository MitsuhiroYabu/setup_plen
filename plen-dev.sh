#!/bin/bash

tmp=$(systemctl status hostapd | grep Active | tr -d " ")

if [ $tmp = "Active:inactive(dead)" ]
then
	echo hostapd is not running
	systemctl stop wpa_supplicant
	systemctl disable wpa_supplicant
	systemctl enable hostapd
	systemctl start hostapd
else
	echo hostapd is running
fi

rfkill unblock bluetooth
source /etc/profile
roslaunch plen plen.launch

