#!/bin/zsh

if [ "$(arch)" = "arm64" ]; then
  exec /opt/homebrew/bin/herdr
else
  exec ~/.config/ghostty/tmux.sh
fi
