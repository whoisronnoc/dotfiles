# cSpell:disable
export EDITOR='nvim'
export XDG_CONFIG_HOME="$HOME/.config"
export TERM=xterm-256color

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  export PATH="$HOME/bin:$PATH"
fi

# universe ( includes all our shared scripts )
if [ -d "$HOME/.universe/bin" ]; then
  export PATH="$PATH:$HOME/.universe/bin"
fi

if [[ $(uname -m) == 'arm64' ]]; then
  export BREW_PATH="/opt/homebrew/bin/brew"
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  export BREW_PATH="/usr/local/bin/brew"
  export HOMEBREW_PREFIX="/usr/local"
fi

if [ -d "/usr/local/bin" ] ; then
  export PATH=/usr/local/bin:$PATH
fi

# jenv
if [ -d "$HOME/.jenv" ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
fi

# go
if [ -d "$HOME/go" ] && command -v go &> /dev/null; then
  export GOPATH="$HOME/go"
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

# flutter
if [ -d "$HOME/dev/flutter/flutter/bin" ]; then
  export PATH=$HOME/dev/flutter/flutter/bin:$PATH
fi

# deno
if [ -d "$HOME/.deno" ]; then
  . "$HOME/.deno/env"
fi

if [ -d "/Applications/Docker.app/Contents/Resources/bin" ]; then
  export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
fi

# NVM initialization
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
fi

# pnpm
if [ -d "$HOME/Library/pnpm" ]; then
  export PNPM_HOME="$HOME/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi

# Enable colored output for ls
export CLICOLOR=1 # MacOS
# For Linux or MacOS with brew install coreutils
if which gdircolors &>/dev/null
then
  # alias ls='ls --color=auto --classify'
  eval $(gdircolors)
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

export NX_TUI=false
