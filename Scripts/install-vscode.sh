#!/bin/bash

# Define o URL de download do Visual Studio Code
URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"

# Define o diretório de download
DOWNLOAD_DIR="/home/mario.junior@consorciei.local"

# Define o nome do arquivo DEB
FILE_NAME="vscode.deb"

# Download e instalação do Visual Studio Code
echo "Baixando a versão mais recente do Visual Studio Code..."

curl -o "$DOWNLOAD_DIR/$FILE_NAME" -L "$URL"

sudo dpkg -i "$DOWNLOAD_DIR/$FILE_NAME"

echo "Visual Studio Code instalado com sucesso!"

# Configuração do cron job
CMD="0 12 * * 1 /home/mario.junior@consorciei.local/install-vscode.sh"

# Verifica se o comando já existe no crontab
if ! crontab -l | grep -q -F "$CMD"; then
  echo "Configurando o cron job para atualização automática..."
  # Adiciona o comando ao crontab
  (crontab -l 2>/dev/null; echo "$CMD") | crontab -
  echo "Adicionado comando ao crontab: $CMD"
fi
