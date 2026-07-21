#!/bin/sh

set -eu

if [ "$(uname -s)" != "Darwin" ]; then
	printf '%s\n' 'keyboard-repeat.sh is only supported on macOS.' >&2
	exit 1
fi

# These are the fastest values exposed by macOS System Settings.
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

printf '%s\n' 'Keyboard repeat rate set to fastest (KeyRepeat=2, InitialKeyRepeat=15).'
printf '%s\n' 'Log out and back in for every application to pick up the new rate.'
