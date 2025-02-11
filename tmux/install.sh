#!/usr/bin/env zsh

plugins_dir="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins"
catppuccin_dir="$plugins_dir/catppuccin-tmux"

if [[ ! -d "$plugins_dir/tpm" ]]; then
    print -P "%F{blue}\uf017%f Cloning TPM"
    if ! git clone -q --depth 1 https://github.com/tmux-plugins/tpm "$plugins_dir/tpm"; then
        print -P "%F{red}\u2716%f Failed to clone repository" >&2
        exit 1
    fi
    print -P "%F{green}\u2713%f Tmux Plugin Manager installed"
else
    print -P "%F{green}\u2713%f TPM already installed"
fi

if [[ -d "$catppuccin_dir" ]]; then
    print -P "%F{green}\u2713 %fCatppuccin plugin already installed"
    exit 0
fi
print -P "%F{blue}\uf017%f Creating tmux plugins directory"
mkdir -p "$plugins_dir" || {
    print -P "%F{red}\u2716%f Failed to create plugins directory" >&2
    exit 1
}

print -P "%F{blue}\uf017%f Cloning Catppuccin tmux plugin%f"
if ! git clone -q -c advice.detachedHead=false -b v2.1.2 --depth 1 https://github.com/catppuccin/tmux.git "$catppuccin_dir"; then
    print -P "%F{red}\u2716%f Failed to clone repository" >&2
    exit 1
fi

print -P "%F{green}\u2713%f Catppuccin plugin installed"
