#!/bin/bash

DIR="~/dotfiles"
DOTFILES="tmux.conf vimrc bash* flake8"

cd

for file in $DOTFILES; do echo rm -f "~/.${file##*/}"; echo ln -s "$DIR/$file" "~/.${file##*/}"; done
echo ">~/.hushlogin"

# Vim configuration
VIM_DIR="$DIR/vim"
echo "mkdir ~/.vim"
echo "cp -aT $VIM_DIR/ftdetect/ ~/.vim/ftdetect/"
echo "cp -aT $VIM_DIR/ftplugin/ ~/.vim/ftplugin/"
echo "cp -aT $VIM_DIR/UltiSnips/ ~/.vim/UltiSnips/"

# echo "cp -a ~/dotfiles/config/sublime-text-3/* ~/.config/sublime-text-3/Packages/User/"

# TODO one-liners from bin
# TODO vim dir
