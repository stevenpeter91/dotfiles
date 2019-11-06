source $ZSH/git_prompt.zsh

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats ' %b'

export PROMPT="$(print $COLOR_YELLOW '>')$(print $COLOR_NONE ' ')"
