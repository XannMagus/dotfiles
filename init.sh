#!/usr/bin/env sh

FILE='/etc/zsh/zshenv'
LINE='export ZDOTDIR="$HOME/.config/zsh"'

if [ ! -f "$FILE" ] || ! grep -q "$LINE" "$FILE"; then
    echo "$LINE" >> "$FILE"
fi
