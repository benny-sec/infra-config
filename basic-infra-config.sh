#!/usr/bin/env bash

mkdir -p ~/workspace/tools 

sudo apt-get update && sudo apt -y install git zsh neovim wget

# install oh-my-zsh and change the shell to zsh for the user blackhawk
cd /tmp && wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh && sh install.sh --unattended && sudo chsh --shell /bin/zsh blackhawk

# enable the zsh plugins
sed -i s/plugins=\(git\)/plugins=\(git\ z\ vi-mode\)/g ~/.zshrc

# set-up jj as an alternative key to ESC in the zsh command line
sed -i s/bindkey\ -v/bindkey\ -v\\nbindkey\ jj\ vi-cmd-mode/  ~/.oh-my-zsh/plugins/vi-mode/vi-mode.plugin.zsh

# fzf -- mainly for the stylish reverse search
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all 

# install nvim, copy the vimrc from the github and set-up an alias to it.
mkdir -p ~/.config/nvim/ && cd ~/.config/nvim/ && wget https://raw.githubusercontent.com/benny-sec/infra-config/main/vim/init.vim
echo -e "alias vim=nvim\nalias ll='ls -alt'">~/.oh-my-zsh/custom/aliases.zsh

# fix locales
sudo locale-gen en_US && sudo locale-gen en_US.UTF-8 && export LC_ALL="en_US.UTF-8" && sudo update-locale LC_ALL=en_US.UTF-8 && . /etc/default/locale
