# Oh My Zsh configuration
export ZSH="/nix/store/i8m37fb2m9fcg93ww50gw4m4p04p6ls7-oh-my-zsh-2025-11-09/share/oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS       # Don't record duplicates
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space
setopt SHARE_HISTORY          # Share history between sessions
setopt APPEND_HISTORY         # Append to history file
setopt INC_APPEND_HISTORY     # Add commands immediately

# Plugins (built-in Oh My Zsh plugins)
plugins=(
  git
  history
  history-substring-search
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load zsh-autosuggestions (fish-like autocomplete)
source /nix/store/3hbxxpi4iig3ydrrwn2m9g34k315bgjy-zsh-autosuggestions-0.7.1/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh-syntax-highlighting (must be last)
source /nix/store/j05fs3gm7cfr6xmcvwam1bxxb4ymsbk5-zsh-syntax-highlighting-0.8.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Bind up/down arrows for history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
