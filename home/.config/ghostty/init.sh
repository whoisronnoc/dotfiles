#!/bin/zsh

if [ "$(arch)" = "arm64" ]; then
  exec /opt/homebrew/bin/tuios
else
  exec ~/.config/ghostty/tmux.sh
fi
