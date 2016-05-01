#!/bin/bash

echo export ROS_HOSTNAME=localhost >> /etc/profile
echo export ROS_MASTER_URI=http://localhost:11311 >> /etc/profile
echo export ROS_ROOT=/opt/ros/indigo >> /etc/profile
echo export ROS_DISTRO=indigo >> /etc/profile
echo export ROS_PACKAGE_PATH=/opt/ros/indigo/share >> /etc/profile
echo export PATH=$PATH:/opt/ros/indigo/bin:/usr/lib/bluez5/bluetooth/ >> /etc/profile
echo export LD_LIBRARY_PATH=/opt/ros/indigo/lib >> /etc/profile
echo export PYTHONPATH=/opt/ros/indigo/lib/python2.7/site-packages >> /etc/profile
echo export CMAKE_PREFIX_PATH=/opt/ros/indigo >> /etc/profile

touch /opt/ros/indigo/.catkin

cp plenblenode.patch /opt/ros/indigo/lib/plen/plenblenode.patch
cd /opt/ros/indigo/lib/plen/
patch -u bleNode.py < plenblenode.patch

cd /home/root/setup_plen/
cp plen-dev.sh /home/root/plen-dev.sh
chmod 755 /home/root/plen-dev.sh
cp plen-dev.service /etc/systemd/system/plen-dev.service
chmod 755 /etc/systemd/system/plen-dev.service

cd /etc/systemd/system/
systemctl enable plen-dev
systemctl start plen-dev

systemctl disable wpa_supplicant
systemctl enable hostapd
systemctl start hostapd

echo Finish PLEN2dev Install
