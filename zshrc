export HISTFILE=~/.histfile
export HISTSIZE=10000
export SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
unsetopt beep 


zstyle ':completion:*' menu select
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# bindkey -v
# bindkey 'fj' vi-cmd-mode

function zvm_config() {
    ZVM_INIT_MODE=$ZVM_MODE_INSERT
    ZVM_VI_INSERT_ESCAPE_BINDKEY=fj
}

# path variables
export PATH="$PATH:$HOME/.cargo/bin"
# export PATH="$PATH:$HOME/.rustup/toolchains/**/bin"

export PATH="$PATH:$HOME/.zig/zig-linux-x86_64-0.13.0-dev.363+7fc3fb955"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
source $HOME/.cargo/env

# zoxide setup
eval "$(zoxide init zsh)"

# aliases
alias v='nvim'
alias reload='source ~/.zshrc'
alias xdg-open= 'wslview'


fpath+=~/.zfunc
autoload -U compinit && compinit

for file in $HOME/.zsh_plugins/*; do 
    [[ -f "$file" ]] && source "$file"
done

type starship_zle-keymap-select >/dev/null || \
  {
    eval "$(starship init zsh)"
  }

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh_plugins/zsh-vi-mode.zsh
