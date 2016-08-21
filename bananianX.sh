#!/bin/bash

#Version 2

#Declare Variables

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="BananianX installer"
TITLE="Install BananianX"
MESSAGETITLE="Message"
MESSAGETEXT="Hi. This script will install a GUI (LIGHTDM, LXDE, Openbox) on your Banana Pi. Please wait and don't leave the Pi alone for now. You will be able to choose which version of BananianX you want to install. It might take some time... After the script is finished, the Pi will restart within 10 minutes. You can abort the reboot."
MENU="Choose one of the following options:"
OPTIONS=(1 "Option 1: BananianX LIGHT (only packets you really need-> less features, takes not as long as Option 2 to install, uses less disk space)"
         2 "Option 2: BananianX FULL (everything-> more features, but takes longer to install, uses more disk space) (recommended)"
         3 "Option 3: Don't reboot after installing BananianX LIGHT (Not recommended)")

INSTALLDOGGY="Install 'Doggy' ;-)..."

INTRODOGGY="Hi! I'm Doggy. I'll install the GUI for you. OK. Let's start..."
UPDATEMSG="Let me update..."

LETALONE="Oh, now you can leave me alone. I'll restart the Pi 10 minutes after the script is finished."

INST_LIGHTDM="Installing lightdm..."

INST_LXDE="Installing LXDE Core..."

INST_XINIT="OK, install xinit..."

DES_XINIT="Xinit allows you to start the X-Server with 'startx'..."

INST_OPENBOX="Installing openbox window manager..."

SETUP_X="Setting up X..."

SETUP_X_DES="Setting up X, so that a normal user can shutdown..."

RESTART="OK, I'll reboot your banana in 10 minutes..."

OPTIONAL_P="Installing optional packages..."

NO_RESTART="OK. I won't restart :-("

#If you don't know what you are doing, don't edit after this line!
######################################

#DIALOG INTRODUCTION

clear

dialog --backtitle "$BACKTITLE" \
--title "$MESSAGETITLE" \ 
--msgbox "$MESSAGETEXT" $HEIGHT $WIDTH

#DIALOG CHOOSE OPTIONS

clear

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear # CLEAR SCREEN
#START INSTALLING

echo "$INSTALLDOGGY"

apt-get install -y boxes

echo -e "\n\t$INTRODOGGY" | boxes -d dog

sleep 3

echo "$UPDATEMSG"

sleep 3

echo -e "\n\t$LETALONE" | boxes -d dog

apt-get update

echo "$INST_LIGHTDM"

apt-get install -y lightdm

apt-get install -y lightdm-gtk-greeter

echo "$INST_LXDE"

apt-get install -y lxde-core

echo "$INST_XINIT"

echo -e "\n\t$DES_XINIT" | boxes -d dog


apt-get install -y xinit

echo "$INST_OPENBOX"

apt-get install -y openbox
echo "$SETUP_X"


echo -e "\n\t$SETUP_X_DES" | boxes -d dog

apt-get install -y systemd-shim

echo "session required pam_systemd.so" >> /etc/pam.d/lxdm

clear
case $CHOICE in
        1)
echo -e "\n\t$RESTART" | boxes -d dog
shutdown -t 10 -r


            ;;
        2)
echo -e "\n\t$OPTIONAL_P" | boxes -d dog

apt-get install -y sudo xrdp mc iceweasel pcmanfm avahi-daemon xarchiver galculator


echo -e "\n\t$RESTART" | boxes -d dog
shutdown -t 10 -r

            ;;
        3)
            echo "$NO_RESTART"
exit
            ;;
esac

#Jonathan Smith-Chung