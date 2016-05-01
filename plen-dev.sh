#!/bin/bash

rfkill unblock bluetooth
source /etc/profile
roslaunch plen plen.launch

while true
do
done
