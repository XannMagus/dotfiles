if ( command -v lsb_release &>/dev/null && [[ "$(lsb_release -si)" == "Ubuntu" ]] ) || \
    ( [[ -f /etc/os-release ]] && grep -q '^ID=ubuntu' /etc/os-release ); then
    skip_global_compinit=1
fi
# The following lines were added by compinstall
# 
# zstyle ':completion:*' completer _expand _complete _ignored _approximate
# zstyle ':completion:*' completions 1
# zstyle ':completion:*' glob 1
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'
# zstyle ':completion:*' max-errors 5
# zstyle ':completion:*' substitute 1
# zstyle ':completion:*' verbose true
# zstyle :compinstall filename '/home/xann/.zshrc'
# 
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/oh-my-posh/my_theme.omp.json)"
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ZSH_AUTOSUGGEST_STRATEGY=(completion history)

source "$ZSH_PLUGINS_DIR/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$ZSH_PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

alias cd='z'
alias ls='eza -lah'
