#!/bin/bash

#Version 2

#Declare Variables

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=4
BACKTITLE="BananianX installer"
TITLE="Install BananianX"
MESSAGETITLE="Message"

MESSAGETEXT="Hi. This script will install a GUI (LIGHTDM, LXDE, Openbox) on your Banana Pi. Please wait and don't leave the Pi alone for now. You will be able to choose which version of BananianX you want to install. It might take some time... After the script is finished, the Pi will restart within 10 minutes. You can abort the reboot."

GETREADY="Getting ready..."

MENU="Choose one of the following options:"
OPTIONS=(1 "Option 1: BananianX LIGHT (only packets you really need-> less features, takes not as long as Option 2 to install, uses less disk space)"
         2 "Option 2: BananianX FULL (everything-> more features, but takes longer to install, uses more disk space) (recommended)"
         3 "Option 3: Don't reboot after installing BananianX LIGHT (Not recommended)"
4 "Install BananianX FULL without resboot. (Not recommended)")

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

PLS_RESTART="But please restart the Pi with command (reboot) later."

#If you don't know what you are doing, don't edit after this line!
######################################

#DIALOG INTRODUCTION

echo "$MESSAGETEXT"

sleep 10

clear

echo "$GETREADY"

apt -qq install dialog

clear

dialog --msgbox "$MESSAGETEXT" $HEIGHT $WIDTH

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

case $CHOICE in
        
0)
clear
echo "Exit..."

exit
;;

1)
echo "Hi! I'll install LIGHT"


            ;;
        2)
echo "Hi! I'll install FULL!"
            ;;
        3)
            echo "Ok. No restart after LIGHT installation is finished"
            ;;
4) 
echo "No restart after FULL installation is finished."

;;
*) 
echo "Unknown error. Variable 'CHOICE' has unexpected content. Install BananianX LIGHT without reboot!..."
;;
esac
#START INSTALLING

echo "$INSTALLDOGGY"

apt install -y boxes

echo -e "\n\t$INTRODOGGY" | boxes -d dog

sleep 3

echo "$UPDATEMSG"

sleep 3

echo -e "\n\t$LETALONE" | boxes -d dog

apt update

echo "Install X server Xorg"

apt install -y xorg

echo "$INST_LIGHTDM"

apt install -y lightdm

echo "$INST_LXDE"

apt install -y lxde-core

echo "$INST_XINIT"

echo -e "\n\t$DES_XINIT" | boxes -d dog

apt install -y xinit

#echo "$INST_OPENBOX"

#apt install -y openbox

echo "$SETUP_X"

echo -e "\n\t$SETUP_X_DES" | boxes -d dog

apt install -y systemd-shim

echo "session required pam_systemd.so" >> /etc/pam.d/lxdm


case $CHOICE in
        1)
echo -e "\n\t$RESTART" | boxes -d dog
shutdown -r 10


            ;;
        2)
echo -e "\n\t$OPTIONAL_P" | boxes -d dog

apt install -y sudo gparted xrdp mc iceweasel pcmanfm avahi-daemon xarchiver galculator


echo -e "\n\t$RESTART" | boxes -d dog
shutdown -r 10

            ;;
        3)
            
clear

echo "$NO_RESTART"

sleep 2

echo "$PLS_RESTART"

sleep 5

exit
            ;;
4) 
echo -e "\n\t$OPTIONAL_P" | boxes -d dog

apt install -y sudo gparted xrdp mc iceweasel pcmanfm avahi-daemon xarchiver galculator

clear

echo "$NO_RESTART"

sleep 2

echo "$PLS_RESTART"

sleep 5

exit

;;

esac

#jonisc

