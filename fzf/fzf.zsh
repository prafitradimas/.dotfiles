
export FZF_DEFAULT_COMMAND="fdfind --type file" # Override fzf default command
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_DEFAULT_OPTS="--preview 'batcat --color=always {}'"

# Add colorscheme to fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS" --color fg:-1,bg:-1,hl:33,fg+:254,bg+:235,hl+:33"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS" --color info:136,prompt:136,pointer:230,marker:230,spinner:136"

# cd into selected dir 
export FZF_ALT_C_OPTS="--preview 'tree -C {}'" 
export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always {}'"
export FZF_CTRL_T_OPTS=$FZF_CTRL_T_OPTS" --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-/ to toggle small preview window to see the full command
export FZF_CTRL_R_OPTS=" --preview 'echo {}' --preview-window up:3:hidden:wrap"
export FZF_CTRL_R_OPTS=$FZF_CTRL_R_OPTS" --bind 'ctrl-/:toggle-preview'"
export FZF_CTRL_R_OPTS=$FZF_CTRL_R_OPTS" --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
export FZF_CTRL_R_OPTS=$FZF_CTRL_R_OPTS" --color header:italic"
export FZF_CTRL_R_OPTS=$FZF_CTRL_R_OPTS" --header 'Press CTRL-Y to copy command into clipboard'"

