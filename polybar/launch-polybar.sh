#!/bin/sh

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar-top.log /tmp/polybar-bottom.log
polybar dwm-top 2>&1 | tee -a /tmp/polybar-top.log & disown
sleep 5
polybar dwm-bottom 2>&1 | tee -a /tmp/polybar-bottom.log & disown

echo "Bars launched..."
