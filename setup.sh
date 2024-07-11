#!/bin/bash

# add directories
mkdir Repos
mkdir Development

sudo pacman -S curl wget git

# update packages & install YAY
# sudo pacman -Syu
# pacman -S --needed git base-devel
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si

yay -S qtile python-pywayland python-pywlroots alsa-utils python-xkbcommon wlroots
cp -r .config/qtile ~/.config/

sudo pacman -S man-pages man-db plocate
sudo pacman -S nerd-fonts zsh alacritty tmux neovim

sudo mandb
sudo updatedb

# cp .zshrc ~/.zshrc

# install tpm for tmux
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# cp .tmux.conf ~/.tmux.conf

# install packer for neovim
# git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
# cp -r .config/nvim ~/.config/
