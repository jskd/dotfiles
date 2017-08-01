#!/bin/bash

echo "Clone submodule"
git submodule init
git submodule update --depth 1 --recursive --remote

echo "Creating vim directory..."
mkdir -p vim

echo "Install font"
cd nerd-fonts/
./install.sh
cd ..



DOTFILES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

make_link () {
  if [ -f $HOME/.$1 ] ; then
    cp $HOME/.$1 $HOME/.$1.old
  fi
  ln -fsT $DOTFILES_ROOT/$1 $HOME/.$1
}


ln -fsT $DOTFILES_ROOT $HOME/.dotfiles

declare -a arr=("gitignore" "gitconfig" "profile" "vim" "vimrc" "bash_login" "bash_logout" "bash_profile" "bashrc" "zshrc" "Xresources" "xinitrc")

for i in "${arr[@]}"
do
   make_link $i
done

echo "Installing plugin manager..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Creating vimbackup directory..."
mkdir -p ~/.vim/backup

echo "Installing plugins..."
vim +PlugInstall +qall
