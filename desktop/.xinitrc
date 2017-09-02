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

redshift -l 55.6540919:37.4818654 &
numlockx &
xinput set-prop "HUION 420 Pen" --type=float "Coordinate Transformation Matrix" 0.5333333333 0 0 0 1 0 0 0 1 &
xinput set-button-map "HUION 420 Pen" 1 0 0 &
xinput set-button-map "UGTABLET TABLET G3 4x3 Pen Pen (0)" 1 0 0 &
setxkbmap -layout us,ru -option grp:alt_shift_toggle -option compose:ralt &

export SSH_ASKPASS=lxqt-openssh-askpass
ssh-add ~/.ssh/id_rsa_gh &

# sudo /usr/bin/mullvad &
rescuetime &
dropbox &
nm-applet &

export RUST_SRC_PATH=/home/yalter/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src

# Fix VSync.
export __GL_SYNC_TO_VBLANK=1
export __GL_SYNC_DISPLAY_DEVICE=DP-0
export VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE=DP-0

# Better font rendering in Java.
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

exec awesome
# exec awesome -a
