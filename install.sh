#!/bin/sh

DOTFILES_ROOT=$(pwd)


ln -fs $DOTFILES_ROOT ~/.dotfiles
ln -fs $DOTFILES_ROOT/bash_login ~/.bash_login
ln -fs $DOTFILES_ROOT/bash_logout ~/.bash_logout
ln -fs $DOTFILES_ROOT/bash_profile ~/.bash_profile
ln -fs $DOTFILES_ROOT/bashrc ~/.bashrc
ln -fs $DOTFILES_ROOT/zshrc ~/.zshrc
ln -fs $DOTFILES_ROOT/Xresources ~/.Xresources 
ln -fs $DOTFILES_ROOT/xinitrc ~/.xinitrc

