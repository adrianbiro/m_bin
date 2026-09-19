#!/usr/bin/env bash
mkdir -p $HOME/Library/LaunchAgents
cp launched.backup-to-nas.plist $HOME/Library/LaunchAgents/launched.backup-to-nas.plist
launchctl load -w $HOME/Library/LaunchAgents/launched.backup-to-nas.plist

#launchctl print gui/$(id -u)/launched.backup-to-nas
#launchctl kickstart gui/$(id -u)/launched.backup-to-nas. # start now
#launchctl kickstart -k gui/$(id -u)/launched.backup-to-nas. # restart