function bindkey() {}
jit-source ~/dotfiles/zsh/fzf/shell/completion.zsh
jit-source ~/dotfiles/zsh/fzf/shell/key-bindings.zsh
unfunction bindkey

bindkey '\t'      expand-or-complete-with-dots        # tab        completion with '...'
bindkey '\e[1;3B' fzf-cd-widget                       # alt+down   fzf cd
bindkey '^T'      fzf-completion                      # ctrl+t     fzf completion
bindkey '^R'      fzf-history-widget-unique           # ctrl+r     fzf history

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

