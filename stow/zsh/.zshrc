# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::git-auto-fetch
zinit snippet OMZP::vscode

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh_nix/.p10k.zsh.
[[ ! -f ~/.config/zsh_nix/.p10k.zsh ]] || source ~/.config/zsh_nix/.p10k.zsh

############
# Aliases
############
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Git
alias updateRepos="sh ~/.setup/nixos/scripts/update_repos.sh"

# Nix
alias nixSwitch="cd ~/.setup && sudo nixos-rebuild switch --flake .#$HOST"
alias nixBuild="cd ~/.setup && sudo nixos-rebuild build --flake .#$HOST"
alias nixBoot="cd ~/.setup && sudo nixos-rebuild boot --flake .#$HOST"
alias nixClean="sh ~/.setup/nixos/scripts/nixosCleanup.sh"
alias nixUpdate="sh ~/.setup/nixos/scripts/nixosUpdate.sh"

alias stowConfig="cd ~/.setup/stow && stow --target="$HOME" --dir="$HOME/.setup/stow" --verbose=2 *"
alias stowConfigRemove="cd ~/.setup/stow && stow --target="$HOME" --dir="$HOME/.setup/stow" --delete --verbose=2 *"

# Kubernetes
alias k="kubecolor"
alias kubectl="kubecolor"
# make completion work with kubecolor
compdef kubecolor=kubectl

# List
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -alFh'
alias l='ls'
alias l.="ls -A | egrep '^\.'"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

## Security
alias scan="sudo rkhunter --update && sudo rkhunter --check && sudo chkrootkit && arch-audit -t"
alias audit="sudo lynis audit system"

# display all rules #
alias iptlist='sudo iptables -L -n -v --line-numbers'
alias iptlistin='sudo iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

# Shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# Information
alias myip="curl http://ipecho.net/plain; echo"
alias speed='speedtest-cli --server 2406 --simple'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# export
export PATH=~/go/bin:$PATH