#!/bin/bash
#BananianX installer DE (German)
###################BETA###################

echo "Hallo. Dieses Skript wird eine Grafische Oberflaeche auf Ihrem Banana Pi installieren. Bitte warten Sie einen Moment und gehen Sie noch nicht. Nach dieser Operation werden Sie ein Menue sehen, das Sie aussuchen laesst, welche Version Sie installieren moechten..."
echo
echo "Bitte Warten... dialog wird installiert..."
apt-get install -y dialog   #install dialog #needed??
clear
echo "Dialog wurde installiert!"
echo
sleep 5
echo "Los geht's..."
sleep 1

#Dialog choose BananianX FULL /LIGHT
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="BananianX Installer"
TITLE="BananianX installieren"
MENU="Bitte waehlen Sie eine Option aus:"

OPTIONS=(1 "Option 1: BananianX LIGHT (nur die allerwichtigsten Pakete-> weniger Features, dauert nicht so lange wie Option 2, verbraucht weniger Speicherplatz)"
         2 "Option 2: BananianX FULL (Alles-> mehr Features, dauert laenger, verbraucht mehr Speicherplatz) (Vorschlag)"
         3 "Option 3: Abbrechen (Nichts installieren)")

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
echo "Sie haben Option 1 ausgewaehlt. BananianX LIGHT wird installiert."
echo

#Install bananianX light

echo "Es koennte dauern... Ihr PI wird am Ende neu Starten. Aber Sie können den Neustart unterbrechen."

sleep 5

echo "Update..."

apt-get update

echo "Installiere lightdm..."

apt-get install -y lightdm

apt-get install -y lightdm-gtk-greeter

echo "Installiere LXDE Core..."

apt-get install -y lxde-core

echo "OK, installiere xinit..."

echo "Xinit ermoeglicht ihnen den Start der GUI mit startx..."

apt-get install -y xinit

echo "Installiere Openbox Window Manager..."

apt-get install -y openbox

echo "Installiere sudo, wenn Sie einen anderen Benutzer mit root Rechten erstellen moechten..."

apt-get install -y sudo

echo "Konfiguriere X..."

echo "Konfiguriere X, sodass ein normaler Benutzer den Pi herunterfahren kann..."

apt-get install -y systemd-shim

echo "session required pam_systemd.so" >> /etc/pam.d/lxdm

clear

echo "Fertig! Werde in 10 Minuten neustarten!"
shutdown -t 10 -r


            ;;
        2)
echo "Sie haben Option 2 ausgewaehlt. BananianX FULL wird installiert."
echo

#Install bananianX light

echo "Es koennte dauern... Ihr PI wird am Ende neu Starten. Aber Sie können den Neustart unterbrechen."

sleep 5

echo "Update..."

apt-get update

echo "Installiere lightdm..."

apt-get install -y lightdm

apt-get install -y lightdm-gtk-greeter

echo "Installiere LXDE Core..."

apt-get install -y lxde-core

echo "OK, installiere xinit..."

echo "Xinit ermoeglicht ihnen den Start der GUI mit startx..."

apt-get install -y xinit

echo "Installiere openbox Window Manager..."

apt-get install -y openbox

echo "Installiere sudo, wenn Sie einen anderen Benutzer mit root Rechten erstellen moechten..."

apt-get install -y sudo

echo "Konfiguriere X..."

echo "Konfiguriere X, sodass ein normaler Benutzer den Pi herunterfahren kann..."

apt-get install -y systemd-shim

echo "session required pam_systemd.so" >> /etc/pam.d/lxdm

clear

echo "Installiere optionale Pakete…"

apt-get install -y xrdp mc midori pcmanfm

echo "Fertig! Werde in 10 Minuten neustarten!"
shutdown -t 10 -r
            ;;
        3)
            echo "Sie haben Option 3 gewaehlt: exit"
clear
exit
            ;;
esac

#Jonathan Smith-Chung
