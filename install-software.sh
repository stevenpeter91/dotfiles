#!/bin/bash

export PACKAGE_MANAGER="sudo apt-get -y"
export ADDITIONAL_PACKAGES=""

if [ "$(uname)" == "Darwin" ]; then
  brew tap homebrew/cask-fonts
  brew cask install font-fira-code font-hack-nerd-font
  export PACKAGE_MANAGER="brew";
  export ADDITIONAL_PACKAGES="mas rg"
else
  export ADDITIONAL_PACKAGES="gem ruby-dev rofi ao ripgrep tig"
fi;

echo "$PACKAGE_MANAGER is the package manager"

echo "Installing system software"
$PACKAGE_MANAGER update
$PACKAGE_MANAGER upgrade
$PACKAGE_MANAGER install tmux neovim ruby gcc watch npm composer curl $ADDITIONAL_PACKAGES
echo "Installing gems"
sudo gem install colorls neovim
echo "Installing node global"
sudo npm install -g typescript yarn eslint sass compass

if [[ -z $(which fzf) ]]; then
	echo "Installing fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi;

echo "Installing nvim plugins"
if [[ ! -f ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim ]]; then
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

nvim +PlugInstall +qall
