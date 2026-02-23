#!/bin/bash

# Get the current pomodoro status
status=$(pomodoro --directory "$HOME/repos/visions/misc/pomodoro" status -f '%r')

# If there's no output or remaining time, pomodoro isn't running
if [[ -z "$status" ]]; then
    exit 0
fi

# Check if remaining time is 0:00 or close to it (finished)
if [[ "$status" == "0:00" ]]; then
    # Show task name, tag, and tomato when finished
    pomodoro --directory "$HOME/repos/visions/misc/pomodoro" status -f '%d [%t] 🍅'
else
    # Show normal format with remaining time
    pomodoro --directory "$HOME/repos/visions/misc/pomodoro" status -f '%d [%t] %r⏱ '
fi
