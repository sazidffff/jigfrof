#!/bin/sh

vncuser="$(whoami)"
passwdvnc="123456"

sudo apt update && sudo apt full-upgrade -y

sudo DEBIAN_FRONTEND=noninteractive \
    apt install --assume-yes ubuntu-mate-desktop mate* desktop-base dbus-x11 qbittorrent tightvncserver

wget -c https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -O - | tar -xz

sudo cp ./ngrok /usr/bin/

ngrok config add-authtoken 2WIPCVbYJlme1LefE4vV8qMZ4py_3goQKfozom34gomEfFy1d

mkdir /home/$vncuser/.vnc

echo $passwdvnc | vncpasswd -f > /home/$vncuser/.vnc/passwd

chown -R $vncuser:$vncuser /home/$vncuser/.vnc

chmod 0600 /home/$vncuser/.vnc/passwd

vncserver -kill :1

vncserver

vncserver -kill :1

sudo echo "/usr/bin/mate-session &" >>  ~/.vnc/xstartup

sudo chmod +x ~/.vnc/xstartup

wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/116.0/linux-x86_64/en-GB/firefox-116.0.tar.bz2

sudo tar xjf firefox-*.tar.bz2

sudo mv firefox /opt

rm firefox-*.tar.bz2

sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox

sudo wget https://raw.githubusercontent.com/mozilla/sumo-kb/main/install-firefox-linux/firefox.desktop -P /usr/local/share/applications

vncserver :1 -geometry 2160x1080 -depth 24

echo "region: in" >> $HOME/.config/ngrok/ngrok.yml

sudo echo -e "vncserver :1 -geometry 2160x1080 -depth 24\n python3 -m http.server 9999 & \n ngrok tcp 5901" > /usr/bin/st

sudo chmod +x /usr/bin/st
