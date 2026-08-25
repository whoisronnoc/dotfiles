#!/bin/zsh

if [ "$(arch)" = "arm64" ]; then
  exec ~/.config/ghostty/tmux-arm64.sh
else
  exec ~/.config/ghostty/tmux.sh
fi
