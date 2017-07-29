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

# source non-generic configuration
if [ -e "${HOME}/.terminalrc/local.sh" ] ; then
    source "${HOME}/.terminalrc/local.sh"
fi

# Echo whatis for random function
echo "Did you know that:"; whatis "$(find /bin | shuf -n 1)"

# source autojump
if [ -e /usr/share/autojump/autojump.sh ] ; then
    source /usr/share/autojump/autojump.sh
fi

###############################################################################
# .inputrc
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

###############################################################################
# Globs
###############################################################################

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

###############################################################################
# Helpful Bash Functions
###############################################################################

# Colorized Man Pages
man() {
    env \
        LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
        LESS_TERMCAP_md="$(printf "\e[1;31m")" \
        LESS_TERMCAP_me="$(printf "\e[0m")" \
        LESS_TERMCAP_se="$(printf "\e[0m")" \
        LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
        LESS_TERMCAP_ue="$(printf "\e[0m")" \
        LESS_TERMCAP_us="$(printf "\e[1;32m")" \
            man "$@"
}

# `cd --` to show all directories on the stack
# `cd -#` to jump to that directory
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain

cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then

    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi


  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"


  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)


  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null


  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=$((cnt-1))
    fi
  done

  return 0
}

alias cd=cd_func

# Alias various `open` commands as `o`
if  [[ "$OSTYPE" == "darwin"* ]]; then
    alias o='open'
elif  [[ "$OSTYPE" == "cygwin" ]]; then
    alias o='cygstart'
elif  [[ "$OSTYPE" == "msys" ]]; then
    alias o='explorer.exe'  # hoping this works
else
    alias o='xdg-open'
fi

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
# Improve Builtin Commands
###############################################################################

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Git Autocomplete
source ~/.terminalrc/git-completion.bash

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
