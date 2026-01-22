#!/usr/bin/env zsh
term_width=$(tput cols)
# MAX_LENGTH=$((term_width / 5))
MAX_LENGTH=50

truncate_simple() {
    local text="$1"
    local max_length="$2"

    if (( ${#text} <= max_length )); then
        echo "$text"
    else
        echo "${text:0:$((max_length - 3))}..."
    fi
}

truncate_balanced() {
    local artist="$1"
    local title="$2"
    local max_length="$3"

    if [[ -z "$artist" && -z "$title" ]]; then
        echo ""
        return
    elif [[ -z "$artist" ]]; then
        truncate_simple "$title" "$max_length"
        return
    elif [[ -z "$title" ]]; then
        truncate_simple "$artist" "$max_length"
        return
    fi

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

playback_status=$(playerctl status 2>/dev/null)

if [[ -z "$playback_status" ]]; then
    echo ""
    exit 0
fi

artists=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

artists=${artists:-""}
title=${title:-""}

combined_string=$(truncate_balanced "$artists" "$title" "$MAX_LENGTH")

if [[ -z "$combined_string" ]]; then
    echo ""
    exit 0
fi

case "$playback_status" in
    "Playing")
        icon="\u266b"
        color="thm_green"
        ;;
    "Paused")
        # icon="\u23f8"
        icon="\u2016"
        color="thm_peach"
        ;;
    "Stopped"|*)
        icon="\u25a0"
        color="thm_peach"
        ;;
esac

result="#[fg=#{E:@$color}]#{?#{==:#{@catppuccin_status_connect_separator},yes},,#[bg=default]}#{@catppuccin_status_left_separator}"
result+="#[fg=#{E:@thm_crust},bg=#{E:@$color}]${icon} "
result+="#{E:@catppuccin_status_middle_separator}"
result+="#[fg=#{E:@thm_fg},bg=#{E:@catppuccin_status_module_text_bg}] ${combined_string} "

echo "$result"
