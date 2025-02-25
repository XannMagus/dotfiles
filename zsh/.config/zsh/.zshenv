add_to_path() {
    local dir=$1
    if [ -d "$dir" ] && (( ${#path[(r)$dir]} == 0 )); then
        path+=("$dir")
    fi
}
. "$HOME/.cargo/env"
. "$HOME/.config/zsh/env_var.zsh"

: ${XDG_STATE_HOME:=$HOME/.local/state}
: ${XDG_CONFIG_HOME:=$HOME/.config}
: ${XDG_CACHE_HOME:=$HOME/.cache}
: ${XDG_DATA_HOME:=$HOME/.local/share}

: ${ZDOTDIR:=$XDG_CONFIG_HOME/zsh}
: ${ZSH_PLUGINS_DIR:=$ZDOTDIR/plugins}

add_to_path "$HOME/.local/bin"
add_to_path "$HOME/go/bin"
export PATH XDG_STATE_HOME XDG_CONFIG_HOME XDG_DATA_HOME XDG_CACHE_HOME ZDOTDIR ZSH_PLUGINS_DIR
