add_to_path() {
    local dir=$1
    if [ -d "$dir" ] && (( ${#path[(r)$dir]} == 0 )); then
        path+=("$dir")
    fi
}
. "$HOME/.cargo/env"
. "$HOME/.config/zsh/env_var.zsh"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/go/bin"
export PATH
