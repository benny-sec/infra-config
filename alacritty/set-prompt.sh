#!/usr/bin/env zsh

# download the spaceship plugin to set-up a custom prompt
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1

ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" 

# firacode font is needed to correctly display the programming ligatures
sudo apt -y install fonts-firacode

# configure  ZSH to use the spaceship plugin
sed -i 's/ZSH_THEME=.*/ZSH_THEME="spaceship"/' ~/.zshrc

# configure alacritty to use the firacode font so that the spaceship plugin can display ligatures 
mkdir -p ~/.config/alacritty && wget https://raw.githubusercontent.com/benny-sec/infra-config/main/alacritty/alacritty.yml -O ~/.config/alacritty/alacritty.yml


