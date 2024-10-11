#!/bin/bash

echo "Starting setup for your design environment..."

# Section 1: Install Homebrew if not installed
if ! command -v brew &> /dev/null
then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Section 2: Install applications via Homebrew
echo "Updating Homebrew..."
brew update

echo "Installing applications..."

# Installing applications via Homebrew Cask
brew install --cask amie
brew install --cask figma
brew install --cask framer
brew install --cask obsidian
brew install --cask arc
brew install --cask logi-options-plus
brew install --cask spotify
brew install --cask texts
brew install --cask raycast
brew install --cask discord
brew install --cask slack

echo "Applications installed successfully."


# Section 3: macOS Preferences

# 1. Clear all dock items
echo "Clearing dock items..."
defaults write com.apple.dock persistent-apps -array
killall Dock

# 2. Automatically hide and show menu bar
echo "Setting menu bar to auto-hide..."

# Enable auto-hide for the menu bar using AppleScript
osascript -e 'tell application "System Events" to tell appearance preferences to set autohide menu bar to true'

echo "Menu bar auto-hide set."


# 3. Enable dark mode
echo "Enabling dark mode..."
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'

# 4. Disable Spotlight shortcut (Command + Space)
echo "Disabling Spotlight shortcut (Command + Space)..."

# Disable Command + Space for Spotlight
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:64:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:65:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist

# Restart SystemUIServer to apply changes
killall SystemUIServer

echo "Spotlight shortcut disabled."

# 5. Set trackpad speed to 7
echo "Setting trackpad speed to maximum..."
defaults write -g com.apple.trackpad.scaling 3.0

# 6. Enable Tap to Click
echo "Enabling Tap to Click..."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# 7. Look up and data detectors - Tap with three fingers
echo "Setting Look Up to Tap with three fingers..."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 2

# 8. Enable three-finger drag for trackpad
echo "Enabling three-finger drag..."
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadDragging -bool true

# 9. Enable accessibility setting: Use trackpad for dragging, Dragging style: three-finger drag
echo "Enabling three-finger drag in Accessibility settings..."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DraggingStyle -string "threeFingerDrag"

# Section 4: Apply changes
echo "Applying all changes..."

# Restart Dock and other services to apply changes
killall Dock
killall SystemUIServer

echo "Setup complete!"
