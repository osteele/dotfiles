# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bash_profile.pre.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.pre.bash"
# shellcheck shell=bash source=/dev/null

. ~/.profile
. ~/.bashrc

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}

# pro cd function
pd() {
  local projDir
  projDir=$(pro search "$1")
  cd "${projDir}" || return $?
}

# __loopback-oracle-installer__:  Tue Dec 10 07:54:18 EST 2013
# export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/usr/local/lib/node_modules/loopback-connector-oracle/node_modules/instantclient"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#if [ -e /Users/osteele/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/osteele/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

. /usr/local/opt/asdf/asdf.sh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bash_profile.post.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.post.bash"
