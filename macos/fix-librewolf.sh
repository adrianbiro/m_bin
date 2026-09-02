#!/usr/bin/env bash
# fiw librewolf after brew install
xattr -dr com.apple.quarantine /Applications/LibreWolf.app
ln -s ~/Library/Application\ Support/Mozilla/NativeMessagingHosts ~/Library/Application\ Support/LibreWolf/NativeMessagingHosts
