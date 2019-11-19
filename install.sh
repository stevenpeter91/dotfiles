#!/bin/bash

export DOTFILES=~/.dotfiles
export SRC_DIR=$DOTFILES

rm -f ~/.editorconfig ~/.zshrc ~/.zshenv ~/.hyper.js ~/.tmux.conf ~/.gitconfig ~/.config/nvim ~/.config/colorls

mkdir -p ~/.local/share/nvim/backup/
mkdir -p ~/.fonts/truetype/

export PACKAGE_MANAGER="sudo apt-get"
export ADDITIONAL_PACKAGES=""

if [ "$(uname)" == "Darwin" ]; then
  export PACKAGE_MANAGER="brew";
  export ADDITIONAL_PACKAGES="mas rg"
else
  export ADDITIONAL_PACKAGES="gem ruby-dev"
fi;

echo "$PACKAGE_MANAGER is the package manager"

cp $SRC_DIR/fonts/*.ttf ~/.fonts/truetype/

$PACKAGE_MANAGER install neovim ruby gcc watch $ADDITIONAL_PACKAGES
sudo gem install colorls compass sass

if [[ -z $(which fzf) ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi;

if [ "$(uname)" == "Darwin" ]; then
  mas install 866773894   # Quiver
  mas install 1432731683  # AdBlock Plus

  echo "All Extensions"
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  echo "Expand save dialog by default"
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

  echo "Show Library folder by default"
  chflags nohidden ~/Library

  echo "Show battery percentage"
  defaults write com.apple.menuextra.battery ShowPercent -string "YES"

  echo "Use current directory as default search scope in Finder"
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  echo "Show Path bar in Finder"
  defaults write com.apple.finder ShowPathbar -bool true

  echo "Show Status bar in Finder"
  defaults write com.apple.finder ShowStatusBar -bool true

  echo "Disable the “Are you sure you want to open this application?” dialog"
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  echo "Display full POSIX path as Finder window title"
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  echo "Show item info below desktop icons"
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

  echo "Enable snap-to-grid for desktop icons"
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

  # Show the full URL in the address bar (note: this still hides the scheme)
  defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

  # Set Safari’s home page to `about:blank` for faster loading
  defaults write com.apple.Safari HomePage -string "about:blank"

  # Hide Safari’s bookmarks bar by default
  defaults write com.apple.Safari ShowFavoritesBar -bool false

  echo "Enable Safari’s debug menu"
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

  echo "Add a context menu item for showing the Web Inspector in web views"
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

  echo "Disable the Ping sidebar in iTunes"
  defaults write com.apple.iTunes disablePingSidebar -bool true

  echo "Disable all the other Ping stuff in iTunes"
  defaults write com.apple.iTunes disablePing -bool true

  echo "Make ⌘ + F focus the search input in iTunes"
  defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"

  echo "Disable the “reopen windows when logging back in” option"
  # This works, although the checkbox will still appear to be checked.
  defaults write com.apple.loginwindow TALLogoutSavesState -bool false
  defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false

  echo "System audio volume"
  sudo nvram SystemAudioVolume=" "

  defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
fi;

ln -s $SRC_DIR/zsh/zshrc ~/.zshrc
ln -s $SRC_DIR/zsh/zshenv ~/.zshenv

ln -s $SRC_DIR/hyper/hyper.js ~/.hyper.js

ln -s $SRC_DIR/git/gitconfig ~/.gitconfig

ln -s $SRC_DIR/tmux/tmux.conf ~/.tmux.conf

ln -s $SRC_DIR/nvim ~/.config/nvim
ln -s $SRC_DIR/nvim/editorconfig ~/.editorconfig
ln -s $SRC_DIR/colorls ~/.config/colorls

fc-cache -fv ~/.fonts

os=$(uname -a | awk '{ print $4 }')

if [[ $os == "#1-Microsoft" ]]; then
  echo "Windows detected"
	if [[ -z $(which rg 2> /dev/null) ]]; then
		curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb && sudo dpkg -i ripgrep_11.0.2_amd64.deb
		rm -f ripgrep_11.0.2_amd64.deb
	fi;
  cp $SRC_DIR/hyper/hyper.js /mnt/c/Users/SPeter/AppData/Roaming/Hyper/.hyper.js
fi;

nvim +PlugInstall +qall
