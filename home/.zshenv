# `.zshenv' is sourced on all invocations of the shell, unless the -f option is set.
# It should contain commands to set the command search path, plus other important environment variables.
# `.zshenv' should not contain commands that produce output or assume the shell is attached to a tty.

# TODO remove
export PATH=/usr/local/opt/coreutils/libexec/gnubin/:$PATH
if [[ -L ~/.zshenv ]]; then
  DOTFILES=$(dirname "$(readlink -nf ~/.zshenv)")/..
fi

# from direnv stdlib
has() {
  type "$1" &>/dev/null
}

has brew && [[ -f $(brew --prefix nvm)/nvm.sh ]] && source $(brew --prefix nvm)/nvm.sh

MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
MANPATH=/usr/local/share/man:$MANPATH

# For use with `brew install curl-ca-bundle`
# export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

if [[ -f ~/.secrets ]]; then
  source ~/.secrets
fi

# pyenv
has pyenv && PATH="$HOME/.pyenv/bin:$PATH"
has pyenv && eval "$(pyenv init -)"

source ~/.env.shared

