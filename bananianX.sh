#!/bin/bash

###################################
#BananianX installer by jonisc
###################################

#DECLARE VARIABLES
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="BananianX installer"
TITLE="Install BananianX"
MESSAGETITLE="Message"
MESSAGETEXT="Hi. This script will install a GUI (LIGHTDM, LXDE, Openbox) on your Banana Pi. Please wait and don go away. You will be able to choose which version of BananianX you want to install. It might take some time... Your Pi will reboot if this script is finished. You can abort the reboot."
MENU="Choose one of the following options:"
OPTIONS=(1 "Option 1: BananianX LIGHT (only packets you really need-> less features, takes not as long as Option 2 to install, uses less disk space)"
         2 "Option 2: BananianX FULL (everything-> more features, but takes longer to install, uses more disk space) (recommended)"
         3 "Option 3: Dont reboot after installing BananianX LIGHT (Not recommended)")
#DIALOG INTRODUCTION

dialog --backtitle "$BACKTITLE" \
--title "$MESSAGETITLE" \ 
--msgbox "$MESSAGETEXT" $HEIGHT $WIDTH
clear
#DIALOG CHOOSE OPTIONS

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear # CLEAR SCREEN
#START INSTALLING

echo "Install something ;-)..."

apt-get install -y boxes

echo -e "\n\tOK. Let's start... Updating..." | boxes -d dog

apt-get update

echo "Installing lightdm..."

apt-get install -y lightdm

apt-get install -y lightdm-gtk-greeter

echo "Installing LXDE Core..."

apt-get install -y lxde-core

echo "OK, install xinit..."

echo -e "\n\tXinit lets you start the X-Server with startx..." | boxes -d dog


apt-get install -y xinit

echo "Installing openbox Window Manager..."

apt-get install -y openbox
echo "Setting up X..."


echo -e "\n\Setting up X, so that a normal user can shutdown..." | boxes -d dog

apt-get install -y systemd-shim

echo "session required pam_systemd.so" >> /etc/pam.d/lxdm

clear
case $CHOICE in
        1)
echo -e "\n\tWill reboot in 10 minutes..." | boxes -d dog
shutdown -t 10 -r



            ;;
        2)
echo "Installing optional packages…"

apt-get install -y sudo xrdp mc iceweasel pcmanfm avahi-daemon xarchiver galculator


echo -e "\n\tLet me reboot your banana in 10 Minutes..." | boxes -d dog
shutdown -t 10 -r

            ;;
        3)
            echo "You chose Option 3: exit"
clear
exit
            ;;
esac

#Jonathan Smith-Chung
