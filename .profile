export EDITOR='nvim'

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
export PATH=/usr/local/bin:$PATH

# universe ( includes all our shared scripts )
export PATH="$PATH:$HOME/.universe/bin"

if [[ $(uname -m) == 'arm64' ]]; then
  export BREW_PATH="/opt/homebrew/bin/brew"
  export HOMEBREW_PREFIX="/opt/homebrew"
else
  export BREW_PATH="/usr/local/bin/brew"
  export HOMEBREW_PREFIX="/usr/local"
fi

# jenv
export PATH="$HOME/.jenv/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# go
#export GOPATH="$HOME/go"
#export PATH="$PATH:$(go env GOPATH)/bin"

# flutter
# export PATH=$HOME/dev/flutter/flutter/bin:$PATH

# deno
#. "$HOME/.deno/env"

export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# NVM initialisation
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Enable colored output for ls
export CLICOLOR=1 # MacOS
# For Linux or MacOS with brew install coreutils
if which gdircolors &>/dev/null
then
    # alias ls='ls --color=auto --classify'
    eval $(gdircolors)
fi
