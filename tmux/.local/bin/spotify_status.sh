#!/usr/bin/env zsh
term_width=$(tput cols)
# MAX_LENGTH=$((term_width / 5))
MAX_LENGTH=50

truncate_balanced() {
    local artist="$1"
    local title="$2"
    local max_length="$3"
    local sep=" - "
    local sep_len=${#sep}

    local -a artist_words=("${(z)artist}")
    local -a title_words=("${(z)title}")

    local artist_result="${artist_words[1]}"
    local artist_len=${#artist_result}
    local title_result="${title_words[1]}"
    local title_len=${#title_result}

    local used_len=$((artist_len + title_len + sep_len))

    local i=2
    while (( used_len < max_length )); do
        local next_artist="${artist_words[i]}"
        local next_title="${title_words[i]}"

        local added=0

        if [[ -n "$next_artist" ]]; then
            local candidate_len=$((used_len + ${#next_artist} + 1)) # +1 for space
            if (( candidate_len <= max_length - 6 )); then
                artist_result+=" $next_artist"
                used_len=$candidate_len
                added=1
            fi
        fi

        if [[ -n "$next_title" ]]; then
            local candidate_len=$((used_len + ${#next_title} + 1)) # +1 for space
            if (( candidate_len <= max_length - 6 )); then
                title_result+=" $next_title"
                used_len=$candidate_len
                added=1
            fi
        fi

        (( added == 0 )) && break
        ((i++))
    done
    
    [[ $i -le ${#artist_words} ]] && artist_result+="..."
    [[ $i -le ${#title_words} ]] && title_result+="..."

    echo "$artist_result$sep$title_result"
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

combined_string=$(truncate_balanced "$artists" "$title" "$MAX_LENGTH")

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
