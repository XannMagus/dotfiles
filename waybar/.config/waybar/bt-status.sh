#!/usr/bin/env bash

POWER_STATE=$(rfkill -J --output TYPE,SOFT | jq -rc '.rfkilldevices | map(select(.type == "bluetooth")) | if any(.soft == "unblocked") then "on" else "off" end')

if [ "$POWER_STATE" == "off" ]; then
    jq -njc --arg alt "off" --arg class "disconnected" --arg tooltip "right-click to activate" '$ARGS.named'
    exit 0
fi

MAPFILE=()
mapfile -t MAPFILE < <(bluetoothctl devices Connected | cut -d ' ' -f 3-)

if [ ${#MAPFILE[@]} -gt 0 ]; then
    DEVICES_LIST=$(printf "%s\\n" "${MAPFILE[@]}")
    printf -v tooltip_content "left-click to manage\rright-click to deactivate\rConnected to:\r%s" "$DEVICES_LIST"
    alt_state="connected"
    class_state="connected"
else
    printf -v tooltip_content "left-click to manage\rright-click to deactivate"
    alt_state="on"
    class_state="on"
fi

jq -njc \
    --arg alt "$alt_state" \
    --arg class "$class_state" \
    --arg tooltip "$tooltip_content" \
    '$ARGS.named'
