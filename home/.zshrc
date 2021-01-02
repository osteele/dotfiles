# Read when interactive
# Sourced after.zshenv and .zprofile
# echo .zshrc

# Paths

[[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]] && source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

export EDITOR=code
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --line-numbers --quiet --force --style zenburn"

AUTO_CD=true
CDPATH=~/code:~/sites


#
# Zsh options
#

setopt AUTO_CD # `dir` instead of `cd dir`
setopt AUTO_NAME_DIRS # show named variables in path
setopt EXTENDED_GLOB # treat #, ~ and ^ characters as part of patterns for filename generation
setopt GLOB_COMPLETE # select match instead of completing to them all
setopt HIST_IGNORE_SPACE # `history` skips commands that begin with space
setopt NO_CLOBBER # `echo > file` requires `file` not exist
setopt NO_FLOW_CONTROL # disable ^S/^Q
setopt NUMERIC_GLOB_SORT # sort filenames numerically
setopt RC_QUOTES # 'isn''t this convenient'
setopt interactivecomments


#
# Environment managers
#

has rbenv && eval "$(rbenv init -)"
has direnv && eval "$(direnv hook zsh)"
has direnv && alias tmux='direnv exec / tmux'


#
# Directories
#

#alias -g dl=~/Downloads
#alias -g dt=~/Desktop
#alias -g code=~/code
#alias -g src=~/src


#
# Terminal Integration
#

if [[ "$TERM_PROGRAM" = Hyper ]]; then
#   prompt 'off'
#   PROMPT='$ '
  function precmd { echo -ne "\033]0;"$(echo ${PWD##*/})"\007" }
fi

if [[ ! -z "$ITERM_PROFILE" ]]; then
  PROMPT='⊳ '
  PROMPT2='⨽ '
fi

function iterm2_print_user_vars() {
  local git_branch_name=$(git symbolic-ref --short HEAD 2> /dev/null)
  [[ "$git_branch_name" == master ]] && git_branch_name=
  iterm2_set_user_var gitBranch "$git_branch_name"
  iterm2_set_user_var currentDir $(echo ${PWD##*/})
}


#
## Filters
#
alias -g G='|grep'
alias -g L='|less'
alias -g H='|head'
alias -g T='|tail'
alias -g S='|sort'
alias -g WL='|wc -l'
alias -g X0='|xargs -0'
alias -g X='|xargs'


#
# File handlers
#
alias -s txt=open
alias -s rtf=open
alias -s pdf=open
alias -s html=open
alias -s rb=ruby
alias -s js=subl


#
# Aliases
#
autoload -U zmv
alias mmv='noglob zmv -W'

[[ -v DOTFILES ]] && . "${DOTFILES}/shell/aliases"


#
# Completions
#
fpath=(~/.zsh-completions $fpath)

# added by travis gem
[ -f /Users/osteele/.travis/travis.sh ] && source /Users/osteele/.travis/travis.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export GPG_TTY=$(tty)

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/osteele/sites/cloudfront-auth/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/osteele/sites/cloudfront-auth/node_modules/tabtab/.completions/serverless.zsh

# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/osteele/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/osteele/

export PATH=/Users/osteele/.local/bin:$PATH

eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
