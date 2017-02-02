#set editor as vim
export EDITOR='vi'

#linuxbrew
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

#aliases
alias vi=vim
alias v=vi
alias x=exit
alias c=clear

alias gsub='git submodule'
alias gsubs='gsub status'
alias gsa='gsub add'

#thefuck
eval "$(thefuck --alias)"
alias f=fuck

#clipboard
alias clip='xclip -se c'
alias paste='clip -o'

#################
### OH-MY-ZSH ###
#################
# oh-my-zsh install
export ZSH=/home/connor/.oh-my-zsh
# zsh theme
ZSH_THEME="robbyrussell"
git config --global oh-my-zsh.hide-status 0
# zsh plugins
plugins=(tmux common-aliases debian sudo systemd tmuxinator git brew command-not-found docker npm gem rails ruby rvm systemd web-search zsh-autosuggestions zsh-syntax-highlighting zsh-completions history-substring-search bundler jsontools)
# configure oh-my-zsh
source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit
