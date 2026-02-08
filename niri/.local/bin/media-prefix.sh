#!/usr/bin/env bash
CHOICE=$(echo -e "p: Play\nn: Next\nb: Back" | fuzzel \
    --dmenu \
    --index \
    --auto-select \
    --hide-prompt \
    --config=/home/ahmed/.config/fuzzel/invisible.ini
)

case "$CHOICE" in
    0) playerctl play-pause
    ;;
    1) playerctl next
    ;;
    2) playerctl previous
    ;;
    *) echo $CHOICE
        ;;
esac

