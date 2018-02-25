#! /bin/env zsh
# source PATH
if [ -e "${HOME}/.terminalrc/PATH" ] ; then
    source "${HOME}/.terminalrc/PATH" 
 fi

# source alias configuration
if [ -e "${HOME}/.terminalrc/aliases" ] ; then
    source "${HOME}/.terminalrc/aliases"
fi

# source non-generic configuration
if [ -e "${HOME}/.terminalrc/local" ] ; then
    source "${HOME}/.terminalrc/local"
fi

alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'

# I recommend using oh-my-zsh and using the plugins below.

# plugins=(autojump cabal command-not-found common-aliases compleat gitfast \
    # dirhistory django pip pylint vagrant cp colorize colored-man-pages)

# Also, the spaceship theme is awesome!

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end
