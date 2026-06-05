#!/usr/bin/env bash
CHOICE=$(echo -e "d\nl" | fuzzel \
    --dmenu \
    --index \
    --auto-select \
    --hide-prompt \
    --namespace=invis \
    --config=/home/ahmed/.config/fuzzel/invisible.ini
)

case "$CHOICE" in
    0) ~/.local/bin/theme-switcher.sh dark
    ;;
    1) ~/.local/bin/theme-switcher.sh light
    ;;
    *) echo $CHOICE
    ;;
esac

