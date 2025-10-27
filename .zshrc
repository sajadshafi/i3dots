export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8

ZSH_THEME="awesomepanda"
zstyle ':omz:update' mode reminder

plugins=(git tmux zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

# PERSONAL ALIASES
alias mount-work="sudo ~/mount_work.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# custom ls commands for terminal using eza
alias l="eza --icons=always --all -l --group-directories-first"
alias ls="eza --icons=always -l"
alias lsd="eza --icons=always --all -l -D"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"


# Load Angular CLI autocompletion.
source <(ng completion script)
