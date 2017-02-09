#set editor as vim
export EDITOR='vim'

# universe
export PATH="$PATH:$HOME/.dot/universe/bin"

# linuxbrew
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

# aliases
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
alias note=geeknote
alias n=geeknote

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
# ZSH_THEME="robbyrussell"
# zsh plugins
plugins=(tmux common-aliases debian sudo systemd tmuxinator git brew command-not-found docker npm gem rails ruby rvm systemd web-search zsh-autosuggestions zsh-syntax-highlighting zsh-completions history-substring-search bundler jsontools)
# configure oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit
# custom zsh prompta
local ret_status="%(?:%{$fg_bold[green]%}|:%{$fg_bold[red]%}|)"
PROMPT='%{$fg_bold[red]%}%n%{$fg_bold[white]%}${ret_status}%{$reset_color%}%~%#% '
RPROMPT='%{$fg[yellow]%}$(rvm-prompt)%{$reset_color%} $(git-prompt --zsh)'
