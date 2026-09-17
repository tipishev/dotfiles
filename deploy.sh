#!/bin/bash

DIR="~/dotfiles"
DOTFILES="vimrc flake8 gitconfig Xmodmap gitignore_global ctags bash_logout bash_prompt bash_profile bashrc bash_aliases lynxrc i3 erlang user_default kerlrc"

cd

for file in $DOTFILES; do echo rm -f "~/.${file##*/}"; echo ln -s "$DIR/$file" "~/.${file##*/}"; done
echo ">~/.hushlogin"

# Vim configuration
VIM_DIR="$DIR/vim"
echo "ln -s $VIM_DIR ~/.vim"

# Tmux configuration (XDG path)
TMUX_DIR="$DIR/tmux"
echo "mkdir -p ~/.config"
echo "ln -s $TMUX_DIR ~/.config/tmux"

# Alacritty configuration (XDG path)
ALACRITTY_DIR="$DIR/alacritty"
echo "mkdir -p ~/.config"
echo "ln -s $ALACRITTY_DIR/alacritty.toml ~/.config/alacritty/alacritty.toml"
# alacritty.toml imports a theme from alacritty/alacritty-theme; clone it separately:
echo "git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes"

# Helix configuration (XDG path)
HELIX_DIR="$DIR/helix"
echo "mkdir -p ~/.config/helix"
echo "ln -s $HELIX_DIR/config.toml ~/.config/helix/config.toml"
echo "ln -s $HELIX_DIR/languages.toml ~/.config/helix/languages.toml"
# runtime/ is a symlink to a local helix source checkout's runtime dir, built separately

echo "ln -s $DIR/user_default.erl ~/user_default.erl"
echo "ln -s $DIR/erlang ~/erlang"
