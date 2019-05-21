#!/bin/bash

# Disable DSstores on Network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Restarts finder
killall Finder
exit 0
