#!/usr/bin/env bash

ln -sfr "$HOME/.config/waybar/${1:-dark}.css" "$HOME/.config/waybar/theme.css"
killall -s SIGUSR2 waybar
