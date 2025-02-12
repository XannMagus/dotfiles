#!/usr/bin/zsh

install_rust() {
    if command -v rustc &>/dev/null && command -v cargo &>/dev/null; then
        print -P "%F{green}\u2713%f Rust already installed"
        return 0
    fi

    print -P "%F{blue}\uf409%f Installing Rust toolchain..."

    # Create temporary file for error handling
    local tmpfile=$(mktemp)

    {
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > "$tmpfile" || {
            print -P "%F{red}\u2716 Failed to download rustup installer%f" >&2
            return 1
        }

        sh "$tmpfile" -y --no-modify-path || {
            print -P "%F{red}\u2716 Rust installation failed%f" >&2
            return 1
        }

        source "$HOME/.cargo/env"
    } always {
        rm -rf "$tmpfile"
    }

    if ! command -v cargo &>/dev/null; then
        print -P "%F{red}\u2716 Rust installation verification failed" >&2
        return 1
    fi

    print -P "%F{green}\u2713 Rust installed successfully%f"
}

script_dir=${0:A:h}

install_rust

[[ ! -d $ZDOTDIR ]] && mkdir -p $ZDOTDIR && print -P "%F{blue}\uea80 Created ZSH config directory%f"

[[ ! -f $ZDOTDIR/env_var.zsh ]] && cp $script_dir/env_var.zsh $ZDOTDIR/ && print -P "%F{yellow}\uf071%f Copied the default%F{red}(purposefully broken)%f env_var config file.\nYou HAVE to update it with the correct values"
