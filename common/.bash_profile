#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec sway --my-next-gpu-wont-be-nvidia
# [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec ~/source/c/sway/build/sway/sway --my-next-gpu-wont-be-nvidia

exec fish
