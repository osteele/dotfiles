# shellcheck shell=bash source=/dev/null

mkdir -p ~/.logs
bash_profile_log=~/.logs/bash-profile.log
touch $bash_profile_log
echo "$(date +%T): .bashrc" >> $bash_profile_log

source ~/.env.shared

# Node
export NVM_DIR=~/.nvm

# added by travis gem
# [ -f /Users/osteele/.travis/travis.sh ] && source /Users/osteele/.travis/travis.sh

export PATH=/usr/local/bin:$PATH # brew
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=/usr/local/opt/go/libexec/bin:$PATH               # Go
export PATH=/usr/local/opt/ccache/libexec:$PATH               # ccache
hash yarn 2>/dev/null && export PATH=$(yarn global bin):$PATH # yarn
export PATH="$HOME/.rbenv/bin:$PATH"                          # rbenv

# autoenv
hash brew 2>/dev/null && [ -f "$(brew --prefix autoenv)"/activate.sh ] && source" $(brew --prefix autoenv)"/activate.sh
# [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
eval "$(thefuck --alias)"

if [[ -L ~/.bashrc ]]; then
  # DOTFILES=$(dirname "$(readlink -nf ~/.bashrc)")/..
  DOTFILES=$(dirname $(dirname "$(readlink -nf ~/.bashrc)"))
  . "${DOTFILES}/shell/aliases"
  export PATH="${DOTFILES}/bin":$PATH
fi

export PATH=~/bin:$PATH

export EDITOR=code

#
# Bash-it

# Path to the bash it configuration
export BASH_IT="/Users/osteele/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='clean'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
# export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=false
# export SCM_GIT_SHOW_MINIMAL_INFO=true
# export SCM_GIT_SHOW_DETAILS=false

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source $BASH_IT/bash_it.sh

function nonzero_return() {
  RETVAL=$?
  [ $RETVAL -ne 0 ] && echo "[*]"
}

function dirname_for_prompt() {
  [[ $PWD == "$HOME" ]] && echo '~' && return
  (
    echo "$PWD"
    echo \~/"$(realpath --relative-to="$HOME" "$PWD")"
    echo \~/code/"$(realpath --relative-to="$HOME/code" "$PWD")"
  ) | awk '{ print length, $0 }' | sort -n | head -1 | cut -d" " -f2-
}

export PS1='`nonzero_return``dirname_for_prompt`\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# iTerm integration breaks the prompt inside VSCode
[[ "$TERM_PROGRAM" == vscode ]] && unset PROMPT_COMMAND

#
# Environment managers
#

hash rbenv 2>/dev/null && eval "$(rbenv init -)"
hash direnv 2>/dev/null && eval "$(direnv hook bash)"

echo "$(date +%T): .bashrc end" >> $bash_profile_log
