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
export EDITOR=vim
export VISUAL=vim
export PATH=$PATH:$HOME/.cargo/bin

# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
# base16_ashes
