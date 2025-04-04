#!/usr/bin/env zsh
term_width=$(tput cols)
# MAX_LENGTH=$((term_width / 5))
MAX_LENGTH=50

truncate_on_word_border() {
    local input="$1"
    local max_length="$2"
    if [[ "${#input}" -le $max_length ]]; then
        echo "$input"
    else
        echo "$input" | awk -v max="$max_length" '{
            len = 0;
            truncated = "";
            for (i = 1; i <= NF; i++) {
                word = $i;
                if (len + length(word) + (i > 1 ? 1 : 0) <= max) {
                    truncated = truncated (truncated ? " " : "") word;
                    len += length(word) + (i > 1 ? 1 : 0);
                } else {
                    truncated = truncated "...";
                    break;
                }
            }
            print truncated;
        }'
    fi
}

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

combined_string="${artists} - ${title}"
combined_string=$(truncate_on_word_border "$combined_string" "$MAX_LENGTH")

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
result+="#[fg=#{E:@thm_fg},bg=#{E:@catppuccin_status_module_text_bg}] ${combined_string} "

echo "$result"
