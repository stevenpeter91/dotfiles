# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  prepend_path $HOME/.fzf/bin
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source ~/.fzf/shell/completion.zsh 2> /dev/null

# Key bindings
# ------------
source ~/.fzf/shell/key-bindings.zsh
