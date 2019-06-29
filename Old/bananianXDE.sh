#!/bin/bash

#####################################
#BananianXDE installer by jonisc    #
#####################################

#DECLARE VARIABLES
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="BananianX Installer"
TITLE="BananianX installieren"
MESSAGETITLE="Hallo"
MESSAGETEXT="Hallo. Dieses Skript wird eine Grafische Benutzeroberfläche (LIGHTDM, LXDE, Openbox) auf Ihrem Banana Pi installieren. Bitte warten Sie noch kurz, und gehen noch nicht weg. Sie werden Aussuchen können, welche BananianX Version Sie installieren möchten. Das Skript könnte 'etwas' Zeit benötigen... Ihr Pi wird nach Fertigstellung des Skripts Neustarten. Sie können den Neustart aber innerhalb von 10 Minuten unterbrechen."
MENU="Wählen Sie bitte eine Option aus:"
OPTIONS=(1 "Option 1: BananianX LIGHT (nur die allerwichtigsten Pakete-> weniger Features, dauert nicht so lange wie Option 2, verbraucht weniger Speicherplatz)"
         2 "Option 2: BananianX FULL (Alles-> mehr Features, dauert laenger, verbraucht mehr Speicherplatz) (Vorschlag)"
         3 "Option 3: BananianX LIGHT ohne Neustart installieren. (Nicht empfohlen)")

######################################

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

echo "Installiere 'Doggy' ;-)..."

apt-get install -y boxes

echo -e "\n\tHallo! Ich heiße Doggy. Ich werde die GUI für dich Installieren. OK, Los geht's..." | boxes -d dog

sleep 3

echo "Lass mich ein Update machen..."

sleep 3

echo -e "\n\tOh, bevor ich's vergesse: Du kannst mich jetzt allein lassen." | boxes -d dog


apt-get update

echo "Installiere lightdm..."

apt-get install -y lightdm

apt-get install -y lightdm-gtk-greeter

echo "Installiere LXDE Core..."

apt-get install -y lxde-core

echo "Gut, installiere xinit..."

echo -e "\n\tXinit ermöglicht es den X-Server mit 'startx' zu starten." | boxes -d dog


apt-get install -y xinit

echo "Installiere openbox Window Manager..."

apt-get install -y openbox

echo "Konfiguriere X..."


echo -e "\n\tKonfiguriere X, sodass ein normaler Benutzer den Pi Herunterfahren kann." | boxes -d dog

apt-get install -y systemd-shim

echo "session required pam_systemd.so" >> /etc/pam.d/lxdm

clear

case $CHOICE in
        1)
echo -e "\n\Fertig! Ich starte die Banane in 10 Minuten neu." | boxes -d dog

shutdown -t 10 -r



            ;;
        2)
echo -e "\n\tSo, jetzt installiere ich optionale Pakete." | boxes -d dog

apt-get install -y sudo xrdp mc iceweasel pcmanfm avahi-daemon xarchiver galculator


echo -e "\n\tFertig! Ich starte die Banane in 10 Minuten neu." | boxes -d dog
shutdown -t 10 -r

            ;;
        3)
            echo "Ok. Dann halt kein Neustart :-("

exit
            ;;
esac

#ann0see
