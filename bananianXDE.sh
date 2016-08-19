#!/bin/bash

###################################
#BananianX installer by jonisc    #
###################################

#DECLARE VARIABLES
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="BananianX installer"
TITLE="Install BananianX"
MESSAGETITLE="Hallo"
MESSAGETEXT="Hallo. Dieses Skript wird eine Grafische Benutzeroberfläche (LIGHTDM, LXDE, Openbox) auf Ihrem Banana Pi installieren. Bitte warten Sie noch kurz, ind gehen noch nicht weg. Sie werden Aussuchen können, welche BananianX Version Sie installieren möchten. Das Skript könnte 'etwas' Zeit benötigen... Ihr Pi wird nach Fertigstellung des Skripts Neustarten. Sie können den Neustart aber innerhalb von 10 Minuten unterbrechen."
MENU="Wählen Sie eine Option aus:"
OPTIONS=(1 "Option 1: BananianX LIGHT (only packets you really need-> less features, takes not as long as Option 2 to install, uses less disk space)"
         2 "Option 2: BananianX FULL (everything-> more features, but takes longer to install, uses more disk space) (recommended)"
         3 "Option 3: Don't reboot after installing BananianX LIGHT (Not recommended)")
#DIALOG INTRODUCTION

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

echo "Install 'Doggy' ;-)..."

apt-get install -y boxes

echo -e "\n\tHi! I'm Doggy. I'll install the GUI for you. OK. Let's start..." | boxes -d dog

sleep 3

echo "Let me update..."

sleep 3

echo -e "\n\tOh, now you can leave me alone. I'll restart the Pi 10 Minutes after the script is finished." | boxes -d dog


apt-get update

echo "Installing lightdm..."

apt-get install -y lightdm

apt-get install -y lightdm-gtk-greeter

echo "Installing LXDE Core..."

apt-get install -y lxde-core

echo "OK, install xinit..."

echo -e "\n\tXinit lets you start the X-Server with 'startx' ..." | boxes -d dog


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
echo -e "\n\tOK, I'll reboot your banana in 10 minutes..." | boxes -d dog
shutdown -t 10 -r



            ;;
        2)
echo -e "\n\tInstalling optional packages" | boxes -d dog

apt-get install -y sudo xrdp mc iceweasel pcmanfm avahi-daemon xarchiver galculator


echo -e "\n\tLet's reboot your banana in 10 Minutes..." | boxes -d dog
shutdown -t 10 -r

            ;;
        3)
            echo "You chose Option 3: exit"

exit
            ;;
esac

#Jonathan Smith-Chung
