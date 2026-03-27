# Load sharded config
[[ -f ~/.zsh/exports.zsh ]] && source ~/.zsh/exports.zsh
[[ -f ~/.zsh/path.zsh ]] && source ~/.zsh/path.zsh
[[ -f ~/.zsh/history.zsh ]] && source ~/.zsh/history.zsh
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/secrets.zsh ]] && source ~/.zsh/secrets.zsh

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf --zsh)"
#eval "$(zoxide init --cmd cd zsh)"

# Load starship
eval "$(starship init zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/vlad.cuciureanu/.lmstudio/bin"
# End of LM Studio CLI section

eval "$(zoxide init --cmd cd zsh)"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
#        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
#    else
#        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<


# Vite+ bin (https://viteplus.dev)
#. "$HOME/.vite-plus/env"
