#!/bin/bash

export DOTFILES=~/.dotfiles
export SRC_DIR=$DOTFILES

rm -f ~/.zshrc ~/.zshenv ~/.hyper.js ~/.tmux.conf ~/.gitconfig ~/.config/nvim ~/.config/colorls

mkdir -p ~/.local/share/nvim/backup/
mkdir -p ~/.fonts/truetype/

cp $SRC_DIR/fonts/*.ttf ~/.fonts/truetype/

sudo apt-get install gem neovim ruby ruby-dev gcc
sudo gem install colorls

if [[ -z $(which fzf) ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi;

ln -s $SRC_DIR/zsh/zshrc ~/.zshrc
ln -s $SRC_DIR/zsh/zshenv ~/.zshenv

ln -s $SRC_DIR/hyper/hyper.js ~/.hyper.js

ln -s $SRC_DIR/git/gitconfig ~/.gitconfig

ln -s $SRC_DIR/tmux/tmux.conf ~/.tmux.conf

ln -s $SRC_DIR/nvim ~/.config/nvim
ln -s $SRC_DIR/colorls ~/.config/colorls

fc-cache -fv ~/.fonts

os=$(uname -a | awk '{ print $4 }')

if [[ $os == "#1-Microsoft" ]]; then
  echo "Windows detected"
  cp $SRC_DIR/hyper/hyper.js /mnt/c/Users/SPeter/AppData/Roaming/Hyper/.hyper.js
fi;

