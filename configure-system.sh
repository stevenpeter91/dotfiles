#!/bin/bash

export DOTFILES=~/.dotfiles
export SRC_DIR=$DOTFILES

# rm -rf ~/.editorconfig ~/.zshrc ~/.zshenv ~/.hyper.js ~/.tmux.conf ~/.gitconfig ~/.config/nvim ~/.config/colorls ~/.config/rofi

mkdir -p ~/.local/share/nvim/backup/
mkdir -p ~/.fonts/truetype/

cp $SRC_DIR/fonts/*.ttf ~/.fonts/truetype/

if [ "$(uname)" == "Darwin" ]; then
  echo "Doing MAC Stuff"
  # mas install 866773894   # Quiver
  mas install 1432731683  # AdBlock Plus
  mas install 1147396723  # WhatsApp Desktop
  mas install 411643860   # DaisyDisk
  mas install 1026349850  # Copied
  mas install 1173932628  # Drop - Color Picker
  mas install 1033480833  # Decompresssor

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
	'{"enabled" = 0;"name" = "DIRECTORIES";}' \
	'{"enabled" = 0;"name" = "PDF";}' \
	'{"enabled" = 0;"name" = "FONTS";}' \
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

  echo "Enable spotlight"
  sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

  echo "Start indexing of spotlight"
  sudo mdutil -E /
fi;

rm -rf ~/.zshrc && ln -s $SRC_DIR/zsh/zshrc ~/.zshrc
rm -rf ~/.zshenv && ln -s $SRC_DIR/zsh/zshenv ~/.zshenv

mkdir -p ~/.config/yyper/
rm -rf ~/.config/hyper/.hyper.js && ln -s $SRC_DIR/hyper/hyper.js ~/.config/hyper/.hyper.js

rm -rf ~/.gitconfig && ln -s $SRC_DIR/git/gitconfig ~/.gitconfig

rm -rf ~/.tmux.conf && ln -s $SRC_DIR/tmux/tmux.conf ~/.tmux.conf

rm -rf ~/.config/nvim && ln -s $SRC_DIR/nvim ~/.config/nvim
rm -rf ~/.editorconfig && ln -s $SRC_DIR/nvim/editorconfig ~/.editorconfig
rm -rf ~/.config/colorls && ln -s $SRC_DIR/colorls ~/.config/colorls
rm -rf ~/.config/rofi && ln -s $SRC_DIR/rofi ~/.config/rofi
rm -rf ~/.config/bspwm && ln -s $SRC_DIR/bspwm ~/.config/bspwm
rm -rf ~/.config/sxhkd && ln -s $SRC_DIR/sxhkd ~/.config/sxhkd
rm -rf ~/.config/polybar && ln -s $SRC_DIR/polybar ~/.config/polybar
rm -rf ~/.config/terminator && ln -s $SRC_DIR/terminator ~/.config/terminator
rm -rf ~/.colors && ln -s $SRC_DIR/colors ~/.colors

os=$(uname -a | awk '{ print $4 }')

if [[ $os == "#1-Microsoft" ]]; then
  echo "Windows detected"
	if [[ -z $(which rg 2> /dev/null) ]]; then
		curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb && sudo dpkg -i ripgrep_11.0.2_amd64.deb
		rm -f ripgrep_11.0.2_amd64.deb
	fi;
  cp $SRC_DIR/hyper/hyper.js /mnt/c/Users/SPeter/AppData/Roaming/Hyper/.hyper.js
fi;

# source ~/.zshrc
