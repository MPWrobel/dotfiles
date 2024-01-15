export ZDOTDIR="$HOME/.config/zsh"

export DISPLAY=:0
export LANG=en_US.UTF-8
export EDITOR=nvim

export WGETRC="$HOME/.config/wget/wgetrc"
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc" 

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk17/Contents/Home"
export IPYTHONDIR="$HOME/.local/share/ipython"
export GNUPGHOME="$HOME/.local/share/gnupg" 
export GRADLE_USER_HOME="$HOME/.local/share/gradle"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export CARGO_HOME="$HOME/.local/share/cargo"
export BUN_INSTALL="$HOME/.bun" 

PATH="/opt/local/bin:/opt/local/sbin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="/Applications/MacPorts/WezTerm.app/Contents/MacOS:$PATH"
PATH+=":$HOME/.local/share/npm/bin"
PATH+=":/Users/marcin/Library/Python/3.12/bin"
PATH+=":/opt/riscv/bin"
PATH+=":$HOME/go/bin"
PATH+=":/Applications/Racket v8.6/bin"
PATH+=":/Applications/love.app/Contents/MacOS"
PATH+=":/Applications/kitty.app/Contents/MacOS"
PATH+=":/Applications/MacPorts/pinentry-mac.app/Contents/MacOS"

source "/Users/marcin/.local/share/cargo/env"
