#!/bin/bash
#BananianX installer default (English)
###################BETA2###################
#Declare Variables

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="BananianX installer"
TITLE="Install BananianX"
MESSAGETITLE="Message"
MESSAGETEXT="Hi. This script will install a GUI on your Banana Pi. Please wait and don go away. You will be able to choose how many packets you want to install. It might take some time... Your Pi will reboot if this script is finished. You can abort the reboot."
MENU="Choose one of the following options:"
OPTIONS=(1 "Option 1: BananianX LIGHT (only packets you really need-> less features, takes not as long as Option 2 to install, uses less disk space)"
         2 "Option 2: BananianX FULL (everything-> more features, but takes longer to install, uses more disk space) (recommended)"
         3 "Option 3: Dont reboot after installing BananianX LIGHT (Not recommended)")

dialog --backtitle "$BACKTITLE" \
--title "$MESSAGETITLE" \ 
--msgbox "$MESSAGETEXT" $HEIGHT $WIDTH
clear

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
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
echo "Setting up X..."

echo "Setting up X, so that a normal user can shutdown..."

apt-get install -y systemd-shim

echo "session required pam_systemd.so" >> /etc/pam.d/lxdm

clear
case $CHOICE in
        1)
shutdown -t 10 -r
echo "Will reboot in 10 minutes"



            ;;
        2)
echo "Installing optional packages…"

apt-get install -y sudo xrdp mc iceweasel pcmanfm avahi-daemon xarchiver galculator

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
