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

#!/bin/bash

# Function to check if the last command was successful
check_status() {
    if [ $? -eq 0 ]; then
        echo "$1 completed successfully."
    else
        echo "$1 failed to execute."
    fi
}

# Section 3: macOS Preferences

# 1. Clear all dock items
echo "Clearing dock items..."
defaults write com.apple.dock persistent-apps -array
killall Dock
check_status "Clearing dock items"

# 2. Automatically hide and show menu bar
echo "Setting menu bar to auto-hide..."
osascript -e 'tell application "System Events" to tell appearance preferences to set autohide menu bar to true'
check_status "Auto-hiding menu bar"

# 3. Enable dark mode
echo "Enabling dark mode..."
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
check_status "Enabling dark mode"

# 4. Disable Spotlight shortcut (Command + Space)
echo "Disabling Spotlight shortcut (Command + Space)..."
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:64:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:65:enabled false" ~/Library/Preferences/com.apple.symbolichotkeys.plist
killall SystemUIServer
check_status "Disabling Spotlight shortcut (Command + Space)"

# 5. Set trackpad speed to 7
echo "Setting trackpad speed to maximum..."
defaults write -g com.apple.trackpad.scaling -float 2.0 && killall SystemUIServer

check_status "Setting trackpad speed"

# 6. Enable Tap to Click
echo "Enabling Tap to Click..."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
check_status "Enabling Tap to Click"

# 7. Look up and data detectors - Tap with three fingers
echo "Setting Look Up to Tap with three fingers..."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 2
check_status "Setting Look Up with three fingers"

# 8. Enable three-finger drag for trackpad
echo "Enabling three-finger drag..."
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadDragging -bool true
check_status "Enabling three-finger drag"

# 9. Enable accessibility setting: Use trackpad for dragging, Dragging style: three-finger drag
echo "Enabling three-finger drag in Accessibility settings..."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DraggingStyle -string "threeFingerDrag"
check_status "Setting Accessibility three-finger drag"

# Section 4: Apply changes
echo "Applying all changes..."
killall Dock
killall SystemUIServer
check_status "Restarting Dock and SystemUIServer"

#Section 5: Dock settings
echo "Changing dock settings"
defaults write com.apple.dock magnification -bool true && \
defaults write com.apple.dock largesize -int 48 && \
defaults write com.apple.dock tilesize -int 36 && \
defaults write com.apple.dock autohide -bool true && \
killall Dock && killall SystemUIServer




echo "Setup complete!"

