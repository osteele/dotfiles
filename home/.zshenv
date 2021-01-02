# `.zshenv' is sourced on all invocations of the shell, unless the -f option is set.
# It should contain commands to set the command search path, plus other important environment variables.
# `.zshenv' should not contain commands that produce output or assume the shell is attached to a tty.
#
# Sourced before .zprofile and .zshrc
# echo .zshenv

# shellcheck source=/dev/null

[[ -e "${HOME}/.env.shared" ]] && source "${HOME}/.env.shared"

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

PATH_add /usr/local/opt/coreutils/libexec/gnubin
DOTFILES=.
if [[ -L ~/.zshenv ]]; then
  DOTFILES=$(dirname "$(readlink -nf ~/.zshenv)")/..
fi
PATH_add /usr/local/bin
[[ -v DOTFILES ]] && PATH_add "${DOTFILES}/bin"
PATH_add ~/bin

has brew && [[ -f $(brew --prefix nvm)/nvm.sh ]] && source "$(brew --prefix nvm)"/nvm.sh

# For use with `brew install curl-ca-bundle`
# export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

[[ -f ~/.secrets ]] && source ~/.secrets

# Python
PATH_add "${HOME}/.poetry/bin"
has pyenv && PATH_add "${HOME}/.pyenv/bin"
has pyenv && eval "$(pyenv init -)"

# echo .zshenv end
