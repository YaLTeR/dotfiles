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
export PATH="$HOME/.local/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/default
export FZF_DEFAULT_COMMAND="rg --hidden --files -g '!.git'"

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Set the Rust path.
export RUST_SRC_PATH=~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

# Set the Base16 theme, but only if it hasn't been already set.
if [ -z "$BASE16_THEME" ]; then
	export BASE16_THEME=ocean
fi

# Better font rendering in Java.
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

# Fix Java applications rendering.
export _JAVA_AWT_WM_NONREPARENTING=1

# Neovim-gtk settings.
export NVIM_GTK_DOUBLE_BUFFER=1
export NVIM_GTK_NO_HEADERBAR=1
export NVIM_GTK_PREFER_DARK_THEME=1

export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

export MOZ_ENABLE_WAYLAND=1

# Fix redshift on AMDGPU
# export WLR_DRM_NO_ATOMIC=1
# export WLR_DRM_NO_ATOMIC_GAMMA=1

# added by travis gem
[ -f /home/yalter/.travis/travis.sh ] && source /home/yalter/.travis/travis.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# If we're not going to start a graphical environment, exec fish.
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] || exec fish
