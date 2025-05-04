export ZDOTDIR=${ZDOTDIR:=$HOME/.config/zsh}

# XDG
export XDG_BIN_HOME=${XDG_BIN_HOME:=$HOME/.local/bin}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:=$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:=$HOME/.local/state}

# Custom
export DOTFILES=~/.dotfiles

if [ -z "$PROTOC" ]; then
    export PROTOC=~/Tools/protoc/bin
    export PATH=$PATH:$PROTOC
fi

if [ -z "$GOPATH" ]; then
    export GOPATH=~/Tools/go
    export GOROOT=~/Tools/goroot
    export PATH=$PATH:~/Tools/goroot/bin
    export PATH=$PATH:~/Tools/go/bin
fi

if [ -x "$(command -v flatpak)" ]; then
    export PATH=$PATH:$HOME/.local/share/flatpak/exports/bin
fi

# if [ -d "/opt/kubernetes/bin" ]; then
#     export PATH="$PATH:/opt/kubernetes/bin"
# fi

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

source "$HOME/.cargo/env"
