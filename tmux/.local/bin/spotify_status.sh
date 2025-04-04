#!/usr/bin/env zsh

json=$(spotify_player get key playback)

if [[ "$json" == "null" || -z "$json" ]]; then
    echo ""
    exit 0
fi

is_playing=$(echo "$json" | jq -r '.is_playing')
artists=$(echo "$json" | jq -r '.item.artists | map(.name) | join(", ")')
title=$(echo "$json" | jq -r '.item.name')

artists=${artists:-"Unknown Artist"}
title=${title:-"Unknown Title"}

if [[ "$is_playing" == "true" ]]; then
    icon="\u266b"
    color="thm_green"
else
    # icon="\u23f8"
    icon="\u2016"
    color="thm_peach"
fi

result="#[fg=#{E:@$color}]#{?#{==:#{@catppuccin_status_connect_separator},yes},,#[bg=default]}#{@catppuccin_status_left_separator}"
result+="#[fg=#{E:@thm_crust},bg=#{E:@$color}]${icon} "
result+="#{E:@catppuccin_status_middle_separator}"
result+="#[fg=#{E:@thm_fg},bg=#{E:@catppuccin_status_module_text_bg}] ${artists} - ${title} "

echo "$result"
