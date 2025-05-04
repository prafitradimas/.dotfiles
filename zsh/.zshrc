echo "Loading .zshrc"

if [ -z "$ZDOTDIR" ]; then
    if [ -f "$HOME/.zshenv" ]; then
        source ~/.zshenv
    fi
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# timestamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

COMPLETION_WAITING_DOTS="true"

DISABLE_MAGIC_FUNCTIONS="true"

# zsh-autosuggestions config
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#9e9e9e,bg=bold"

# zsh-syntax-highlighting config
# read config here: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]='fg=#ffffff,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#9e9e9e,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#9e9e9e,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=blue,bold'

# Which plugins to load
# Standard plugins can be found in $ZSH/plugins/
plugins=(git fzf-tab zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$ZDOTDIR/.zsh_history"
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

autoload -Uz compinit
compinit

source $XDG_CONFIG_HOME/fzf/fzf.zsh
source $XDG_CONFIG_HOME/fzf/fzf-completion.zsh
source $XDG_CONFIG_HOME/fzf/fzf-keybindings.zsh

source $ZDOTDIR/alias.zsh

echo ".zshrc is loaded"

