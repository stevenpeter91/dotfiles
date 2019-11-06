#!/bin/bash

export SRC_DIR=$(pwd)

rm -f ~/.zshrc ~/.zshenv ~/.hyper.js ~/.tmux.conf ~/.gitconfig ~/.config/nvim ~/.config/colorls

ln -s $SRC_DIR/.zshrc ~/.zshrc
ln -s $SRC_DIR/.zshenv ~/.zshenv

ln -s $SRC_DIR/.hyper.js ~/.hyper.js

ln -s $SRC_DIR/.gitconfig ~/.gitconfig

ln -s $SRC_DIR/.tmux.conf ~/.tmux.conf

ln -s $SRC_DIR/nvim ~/.config/nvim
ln -s $SRC_DIR/colorls ~/.config/colorls
