# set editor as vim
export EDITOR='vi'

# oh-my-zsh install
export ZSH=/home/connor/.oh-my-zsh

# zsh theme
ZSH_THEME="robbyrussell"

# zsh plugins
plugins=(tmuxinator git brew command-not-found docker gem tmux systemd web-search zsh-autosuggestions zsh-syntax-highlighting zsh-completions history-substring-search)

# configure oh-my-zsh
source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit
