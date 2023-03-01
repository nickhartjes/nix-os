{ config, lib, pkgs, user, nur, hyprland, ... }:

{
  imports =                                   # Home Manager Modules
    (import ../modules/editors) ++
    (import ../modules/programs) ++
    (import ../modules/services) ++
    (import ../modules/terminal) ++
    (import ../modules/kubernetes);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      btop                    # Resource Manager
      pfetch                  # Minimal fetch
      jq                      # command-line JSON processor
      yq                      # command-line YAML processor
      git-crypt
      dnsutils
      whois
      neofetch                # Fetch
      stow                    # Config file management

      # Video/Audio
      mpv                     # Media Player
      pavucontrol             # Audio control

      # Office
      onlyoffice-bin
      corefonts               # Fonts for Microsoft

      # Browser
      brave

#      insomnia
      pywal

      # Development
      jetbrains.idea-ultimate # IDE
      jetbrains.goland
#      jetbrains.pycharm-professional
      vscode                  # IDE
      graphviz                # For plantuml plugin
      #openjdk17               # Java development kit
      graalvm17-ce
      act                     # Local Github Actions
      helix
      asciinema

      go

#      foxitreader
      adobe-reader

      mdbook
      pkg-config
      cargo
      gcc
      openssl
      rustc
#      rustup

      python3Full
      python3Packages.pip
      python3Packages.virtualenv
      chromedriver
      mkdocs
#      python39Packages.pytorch-bin
#      python39Packages.webrtcvad
#      ffmpeg
#      gcc

      obs-studio
      #obs-studio-plugins.obs-ndi
      obs-studio-plugins.wlrobs

      # Communication
      slack
      signal-desktop
      tdesktop
      # Authentication
      authy
      bitwarden
      bitwarden-cli

      # Security
      lynis                   # Security audit tool

      # Desktop
      okular                  # PDF viewer
      obsidian                # Second brain
      pandoc                  # Markdown convertor
#      zsh-autocomplete
#      zsh-you-should-use
#      zsh-completions
#      zsh-history

      audacity

#      pulumi
      terraform

      wlogout

      macchina

      gimp
    ];

    # Wallpaper
    file.".config/wall".source = ../modules/themes/wall.jpg;

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };
}
