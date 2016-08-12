#!/bin/bash
#Install bananianX
echo "Welcome. It might take some time..."
echo "Updating..."
apt-get update
echo "Installing lightdm..."
apt-get -qq install lightdm
apt-get -qq install lightdm-gtk-greeter
echo "installing LXDE Core"
apt-get -qq install lxde-core
echo "OK, install xinit"
apt-get -qq install xinit
echo "Installing openbox Window Manager"
apt-get -qq install openbox
echo "Installing sudo, if you want to add an other user, not root"
apt-get -qq install sudo
echo "Setting up X"
apt-get -qq install systemd-shim
echo "session required pam_systemd.so" >> /etc/pam.d/lxdm
clear
echo "Will restart!"
shutdown -t 10 -r
