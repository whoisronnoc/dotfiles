# zmodload zsh/zprof 
# homebrew
if [[ -f $BREW_PATH ]]; then
  eval "$($BREW_PATH shellenv)"
fi

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# custom prompt
eval "$(starship init zsh)"

# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab
zinit light atuinsh/atuin

# zsh snippets
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::common-aliases
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::docker
# zinit snippet OMZP::docker-compose
# zinit snippet OMZP::brew
# zinit snippet OMZP::jsontools
# zinit snippet OMZP::nvm
# zinit snippet OMZP::jenv
# zinit snippet OMZP::rvm
# zinit snippet OMZP::gem
# zinit snippet OMZP::bundler
# zinit snippet OMZP::pyenv
# zinit snippet OMZP::tmux

# completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[f' forward-word # ⌥→
bindkey '^[b' backward-word # ⌥←
bindkey "^A" beginning-of-line # cmd+←
bindkey "^E" end-of-line # cmd+→

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# shell integrations
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(jenv init -)"
eval "$(pyenv init -)"

# aliases

# vim
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias e='nvim'

# misc
alias x='exit'
alias c='clear'

# git
alias gsub='git submodrule'
alias gsa='gsub add'
alias gdiff='git diff --name-only --relative --diff-filter=d | xargs bat --diff'

# modern-unix 
# alias cat='bat --theme auto:system --theme-dark default --theme-light GitHub'
alias cat='bat'
alias ls='lsd'

alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

alias lg='lazygit'

#eval "$(gh copilot alias -- zsh)"

# zprof
zstyle ':completion:*:ssh:*' hosts off

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
