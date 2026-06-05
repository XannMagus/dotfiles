#!/usr/bin/env bash
CHOICE=$(echo -e "p\nn\nb\nw\nh\nr" | fuzzel \
    --dmenu \
    --index \
    --auto-select \
    --hide-prompt \
    --namespace=invis \
    --config=/home/ahmed/.config/fuzzel/invisible.ini
)

case "$CHOICE" in
    0) playerctl play-pause
    ;;
    1) playerctl next
    ;;
    2) playerctl previous
    ;;
    3) ~/.local/bin/wallpaper-menu.sh
    ;;
    4) killall -s SIGUSR1 waybar
    ;;
    5) killall -s SIGUSR2 waybar
    ;;
    *) echo $CHOICE
    ;;
esac

