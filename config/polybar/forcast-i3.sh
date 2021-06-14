#!/bin/bash

alacritty --dimensions 125 42 -e bash -c 'curl wttr.in/22.54,114.06; \
echo -n -e "\n\e[1;33mPress q to exit..\e[0m"; while true; do read -N 1 input; if [[ $input = "q" ]] || [[ $input = "Q" ]]; then break; fi; done' &
pid="$!"

# Wait for the window to open and grab its window ID
winid=''
while : ; do
    winid="`wmctrl -lp | awk -vpid=$pid '$3==pid {print $1; exit}'`"
    [[ -z "${winid}" ]] || break
done

# Focus the window we found
wmctrl -ia "${winid}"

# Make it float
i3-msg floating enable > /dev/null;

# Move it to the center for good measure
i3-msg move position center > /dev/null;

# Wait for the application to quit
20 wait "${pid}"; &
