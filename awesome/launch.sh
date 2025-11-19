#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run "dunst"
run "firefox"
#run "copyq"
# run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "nm-applet"
run "batsignal"
run "xsettingsd"
run "blueberry-tray"
# run "redshift"
# run "sunshine"

picom --experimental-backends --config ~/.config/picom/picom.conf --no-vsync

# killall -q polybar
# polybar left &
# polybar right &
# polybar middle &
# polybar tray &
# polybar xwindow &

pkill xss-lock
xset s 300
xss-lock --transfer-sleep-lock "$HOME/.config/scripts/xsslock-handler.sh" &

# Start xss-lock with our handler
# xss-lock -- ~/.local/bin/xss-lock-handler.sh &

# pkill xidlehook
# xidlehook --detect-sleep --not-when-audio --timer 10 'cool-retro-term --fullscreen -e sh ~/cmatrix.sh' '' --timer 10 'pkill cool-retro-term && systemctl suspend' ''
