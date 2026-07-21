#!/bin/sh

set -eu

if [ "$(uname -s)" != "Darwin" ]; then
	printf '%s\n' 'homebrew.sh is only supported on macOS.' >&2
	exit 1
fi

if command -v brew >/dev/null 2>&1; then
	printf 'Homebrew is already installed at %s.\n' "$(command -v brew)"
	exit 0
fi

for brew_binary in /opt/homebrew/bin/brew /usr/local/bin/brew; do
	if [ -x "$brew_binary" ]; then
		printf 'Homebrew is already installed at %s (not currently on PATH).\n' "$brew_binary"
		exit 0
	fi
done

printf '%s\n' 'Installing Homebrew with the official installer...'
/bin/bash -c "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

for brew_binary in /opt/homebrew/bin/brew /usr/local/bin/brew; do
	if [ -x "$brew_binary" ]; then
		printf 'Homebrew installed at %s.\n' "$brew_binary"
		exit 0
	fi
done

printf '%s\n' 'The Homebrew installer finished, but the brew executable was not found.' >&2
exit 1
