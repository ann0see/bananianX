#!/bin/bash

###################################
#BananianX installer by jonisc    #
###################################

#VERSION 2

#DECLARE VARIABLES

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
#DECLARE LANGUAGE VARIABLES
BACKTITLE="BananianX Installer"
TITLE="BananianX installieren"
MESSAGETITLE="Hallo. Dieses Skript wird eine grafische Benutzeroberfläche (LIGHTDM, LXDE, Openbox) auf Ihrem Banana Pi installieren. Bitte warten Sie noch kurz, und verlassen Sie den Arbeitsplatz nicht. Sie werden aussuchen können, welche BananianX Version Sie installieren möchten. Das Skript könnte 'etwas' Zeit benötigen... Ihr Pi wird nach Fertigstellung des Skripts neustarten. Sie können den Neustart aber innerhalb von 10 Minuten unterbrechen."
MENU="Wählen Sie bitte eine Option aus:"
OPTIONS=(1 "Option 1: BananianX LIGHT (nur die allerwichtigsten Pakete-> weniger Features, dauert nicht so lange wie Option 2, verbraucht weniger Speicherplatz)"
         2 "Option 2: BananianX FULL (Alles-> mehr Features, dauert länger, verbraucht mehr Speicherplatz) (empfohlen)"
         3 "Option 3: BananianX LIGHT ohne Neustart installieren. (Nicht empfohlen)")
INSTALLDOGGY="Installiere 'Doggy' ;-)..."

INTRODOGGY="Hallo! Ich heiße Doggy. Ich werde die GUI für dich installieren. OK, Los geht's.."

UPDATEMSG="Lass mich ein Update machen...""


LETALONE="Oh, bevor ich's vergesse: Du kannst mich jetzt allein lassen.""

INST_LIGHTDM="Installiere lightdm..."

INST_LXDE="Installiere LXDE Core..."

INST_XINIT="Gut, installiere xinit..."

DES_XINIT="Xinit ermöglicht es den X-Server mit 'startx' zu starten."

INST_OPENBOX="Installiere Openbox Fenster Manager.."

SETUP_X="Konfiguriere X.."

SETUP_X_DES="Konfiguriere X, so dass ein normaler Benutzer den Pi herunterfahren kann."

RESTART="Fertig! Ich starte die Banane in 10 Minuten neu."

OPTIONAL_P="So, jetzt installiere ich optionale Pakete."

NO_RESTART="Ok, dann halt kein Neustart :-("

PLS_RESTART="Bitte starten Sie den Pi später mit dem Kommando (reboot) neu."

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
            clear

echo "$NO_RESTART"

sleep 2

echo "$PLS_RESTART"

sleep 5

exit
            ;;
esac

#Jonathan Smith-Chung
