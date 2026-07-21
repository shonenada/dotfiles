#!/bin/sh

set -eu

if [ "$(uname -s)" != "Darwin" ]; then
	printf '%s\n' 'keyboard-shortcuts.sh is only supported on macOS.' >&2
	exit 1
fi

# AppleSymbolicHotKeys IDs:
#   60 - Select the previous input source
#   64 - Show Spotlight search
# Modifier masks:
#   1048576 - Command
#    262144 - Control
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '{
    enabled = 1;
    value = {
        parameters = (32, 49, 1048576);
        type = standard;
    };
}'

defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '{
    enabled = 1;
    value = {
        parameters = (32, 49, 262144);
        type = standard;
    };
}'

# Restarting SystemUIServer makes the new shortcuts available without a reboot.
killall SystemUIServer >/dev/null 2>&1 || true

printf '%s\n' 'Keyboard shortcuts set: input source = Command-Space, Spotlight = Control-Space.'
