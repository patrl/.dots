#! /usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch bar
echo "---" | tee -a /tmp/polybar.log
polybar bar >>/tmp/polybar.log 2>&1 &

echo "Bar launched..."
