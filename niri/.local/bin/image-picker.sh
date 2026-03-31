#!/usr/bin/env bash
WDIR="$HOME/Pictures/Wallpapers"
TMP_CHOICE=$(mktemp)

YAZI_CONFIG_HOME=~/.config/yazi-image-picker yazi --chooser-file="$TMP_CHOICE" "$WDIR"

if [[ -s "$TMP_CHOICE" ]]; then
    selection=$(cat "$TMP_CHOICE")
    echo "$selection"
    ~/.local/bin/change-wallpaper.sh "$selection"
fi

rm "$TMP_CHOICE"
