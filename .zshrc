
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
HISTFILE="$HOME/.zsh_history"
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

if command -v fzf &> /dev/null && command -v fdfind &> /dev/null; then
    # To enable fzf key-bindings
    # Refer to the package documentation for more information. (e.g. `apt show fzf`)
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh

    export FZF_DEFAULT_COMMAND="fdfind --type f" # Override fzf default command
    # Preview file content using bat (https://github.com/sharkdp/bat)
    export FZF_DEFAULT_OPTS="--preview 'batcat --color=always {}'"
    # Add colorscheme to fzf
    export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS" --color fg:-1,bg:-1,hl:33,fg+:254,bg+:235,hl+:33 --color info:136,prompt:136,pointer:230,marker:230,spinner:136"
    # cd into selected dir 
    export FZF_ALT_C_OPTS="--preview 'tree -C {}'" 
    export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
    # CTRL-/ to toggle small preview window to see the full command
    export FZF_CTRL_R_OPTS=" --preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --color header:italic --header 'Press CTRL-Y to copy command into clipboard'"
fi

export PATH="$HOME/Personal/Tools/go/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
