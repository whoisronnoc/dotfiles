source $HOME/.profile
#set editor as vim
export EDITOR='vim'

### aliases ###
# vim
alias vi=vim
alias v=vi

# misc
alias x=exit
alias c=clear

# swift aliases
# alias s=swift
# alias sc=swiftc

# git
# alias gsub='git submodule'
# alias gsa='gsub add'

# geeknote
# alias evernote=geeknote
# alias note=evernote
# alias n=note

# fuck
# eval "$(thefuck --alias)"
# alias f=fuck

# clipboard
# alias clip='xclip -se c'
# alias paste='clip -o'

# alias railserv='rails s -p 1024'

# override default plugin settings
# export ZSH_TMUX_AUTOSTART=true

### ANTIGEN ###
# _ANTIGEN_CACHE_ENABLED="false"
source $HOME/.antigen/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle BrandonRoehl/zsh-clean
# antigen theme BrandonRoehl/zsh-clean

# Bundles from the default repo (robbyrussell's oh-my-zsh).
# antigen bundle tmux
antigen bundle common-aliases
# antigen bundle debian
antigen bundle sudo
# antigen bundle systemd
# antigen bundle tmuxinator
antigen bundle git
antigen bundle brew
antigen bundle command-not-found
antigen bundle docker
# antigen bundle npm
# antigen bundle gem

# antigen bundle ruby
# antigen bundle rvm
# antigen bundle systemd
# antigen bundle web-search
# antigen bundle bundler
# antigen bundle jsontools
antigen bundle history-substring-search

# other bundles
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# antigen bundle	BrandonRoehl/zsh-clean

# antigen theme BrandonRoehl/zsh-clean

# Tell antigen that you're done.
antigen apply

# PROMPT='%b%f%~ %B%(?:%F{green}:%F{red})%(!.#.|)%f%b '
# RPROMPT='%f$(git-prompt --zsh -l)'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=203,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=84'
ZSH_HIGHLIGHT_STYLES[alias]=$ZSH_HIGHLIGHT_STYLES[command]
ZSH_HIGHLIGHT_STYLES[function]=$ZSH_HIGHLIGHT_STYLES[command]
ZSH_HIGHLIGHT_STYLES[builtin]='fg=177'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=177'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=99'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=50'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=45'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=$ZSH_HIGHLIGHT_STYLES[single-hyphen-option]
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=215'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=$ZSH_HIGHLIGHT_STYLES[single-quoted-argument]
ZSH_HIGHLIGHT_STYLES[assign]='fg=227'
ZSH_HIGHLIGHT_STYLES[redirection]=$ZSH_HIGHLIGHT_STYLES[assign]
ZSH_HIGHLIGHT_STYLES[comment]='fg=243'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=50'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=212'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=$ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/connor/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/connor/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/connor/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/connor/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

###-tns-completion-start-###
# if [ -f /Users/connor/.tnsrc ]; then 
#     source /Users/connor/.tnsrc 
# fi
###-tns-completion-end-###
#
#
# eval "$(pyenv init -)"
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"

# Load Angular CLI autocompletion.
# source <(ng completion script)

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

eval "$(zoxide init --cmd cd zsh)"

alias cat='bat'
alias ls='lsd'
