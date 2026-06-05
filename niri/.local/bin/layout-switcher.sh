#!/usr/bin/env bash
CHOICE=$(echo -e "h\nw" | fuzzel \
    --dmenu \
    --index \
    --auto-select \
    --hide-prompt \
    --namespace=invis \
    --config=/home/ahmed/.config/fuzzel/invisible.ini
)

case "$CHOICE" in
    0) ln -sf "$HOME/.config/niri/outputs_home.kdl" "$HOME/.config/niri/outputs.kdl"
    ;;
    1) ln -sf "$HOME/.config/niri/outputs_work.kdl" "$HOME/.config/niri/outputs.kdl"
    ;;
    *) echo $CHOICE
    ;;
esac

