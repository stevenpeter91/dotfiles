#!/bin/bash

export DOTFILES=~/.dotfiles
export SRC_DIR=$DOTFILES

rm -f ~/.zshrc ~/.zshenv ~/.hyper.js ~/.tmux.conf ~/.gitconfig ~/.config/nvim ~/.config/colorls

mkdir -p ~/.local/share/nvim/backup/

ln -s $SRC_DIR/zsh/zshrc ~/.zshrc
ln -s $SRC_DIR/zsh/zshenv ~/.zshenv

ln -s $SRC_DIR/hyper/hyper.js ~/.hyper.js

ln -s $SRC_DIR/git/gitconfig ~/.gitconfig

ln -s $SRC_DIR/tmux/tmux.conf ~/.tmux.conf

ln -s $SRC_DIR/nvim ~/.config/nvim
ln -s $SRC_DIR/colorls ~/.config/colorls
