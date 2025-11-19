#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# polybar left 2>&1 | tee -a /tmp/polybar1.log & disown
# polybar center 2>&1 | tee -a /tmp/polybar2.log & disown
# polybar right 2>&1 | tee -a /tmp/polybar2.log & disown

polybar i3_menu 2>&1 | tee -a /tmp/i3_menu.log & disown
polybar i3_workspaces 2>&1 | tee -a /tmp/i3_workspaces.log & disown
polybar i3_center_clock 2>&1 | tee -a /tmp/i3_center_xwindow_clock.log & disown
polybar i3_sysdetails 2>&1 | tee -a /tmp/i3_sysdetails.log & disown
polybar i3_cava 2>&1 | tee -a /tmp/i3_powermenu_bar.log & disown
polybar i3_powermenu_bar 2>&1 | tee -a /tmp/i3_cava.log & disown


echo "Bars launched..."
