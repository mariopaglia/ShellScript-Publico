#!/bin/bash

# Instala o ZSH, Oh My Zsh e plugins
git curl sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Configura o ZSH com o plugin de autocomplete e o tema simple
sed -i -e 's/^ZSH_THEME=.*/ZSH_THEME="simple"/' ~/.zshrc
sed -i -e 's/^plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions)/' ~/.zshrc

# Torna o ZSH o shell padrão

# Verifica se o trecho de código já existe no arquivo .bashrc
if ! grep -q "if \[ -t 1 \]; then\n  exec zsh\nfi" ~/.bashrc; then
  # Adiciona o trecho de código ao final do arquivo .bashrc
  echo -e "\nif [ -t 1 ]; then\n  exec zsh\nfi" >> ~/.bashrc
fi

# Reinicia o shell
exec zsh
