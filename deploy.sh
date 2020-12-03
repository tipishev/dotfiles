#!/bin/bash

DIR="~/dotfiles"
DOTFILES="tmux.conf vimrc flake8 gitconfig Xmodmap gitignore_global ctags bash_logout bash_prompt bash_profile bashrc bash_aliases lynxrc i3 erlang user_default"

cd

for file in $DOTFILES; do echo rm -f "~/.${file##*/}"; echo ln -s "$DIR/$file" "~/.${file##*/}"; done
echo ">~/.hushlogin"

# Vim configuration
VIM_DIR="$DIR/vim"
echo "ln -s $VIM_DIR ~/.vim"

# TODO one-liners from bin
