#!/bin/sh

DOTFILES_ROOT=$(pwd)

ln -fsT $DOTFILES_ROOT ~/.dotfiles
ln -fsT $DOTFILES_ROOT/vim ~/.vim
ln -fsT $DOTFILES_ROOT/vimrc ~/.vimrc
ln -fsT $DOTFILES_ROOT/bash_login ~/.bash_login
ln -fsT $DOTFILES_ROOT/bash_logout ~/.bash_logout
ln -fsT $DOTFILES_ROOT/bash_profile ~/.bash_profile
ln -fsT $DOTFILES_ROOT/bashrc ~/.bashrc
ln -fsT $DOTFILES_ROOT/zshrc ~/.zshrc
ln -fsT $DOTFILES_ROOT/Xresources ~/.Xresources 
ln -fsT $DOTFILES_ROOT/xinitrc ~/.xinitrc

