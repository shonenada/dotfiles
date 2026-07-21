#!/bin/sh

set -eu

if [ "$(uname -s)" != "Darwin" ]; then
	printf '%s\n' 'caps-lock-to-control.sh is only supported on macOS.' >&2
	exit 1
fi

# Match the modifier mapping used by the current system. 0x700000039 is
# Caps Lock and 0x7000000e4 is Right Control in the USB HID usage table.
caps_lock=30064771129
control=30064771300

# Persist the mapping in the per-Mac preferences scope used by System Settings.
defaults -currentHost write NSGlobalDomain com.apple.keyboard.modifiermapping.0-0-0 -array \
	"{ HIDKeyboardModifierMappingSrc = $caps_lock; HIDKeyboardModifierMappingDst = $control; }"

# Apply it immediately for the current login session as well.
hidutil property --set \
	"{\"UserKeyMapping\":[{\"HIDKeyboardModifierMappingSrc\":$caps_lock,\"HIDKeyboardModifierMappingDst\":$control}]}" \
	>/dev/null

printf '%s\n' 'Caps Lock mapped to Control.'
