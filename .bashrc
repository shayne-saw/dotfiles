#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Dynamic prompt symbol: $ for user, # for root
PROMPT_SYMBOL='$(if [[ $EUID == 0 ]]; then echo "#"; else echo "$"; fi)'

# Colors
BLACK="\[\033[30m\]"
RED="\[\033[31m\]"
GREEN="\[\033[32m\]"
YELLOW="\[\033[33m\]"
BLUE="\[\033[34m\]"
MAGENTA="\[\033[35m\]"
CYAN="\[\033[36m\]"
WHITE="\[\033[37m\]"
BG_BLACK="\[\033[40m\]"
BG_RED="\[\033[41m\]"
BG_GREEN="\[\033[42m\]"
BG_YELLOW="\[\033[43m\]"
BG_BLUE="\[\033[44m\]"
BG_MAGENTA="\[\033[45m\]"
BG_CYAN="\[\033[46m\]"
BG_WHITE="\[\033[47m\]"
RESET="\[\033[0m\]"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

parse_git_branch() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
      echo "(${branch})"
    fi
  else
    echo "n/a"
  fi
}

C1="${BLACK}${BG_BLUE}"
C2="${BLUE}${BG_GREEN}"
C3="${BLACK}${BG_GREEN}"
C4="${GREEN}${BG_RED}"
C5="${BLACK}${BG_RED}"
C6="${RED}${BG_WHITE}"
C7="${BLACK}"

# Powerline-style PS1
PS1="${C1}  \u@\h ${C2}${C3}   \w ${C4}${C5}  \$(parse_git_branch) ${C6}${C7} ${PROMPT_SYMBOL} ${RESET} "

# Only run fastfetch in interactive shells
if [[ $- == *i* ]]; then
  fastfetch
fi
