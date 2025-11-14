#!/opt/homebrew/bin/zsh
#/usr/bin/login -flp connor.temple /bin/bash --noprofile --norc -c exec -l ~/.config/ghostty/tmux.sh

eval "$(/opt/homebrew/bin/brew shellenv)"

SESSION_NAME="ghostty"

echo $PATH
echo $(which tmux)

# Check if the session already exists
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? -eq 0 ]; then
  # If the session exists, reattach to it
  tmux attach-session -t $SESSION_NAME
else
  # If the session doesn't exist, start a new one
  tmux new-session -s $SESSION_NAME -d
  tmux attach-session -t $SESSION_NAME
fi
