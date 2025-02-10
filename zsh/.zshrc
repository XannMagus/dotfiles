source "$ZSH_PLUGINS_DIR/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
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
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/my_theme.omp.json)"
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

alias cd='z'
alias ls='eza -lah'
