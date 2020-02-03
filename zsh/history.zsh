if (( WSL )); then
  typeset -g HISTFILE=~/.zsh_history.${(%):-%m}-wsl-${HOME:t}
else
  if [ "${TMUX}" ] ; then
    typeset -g HISTFILE=~/.zsh_history.$(tmux display-message -p  -t$TMUX_PANE "#{window_name}")
  else
    typeset -g HISTFILE=~/.zsh_history.${(%):-%m}-linux-${HOME:t}
  fi
fi

typeset -gi HISTSIZE=1000000000
typeset -gi SAVEHIST=1000000000
typeset -gi HISTFILESIZE=1000000000

# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

#() {
#  emulate -L zsh
#  fc -RI $HISTFILE
#}
