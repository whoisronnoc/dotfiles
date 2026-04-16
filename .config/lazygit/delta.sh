#!/usr/bin/env bash
if [[ "$(uname)" == "Darwin" ]]; then
  THEME=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
  if [[ "$THEME" == "Dark" ]]; then
    delta --paging=never --dark "$@"
  else
    delta --paging=never --light "$@"
  fi
else
  delta --paging=never --dark "$@"
fi
