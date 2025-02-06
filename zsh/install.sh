#!/usr/bin/zsh

SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$0";)";)

[ ! -d "$HOME/.config/zsh" ] && mkdir -p "$HOME/.config/zsh" && echo "Created ZSH config directory."

[ ! -f "$HOME/.config/zsh/env_var.zsh" ] && cp "$SCRIPT_DIR/env_var.zsh" "$HOME/.config/zsh/" && echo "Copied the default(purposefully broken) env_var config file."
