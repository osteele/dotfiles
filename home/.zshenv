# `.zshenv' is sourced on all invocations of the shell, unless the -f option is set.
# It should contain commands to set the command search path, plus other important environment variables.
# `.zshenv' should not contain commands that produce output or assume the shell is attached to a tty.
#
# Sourced before .zprofile and .zshrc
# echo .zshenv

#
# PATH
#

PATH_add() {
  PATH=$1:$PATH
  export PATH
}

# from direnv stdlib
has() {
  type "$1" &>/dev/null
}

# TODO: remove
PATH_add /usr/local/opt/coreutils/libexec/gnubin/
if [[ -L ~/.zshenv ]]; then
  DOTFILES=$(dirname "$(readlink -nf ~/.zshenv)")/..
fi

PATH_add /usr/local/bin
PATH_add /usr/local/opt/coreutils/libexec/gnubin
PATH_add /usr/local/opt/ccache/libexec
[[ -v DOTFILES ]] && PATH_add "${DOTFILES}/bin"
PATH_add ~/bin

has brew && [[ -f $(brew --prefix nvm)/nvm.sh ]] && source $(brew --prefix nvm)/nvm.sh

MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
MANPATH=/usr/local/share/man:$MANPATH

# For use with `brew install curl-ca-bundle`
# export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

[[ -f ~/.secrets ]] && source ~/.secrets

# Python
PATH_add $HOME/.poetry/bin
has pyenv && PATH_add $HOME/.pyenv/bin
has pyenv && eval "$(pyenv init -)"

test -e "${HOME}/.env.shared" && source "${HOME}/.env.shared"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# echo .zshenv end
