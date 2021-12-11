# Executes commands at login pre-zshrc.

#
# Sourced after .zshenv, before .zprofile
# echo .zprofile

echo "$(date +%T): .zprofile" >> $zsh_profile_log

#
# Browser
#

[[ "$OSTYPE" == darwin* ]] && export BROWSER='open'

#
# Editors
#

# export EDITOR='nano'
# export VISUAL='nano'
# export PAGER='less'

#
# Language
#

[[ -z "$LANG" ]] && export LANG='en_US.UTF-8'

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

PATH_add /usr/local/opt/ccache/libexec
PATH_add /usr/local/opt/gnu-sed/libexec/gnubin

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

# PATH

# Go
# PATH_add /usr/local/opt/go/libexec/bin
export GOPATH=$HOME/go:$HOME/code/go
# export GOROOT=/usr/local/opt/go/libexec
PATH_add /usr/local/opt/go/libexec/bin
# export GOBIN=$GOPATH/bin
PATH_add $HOME/src/go/bin:$HOME/go/bin
# PATH_add $GOROOT/bin

# Haskell
PATH_add ~/.cabal/bin

# Node
# PATH_add /usr/local/share/npm/bin
# has yarn && PATH_add $(yarn global bin)

# Python
# added by Anaconda 2.0.1 installer
# PATH_add ~/anaconda/bin
# PATH_add ~/anaconda3/bin # conda

# Ruby
# PATH_add ~/.rvm/bin
PATH_add ~/.rbenv/bin
# PATH_add ./.gems/bin

# Rust
PATH_add ~/.cargo/bin

# Travis
# [[ -f ~/.travis/travis.sh ]] && source ~/.travis/travis.sh

export PATH=$PATH:~/.platformio/penv/bin

echo "$(date +%T): .zprofile end" >> $zsh_profile_log
