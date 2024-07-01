FPATH+=:"/opt/local/share/zsh/site-functions"
FPATH+=:"$HOME/.local/share/zsh/site-functions"
FPATH+=:"$HOME/.local/share/zsh/plugins/zsh-completions/src"

PROMPT='%B%~ %(!.#.$)%b '
RPROMPT='%(?..%F{red}%?%f)'
KEYTIMEOUT=1

setopt auto_cd
setopt interactive_comments
unsetopt beep

zmodload zsh/complist
zstyle ':completion:*' menu select

autoload -U compinit && compinit
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U edit-command-line

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

bindkey '^E' edit-command-line
bindkey '^[[A' up-line-or-beginning-search 
bindkey '^[[B' down-line-or-beginning-search

bindkey -M menuselect '^[[Z' reverse-menu-complete

alias ls='ls -G'
alias l='ls -lh'
alias ll='ls -lhA'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias md='mkdir -p'
alias du='du -h'
alias df='df -PH'
alias pg='ping 8.8.8.8'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias gping='graphping'
alias v='nvim'
alias vi='nvim'
alias rc='(cd ~/.config/zsh && nvim -o +only .zshrc .zshenv .zprofile)'
alias virc='(cd ~/.config/nvim && nvim init.vim)'
alias yt='ytfzf -T kitty -t'
alias appinfo='appinfo 2>/dev/null'
alias icat='wezterm imgcat'

alias dotgit="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias desk="cd $HOME/Desktop"
alias docs="cd $HOME/Documents"
alias dls="cd $HOME/Downloads"
alias conf="cd $HOME/.config"
alias st="cd $HOME/Sync"

source /opt/local/share/fzf/shell/completion.zsh
source /opt/local/share/fzf/shell/key-bindings.zsh
source /opt/local/share/lf/lfcd.sh

dl() { (cd ~/Downloads && yt-dlp $1) }

source /opt/local/share/chruby/chruby.sh
source /opt/local/share/chruby/auto.sh
