#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "`dircolors ~/.dircolors`"
alias ls='ls --color=auto'
alias l='ls -hl'
alias la='ls -hal'

PS1='[\u@\h \W]\$ '
export EDITOR=nvim
export VISUAL=nvim
export PATH=$PATH:$HOME/.cargo/bin
export JAVA_HOME=/usr/lib/jvm/default
export FZF_DEFAULT_COMMAND="rg --hidden --files -g '!.git'"

# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
# base16_ashes

# added by travis gem
[ -f /home/yalter/.travis/travis.sh ] && source /home/yalter/.travis/travis.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# If we're not going to start X, exec fish.
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] || exec fish
