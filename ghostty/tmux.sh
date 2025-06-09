#!/bin/bash

SESSION_NAME="ghostty"

# Check if the session already exists
/usr/local/bin/tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? -eq 0 ]; then
  # If the session exists, reattach to it
  /usr/local/bin/tmux attach-session -t $SESSION_NAME
else
  # If the session doesn't exist, start a new one
  /usr/local/bin/tmux new-session -s $SESSION_NAME -d
  /usr/local/bin/tmux attach-session -t $SESSION_NAME
fi
