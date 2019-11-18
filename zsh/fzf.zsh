# Setup fzf
# ---------
if [[ ! "$PATH" == */home/speter/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/speter/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/speter/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/speter/.fzf/shell/key-bindings.zsh"
