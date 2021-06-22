#!/usr/bin/env bash

mkdir -p ~/workspace/tools 

sudo apt-get update && sudo apt -y install git zsh neovim net-tools wget tree x11-apps

# install oh-my-zsh and change the shell to zsh for the user blackhawk
cd /tmp && wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && sh install.sh --unattended && sudo chsh --shell /bin/zsh $USER

# enable the zsh plugins & set theme
sed -i s/plugins=\(git\)/plugins=\(git\ z\ vi-mode\)/g ~/.zshrc
sed -i 's/ZSH_THEME=".*/ZSH_THEME="blinks"/g' ~/.zshrc


# set-up jj as an alternative key to ESC in the zsh command line
sed -i s/bindkey\ -v/bindkey\ -v\\nbindkey\ jj\ vi-cmd-mode/  ~/.oh-my-zsh/plugins/vi-mode/vi-mode.plugin.zsh

# fzf -- mainly for the stylish reverse search
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all 

# install nvim, copy the vimrc from the github and set-up an alias to it.
mkdir -p ~/.config/nvim/ && cd ~/.config/nvim/ && wget https://raw.githubusercontent.com/benny-sec/infra-config/main/vim/init.vim
echo -e "alias vim=nvim\nalias ll='ls -alt'">~/.oh-my-zsh/custom/aliases.zsh

# fix locales
sudo locale-gen en_US && sudo locale-gen en_US.UTF-8 && export LC_ALL="en_US.UTF-8" && sudo update-locale LC_ALL=en_US.UTF-8 && . /etc/default/locale

# Clone the infra-config repo and dump the commands for a few quick set-up (e.g Atlassian servers )
git clone https://github.com/benny-sec/infra-config.git ~/workspace/tools/infra-config
cat ~/workspace/tools/infra-config/README.md
