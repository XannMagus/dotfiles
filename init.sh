#!/usr/bin/env sh

if [ "$(id -u)" -ne 0 ]; then
    exec sudo "$0" "$@"
fi

FILE='/etc/zsh/zshenv'
LINE='export ZDOTDIR="$HOME/.config/zsh"'

if [ ! -f "$FILE" ] || ! grep -q "$LINE" "$FILE"; then
    echo "$LINE" >> "$FILE"
fi
