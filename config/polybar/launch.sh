#!/usr/bin/env bash

DOUBLE_MONITOR="true"

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

export PRIMARY_MONITOR=$(polybar --list-monitors | grep primary | sed -e 's/:.*$//g')

if [[ "$DOUBLE_MONITOR" == "true" ]];then
  export SECONDARY_MONITOR=$(polybar --list-monitors | grep -v  primary | tail -1 | sed -e 's/:.*$//g')
fi

echo "--------" | tee -a /tmp/polybar.primary.log
polybar primary >>/tmp/polybar.primary.log 2>&1 &

if [[ "$DOUBLE_MONITOR" == "true" ]];then
    echo "--------" | tee -a /tmp/polybar.secondary.log
    echo "SECONDARY_MONITOR: ${SECONDARY_MONITOR}" | tee -a /tmp/polybar.secondary.log
    if [[ -n ${SECONDARY_MONITOR} ]]; then
      polybar secondary >>/tmp/polybar.secondary.log 2>&1 &
    fi
fi

echo "Polybar launched..."
