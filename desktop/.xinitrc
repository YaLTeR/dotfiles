#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

launch-redshift &
# xinput set-prop "HUION 420 Pen" --type=float "Coordinate Transformation Matrix" 0.5333333333 0 0 0 1 0 0 0 1 &
# xinput set-button-map "HUION 420 Pen" 1 0 0 &
xinput set-button-map "UGTABLET TABLET G3 4x3 Pen Pen (0)" 1 0 0 &
setxkbmap -layout us,ru -option grp:alt_shift_toggle -option compose:ralt &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

numlockx on &
# rescuetime &
nm-applet &

steam &
telegram &
# signal &
fractal &
discord &
firefox &
alacritty -t IRC -e tmux new -A -s irc irssi &

# Fix VSync.
export __GL_SYNC_TO_VBLANK=1
export __GL_SYNC_DISPLAY_DEVICE=DP-0
export VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE=DP-0

exec awesome
# exec awesome -a
