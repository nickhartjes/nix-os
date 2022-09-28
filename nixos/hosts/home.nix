{ config, lib, pkgs, user, nur, ... }:

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

      # Development
      jetbrains.idea-ultimate # IDE
      jetbrains.idea-community
      #jetbrains.jdk
      # eclipse-java
      vscode                  # IDE
      graphviz                # For plantuml plugin
      jdk17                   # Java development kit

      # Communication
      slack
      signal-desktop

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
    ];

    # Wallpaper
    file.".config/wall".source = ../modules/themes/wall.jpg;

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };
}
