#!/usr/bin/env bash
mkdir -p $HOME/Library/LaunchAgents
cp launched.backup-to-nas.plist $HOME/Library/LaunchAgents/launched.backup-to-nas.plist
launchctl load -w $HOME/Library/LaunchAgents/launched.backup-to-nas.plist