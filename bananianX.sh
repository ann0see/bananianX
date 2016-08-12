#!/bin/bash
#Install bananianX
echo "Welcome. It might take some time... If your internet connection is too slow it will take more time. Your Pi will reboot if this script is finished. You can abort it with the command which is shown then."
sleep 5
echo "Updating..."
apt-get update
echo "Installing lightdm..."
apt-get -qq install lightdm
apt-get -qq install lightdm-gtk-greeter
echo "Installing LXDE Core..."
apt-get -qq install lxde-core
echo "OK, install xinit..."
echo "Xinit let's you start the X-Server with startx..."
apt-get -qq install xinit
echo "Installing openbox Window Manager..."
apt-get -qq install openbox
echo "Installing sudo, if you want to add an other user with root posibility..."
apt-get -qq install sudo
echo "Setting up X..."
echo "Setting up X, so that a normal user can shutdown..."
apt-get -qq install systemd-shim
echo "session required pam_systemd.so" >> /etc/pam.d/lxdm
clear
echo "Will restart in 10 Minutes!"
shutdown -t 10 -r
