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
  local projDir=$(pro search $1)
  cd ${projDir}
}

# __loopback-oracle-installer__:  Tue Dec 10 07:54:18 EST 2013
# export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/usr/local/lib/node_modules/loopback-connector-oracle/node_modules/instantclient"

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#if [ -e /Users/osteele/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/osteele/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
