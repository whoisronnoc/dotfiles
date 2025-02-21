export EDITOR='nvim'

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
export PATH=/usr/local/bin:$PATH

# universe ( includes all our shared scripts )
export PATH="$PATH:$HOME/.universe/bin"

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# rvm
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# go
#export GOPATH="$HOME/go"
#export PATH="$PATH:$(go env GOPATH)/bin"

# flutter
export PATH=$HOME/dev/flutter/flutter/bin:$PATH

# NVM initialisation
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# deno
. "$HOME/.deno/env"

export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

