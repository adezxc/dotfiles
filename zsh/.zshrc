ZSH_THEME="robbyrussell"

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/adam/.zshrc'

autoload -Uz compinit 
compinit
# End of lines added by compinstall

export PATH="/home/adam/.rbenv/bin:$PATH"
export PATH="/home/adam/.getada/bin:$PATH"
export PATH="/home/adam/.local/bin:$PATH"
export PATH="/home/adam/.cargo/bin:$PATH"
eval "$(rbenv init - --no-rehash zsh)"
export PATH="/home/adam/bin:$PATH"

export KITCHEN_DRIVER=digitalocean

FZF_ALT_C_COMMAND= source <(fzf --zsh)
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(zoxide init zsh)"
eval "$(kubectl completion zsh)"
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

alias "unlock-vinted"="ssh-add -t 16h ~/.ssh/work.id_rsa"
alias "k"="kubectl"

knife-a() { knife $@ --profile ams1 }
knife-b() { knife $@ --profile bru1 }
knife-d() { knife $@ --profile dus1 }
knife-w() { knife $@ --profile fra52 }

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias today="date '+%Y-%m-%d'"
