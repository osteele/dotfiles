# shellcheck shell=bash source=/dev/null

export NODE_PATH=/usr/local/lib/node_modules

# if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
#   source ~/.gnupg/.gpg-agent-info
#   export GPG_AGENT_INFO
# else
#   eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
# fi

export PATH="$HOME/.local/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND="${PROMPT_TITLE}; ${PROMPT_COMMAND}"

export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:~/.platformio/penv/bin
