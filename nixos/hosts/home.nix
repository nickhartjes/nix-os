{ config, lib, pkgs, user, nur, ... }:

{
  imports =                                   # Home Manager Modules
    (import ../modules/editors) ++
    (import ../modules/programs) ++
    (import ../modules/services) ++
    (import ../modules/programming) ++   
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

      bat                     # Alternative for cat
      duf                     # Alternative for du
      eza                     # Alternative for ls
      
      v4l-utils               # Used setting the zoom to the camera

      nushellFull
      # Video/Audio
      mpv                     # Media Player
      pavucontrol             # Audio control

      flutter
      android-tools
      #haskellPackages.adb

      #rustdesk

      podman-desktop

      # Office
      libreoffice
      corefonts               # Fonts for Microsoft

      # Browser
#      brave
#      cpufrequtils # for gnome

#      insomnia
      pywal

      # Development
     
    
      # jetbrains.pycharm-professional

      graphviz                # For plantuml plugin
      #jdk21                   # Java development kit
      #jdk11
      act                     # Local Github Actions
      lazygit
    

      gcc
      fzf   # For vim
      fzf-zsh
      #foxitreader
      
      adobe-reader

      bc                  #used for waybar
      glxinfo             #used for waybar
#      font-awesome

#      pkg-config
#      cargo
#      rust-analyzer
#      gcc
#      openssl
#      rustc

#      gnumake

#      rustup
#
       fzf
       libstdcxx5
       tmux
#      protonvpn-gui

       awscli2

       python312Full
       python3Packages.pip
       python3Packages.stdenv
       onnxruntime
      #  poetry
#      python3Packages.virtualenv
#      chromedriver
#      mkdocs
#      python39Packages.pytorch-bin
#      python39Packages.webrtcvad
#      ffmpeg
#      gcc
       ollama

#      deno
       yarn

#      obs-studio
#      obs-studio-plugins.wlrobs

      # Communication
      slack
      signal-desktop
      tdesktop

      # Authentication
      # authy
      bitwarden
      bitwarden-cli

      # Security
      lynis                   # Security audit tool
      aide                    # A file and directory integrity checkerK

      # Desktop
      okular                  # PDF viewer
      obsidian                # Second brain
      marktext
      inkscape                #
      gimp                    # Image

#      shutter                 # Screenshot utility

#      neo4j-desktop
#      k6

      # pgmodeler
      macchina
      fzf
      flameshot

      android-studio
      android-tools


      gnumake
      # Database
      supabase-cli
      dbeaver
      talosctl
      fluxcd
      discord
      age                       # encryption tool
      sops                      # Secrets OPeationS
      unoconv                   # Convert between any document format supported by LibreOffice/OpenOffice
      ansible
      isoimagewriter
      usbimager

      rivalcfg

      python311Packages.mike
      jetbrains.pycharm-professional
      
      calibre
    ];

    # Wallpaper
    file.".config/wall".source = ../modules/themes/wall.jpg;

    stateVersion = "23.11";
  };

  programs = {
    home-manager.enable = true;
  };
}
