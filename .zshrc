HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

PATH="$HOME/go/bin:$PATH"
PATH="$HOME/bin:$PATH"

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
dotfiles=$HOME/repos/dotfiles
