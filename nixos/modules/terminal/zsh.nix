#
# Shell
#

{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh_nix";
      enableAutosuggestions = true;             # Auto suggest options and highlights syntact, searches in history for options
      enableSyntaxHighlighting = true;
      history.size = 10000;

      oh-my-zsh = {                             # Extra plugins for zsh
        enable = true;
        plugins = [
          "aws"
          "colorize"
          "git"
          "helm"
          "kubectl"
          "kubectx"
          "history"
          "web-search"
        ];
        custom = "$HOME/.config/zsh_nix/custom";
      };

      initExtra = ''                            # Zsh theme
        # Spaceship
        source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
        autoload -U promptinit; promptinit
#       source $HOME/.config/shell/shell_init
        # Hook direnv
#       emulate zsh -c "$(direnv hook zsh)"

        export GH_EDITOR='vim'

        # Add local bin
        export PATH=~/.local/bin:$PATH

        # NPM
        export PATH=~/.npm-packages/bin:$PATH
        export NODE_PATH=~/.npm-packages/lib/node_modules

        export GOCACHE=~/.go-cache

        # Added pulumi
        export PATH=~/.pulumi/bin:$PATH

        # Added cargo
        export PATH=~/.cargo/bin:$PATH

        # Krew
        export PATH=~/.krew/bin:$PATH

        ### ALIASES ###
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

        ## shortcut  for iptables and pass it via sudo#
        alias ipt='sudo iptables'

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

        ## Alternative programs
        alias htop="btop"

        ## GPG
        alias gpgBackup="gpg --export -a 'info@nickhartjes.nl' > public.key && gpg --export-secret-key -a 'info@nickhartjes.nl' > private.key"

        # Kubernetes
        alias k="kubecolor"
        alias kubectl="kubecolor"
        # make completion work with kubecolor
        compdef kubecolor=kubectl

        # Slack
        alias slackMagic="ps aux | grep slack | grep -v grep | grep magic"

        # Git
        alias cloneRepos="sh ~/.setup/nixos/scripts/cloneRepos.sh"

        # Nix
        alias nixSwitch="cd ~/.setup && sudo nixos-rebuild switch --flake .#$HOST"
        alias nixBuild="cd ~/.setup && sudo nixos-rebuild build --flake .#$HOST"
        alias nixBoot="cd ~/.setup && sudo nixos-rebuild boot --flake .#$HOST"
        alias nixClean="sh ~/.setup/nixos/scripts/nixosCleanup.sh"
        alias nixUpdate="sh ~/.setup/nixos/scripts/nixosUpdate.sh"

        alias stowConfig="cd ~/.setup/stow && stow --target="$HOME" --dir="$HOME/.setup/stow" --verbose=2 *"
        alias stowConfigRemove="cd ~/.setup/stow && stow --target="$HOME" --dir="$HOME/.setup/stow" --delete --verbose=2 *"

        alias howMuchTime="sh ~/.setup/nixos/scripts/countDownToDate.sh"

        alias ls="exa --long --tree --level=2 --icons"
        alias cat="bat"
        alias df="duf"

        #pfetch                                # Show fetch logo on terminal start
        neofetch                              # Show fetch logo on terminal start
        #macchina
        howMuchTime
      '';
    };
  };
}
