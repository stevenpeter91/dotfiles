autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats ' %b'

source $ZSH/git_prompt.zsh

add-zsh-hook precmd vcs_info
add-zsh-hook precmd prompt_git

prompt_git() {
  vcs_info
  export RPROMPT="$(git_status)"
}

export PROMPT_SYMBOL="> "
export PROMPT="%{$fg_bold[yellow]%}% $PROMPT_SYMBOL%{$reset_color%}"
