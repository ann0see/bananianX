#!/bin/bash
#BananianX installer default (English)
###################BETA###################

echo "Hi. This script will install a GUI on your Banana Pi. Please wait and don't go away. You will be able to choose how many packets you want to install. Preparing..."
echo
echo "Please Wait... Installing dialog..."
apt-get install -y dialog   #install dialog #needed??
clear
echo "Dialog installed..."
echo
sleep 5
echo "Let's go!"
sleep 1

#Dialog choose BananianX FULL /LIGHT
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="BananianX installer"
TITLE="Install BananianX"
MENU="Choose one of the following options:"

OPTIONS=(1 "Option 1: BananianX LIGHT (only packets you really need-> less features, takes not as long as Option 2 to install, uses less disk space)"
         2 "Option 2: BananianX FULL (everything-> more features, but takes longer to install, uses more disk space) (recommended)"
         3 "Option 3: Exit (don't install anything)")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
echo "You chose Option 1. Will install BananianX LIGHT."
echo

#Install bananianX light

echo "It might take some time... Your Pi will reboot if this script is finished. You can abort the reboot."

sleep 5

echo "Updating..."

apt-get update

echo "Installing lightdm..."

apt-get install -y lightdm

apt-get install -y lightdm-gtk-greeter

echo "Installing LXDE Core..."

apt-get install -y lxde-core

echo "OK, install xinit..."

echo "Xinit lets you start the X-Server with startx..."

apt-get install -y xinit

echo "Installing openbox Window Manager..."

apt-get install -y openbox

echo "Installing sudo, if you want to add an other user with root posibility..."

apt-get install -y sudo

echo "Setting up X..."

echo "Setting up X, so that a normal user can shutdown..."

apt-get install -y systemd-shim

echo "session required pam_systemd.so" >> /etc/pam.d/lxdm

clear

echo "Finished! Will reboot in 10 Minutes!"
shutdown -t 10 -r


            ;;
        2)
echo "You chose Option 2: BananianX FULL."
#Install bananianX full
echo
echo "It might take some time... Your Pi will reboot if this script is finished. You can abort the reboot."

sleep 5

echo "Updating..."

apt-get update

echo "Installing lightdm..."

apt-get install -y lightdm

apt-get install -y lightdm-gtk-greeter

echo "Installing LXDE Core..."

apt-get -qq install -y lxde-core

echo "OK, install xinit..."

echo "Xinit lets you start the X-Server with startx..."

apt-get install -y xinit

echo "Installing openbox Window Manager..."

apt-get install -y openbox

echo "Installing sudo, if you want to add an other user with root posibility..."

apt-get install -y sudo

echo "Setting up X..."

echo "Setting up X, so that a normal user can shutdown..."

apt-get install -y systemd-shim

echo "session required pam_systemd.so" >> /etc/pam.d/lxdm

echo "Installing optional packages…"

apt-get install -y xrdp mc midori pcmanfm avahi-daemon xarchiver galculator

echo "Finished! Will reboot in 10 Minutes!"
shutdown -t 10 -r

            ;;
        3)
            echo "You chose Option 3: exit"
clear
exit
            ;;
esac

#Jonathan Smith-Chung
