#!/bin/bash

# Desbloqueia o APT-GET

sudo killall apt apt-get;

# Update no apt-get

sudo apt-get update;
sudo apt upgrade -y;

# Instalar programas essenciais

sudo apt-get install vim whatsapp-desktop htop wine-installer vlc git filezilla thunderbird putty mint-meta-codecs steam:i386 audacity spotify-client gparted snapd -y

# Instalar programas via Flatpak

sudo flatpak install flathub org.telegram.desktop com.discordapp.Discord com.obsproject.Studio com.visualstudio.code -y;

# Verificar se tem placa NVIDIA e instalar dependencia

if lspci | grep "NVIDIA" > /dev/null
then
	sudo apt-get install nvidia-settings;
fi

# Mudar para pasta onde será baixado os .deb

mkdir /home/$USER/Documentos/Programas;

cd /home/$USER/Documentos/Programas;

# Instalar o Google Chrome e OpenDrive (Google Drive)

sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb;
sugo wget https://github.com/liberodark/ODrive/releases/download/0.3.0/odrive_0.3.0_amd64.deb

sudo dpkg -i *.deb;


# Instalar servidor web

# sudo apt install -y apache2 php php-cli php-common php-gd php-mbstring php-intl php-xml php-zip php-pear libapache2-mod-php mysql-server mysql-client php-mysql phpmyadmin;

sudo apt-get install lamp-server^ -y;

# Instalar XenCenter

sudo apt-get install python-gtk2 glade python-gtk-vnc python-glade2 python-configobj python-setuptools -y;
git clone https://github.com/OpenXenManager/openxenmanager.git;
cd openxenmanager;
sudo python setup.py install;