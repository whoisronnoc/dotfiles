#!/bin/zsh

if [ "$(arch)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  exec /opt/homebrew/bin/tuios
else
  exec ~/.config/ghostty/tmux.sh
fi
