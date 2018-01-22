#! /bin/bash

###############################################################################
# House Keeping
###############################################################################

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


###############################################################################
# Bash Setup
###############################################################################

# source PATH
if [ -e "${HOME}/.terminalrc/PATH" ] ; then
    source "${HOME}/.terminalrc/PATH" 
 fi

# source alias configuration
if [ -e "${HOME}/.terminalrc/aliases" ] ; then
    source "${HOME}/.terminalrc/aliases"
fi

# Echo whatis for random function
echo "Did you know that:"; whatis "$(find /bin | shuf -n 1)"

# source autojump
if [ -e /usr/share/autojump/autojump.sh ] ; then
    source /usr/share/autojump/autojump.sh
fi

###############################################################################
# Autocompleting
###############################################################################

# `Bind` all the stuff that would go into ~/.inputrc

# TAB once for autocomplete (instead of twice)
bind 'set show-all-if-unmodified on'

# Enable arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Case insensitive
bind 'set completion-ignore-case on'

# Show all possible options
bind 'set show-all-if-ambiguous on'

# Display only unresolved characters
bind 'set completion-prefix-display-length 2'

# Make underscores and hyphens interchangeable
# Now you can use hyphens exclusively
bind 'set completion-map-case on'

# Git Autocomplete
source ~/.terminalrc/git-completion.bash

# Git Prompt
source ~/.terminalrc/git-prompt.sh

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Use case-insensitive filename globbing
shopt -s nocaseglob

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

###############################################################################
# Prompt
###############################################################################

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

# Separate branch name from hints by a pipe.
export GIT_PS1_STATESEPARATOR="|"

# show `*` for unstaged changes and `+` for staged changes.
export GIT_PS1_SHOWDIRTYSTATE=1

# show `$` for stashed changes.
export GIT_PS1_SHOWSTASHSTATE=1

# show `%` for untracked changes.
export GIT_PS1_SHOWUNTRACKEDFILES=1

# Color hints based on `git status -sb.
export GIT_PS1_SHOWCOLORHINTS=1

# Do not show status in untracked directories.
export GIT_PS1_HIDE_IF_PWD_IGNORED=1

# Show status of detached heads relative to branch.
export GIT_PS1_DESCRIBE_STYLE="branch"

# Git Prompt
if [ "$color_prompt" = yes ]; then
    GREEN='\[\e[01;32m\]'
    BLUE='\[\e[01;34m\]'
    RESET='\[\e[00m\]'
    PROMPT_COMMAND='__git_ps1 "${debian_chroot:+($debian_chroot) }$GREEN\u@\h$RESET $BLUE\w$RESET" "\n\$ "'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w $(__git_ps1)\n\$ '
fi

###############################################################################
# History
###############################################################################

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


###############################################################################
# More House Keeping
###############################################################################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Some people use a different file for aliases
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

# Some people use a different file for functions
if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi

###############################################################################
# Load Local Config
###############################################################################

# source non-generic configuration
if [ -e "${HOME}/.terminalrc/local" ] ; then
    source "${HOME}/.terminalrc/local"
fi
