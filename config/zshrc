#set editor as vim
export EDITOR='vim'

### aliases ###
# vim
alias vi=vim
alias v=vi

# misc
alias x=exit
alias c=clear

# git
alias gsub='git submodule'
alias gsa='gsub add'

# geeknote
alias evernote=geeknote
alias note=evernote
alias n=note

# fuck
eval "$(thefuck --alias)"
alias f=fuck

# clipboard
alias clip='xclip -se c'
alias paste='clip -o'

### ANTIGEN ###
source $HOME/.antigen/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  # Bundles from the default repo (robbyrussell's oh-my-zsh).
  tmux
  common-aliases
  debian
  sudo
  systemd
  tmuxinator
  git
  brew
  command-not-found
  docker
  npm
  gem

  ruby
  rvm
  systemd
  web-search
  bundler
  jsontools
  history-substring-search

  # other bundles
  zsh-users/zsh-completions
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
EOBUNDLES
# Tell antigen that you're done.
antigen apply

PROMPT='%b%f%~ %B%(?:%F{green}:%F{red})%(!.#.|)%f%b '
RPROMPT='%F{yellow}$(rvm-prompt)%f$(git-prompt --zsh -l)'
