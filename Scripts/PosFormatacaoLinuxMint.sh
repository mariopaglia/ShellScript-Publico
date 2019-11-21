#!/bin/bash

# Desbloqueia o APT-GET

sudo killall apt apt-get;

# Update no apt-get

sudo apt-get update -y;
sudo apt upgrade -y;

# Instalar programas essenciais

sudo apt-get install vim whatsapp-desktop htop wine-installer vlc git filezilla thunderbird putty mint-meta-codecs steam:i386 audacity spotify-client gparted snapd libnss3-tools libcurl3 -y

# Instalar programas via Flatpak

sudo flatpak install flathub org.telegram.desktop com.discordapp.Discord com.obsproject.Studio com.visualstudio.code -y;

# Verificar se tem placa NVIDIA e instalar dependencia

if lspci | grep "NVIDIA" > /dev/null
then
	sudo apt-get install nvidia-settings -y;
fi

# Mudar para pasta onde será baixado os .deb

mkdir /home/$USER/Documentos/Programas;

cd /home/$USER/Documentos/Programas;

# Preparar instalação do OverGrive

sudo add-apt-repository -y ppa:jonathonf/python-3.5 && sudo apt update && sudo apt install python3.5 -y;
sudo add-apt-repository universe && sudo apt-get update -y;

# Baixar e instalar .DEB

sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; # Google Chrome
sudo wget https://guardiao.itau.com.br/warsaw/warsaw_setup_64.deb -O warsaw.deb; # Guardião Itaú
sudo wget https://www.thefanclub.co.za/sites/all/modules/pubdlcnt/pubdlcnt.php?file=https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive_3.3.3_all.deb&nid=168 -O overgrive.deb; # OverGrive (Sincronização Google Drive)

sudo dpkg -i *.deb;


# Instalar servidor web

sudo apt-get install lamp-server^ -y;

# Instalar XenCenter

sudo apt-get install python-gtk2 glade python-gtk-vnc python-glade2 python-configobj python-setuptools -y;
git clone https://github.com/OpenXenManager/openxenmanager.git;
cd openxenmanager;
sudo python setup.py install;

# Instalar todas as dependencias faltantes dos programas instalados acima

sudo apt install -f -y;

