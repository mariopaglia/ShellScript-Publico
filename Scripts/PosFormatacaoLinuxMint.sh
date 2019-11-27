#!/bin/bash

# Desbloqueia o APT-GET

sudo killall apt apt-get;

# Update no apt-get

sudo apt-get update -y;
sudo apt upgrade -y;

# Instalar programas essenciais

sudo apt-get install vim whatsapp-desktop htop wine-installer vlc git filezilla thunderbird putty mint-meta-codecs steam:i386 audacity spotify-client gparted snapd flameshot libnss3-tools libcurl3 -y

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

sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google_chrome.deb; # Google Chrome
sudo wget https://guardiao.itau.com.br/warsaw/warsaw_setup_64.deb -O warsaw.deb; # Guardião Itaú
sudo wget https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.0.24.40626-bionic_amd64.deb -O insync.deb; # Insync (Google Drive)
sudo wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb -O teamviewer.deb; # TeamViewer

sudo dpkg -i *.deb;

# Instalar servidor web

sudo apt-get install lamp-server^ -y;
sudo apt-get install phpmyadmin -y;

sudo mysql -e "
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
FLUSH PRIVILEGES;
"

USUARIO=$(sudo cat /etc/passwd | grep "/bin/bash" | grep -v "0:0" | awk -F ":" {'print $1'})

sudo chown -R $USUARIO:$USUARIO /var/www/html/

# Instalar Stacer (Limpeza e Otimização)

sudo add-apt-repository ppa:oguzhaninan/stacer -y;
sudo apt-get update;
sudo apt-get install stacer -y;

# Instalar VirtualBox

sudo echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" >> /etc/apt/sources.list;
sudo wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -;
sudo wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -;
sudo apt update;
sudo apt upgrade;
sudo apt install virtualbox;

# Instalar todas as dependencias faltantes dos programas instalados acima

sudo apt install -f -y;

# Limpeza do sistema

sudo apt-get autoremove -y;
sudo apt-get autoclean -y;