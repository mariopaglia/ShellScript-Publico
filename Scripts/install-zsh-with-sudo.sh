#!/bin/bash

# Instala o ZSH
sudo apt-get update
sudo apt-get install -y zsh

# Instala o plugin de autocomplete (zsh-autosuggestions)
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Configura o ZSH com o plugin de autocomplete e o tema simple
sed -i -e 's/^ZSH_THEME=.*/ZSH_THEME="simple"/' ~/.zshrc
sed -i -e 's/^plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions)/' ~/.zshrc

# Define o ZSH como o shell padrão do usuário atual
chsh -s $(which zsh)

# Reinicia o shell
exec zsh