{ config, lib, pkgs, inputs, user, location, ... }:

{
  # Import window or display manager.
  imports =
    [
    ];


  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];
  networking.extraHosts =
    ''
    '';

  ##################
  ## User config
  ##################

  # User account
  users.users.${user} = {                   # System User
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "kvm" "libvirtd"];
    shell = pkgs.zsh;                       # Default shell
  };
  # User does not need to give password when using sudo.
  security.sudo.wheelNeedsPassword = false;

  # Locale and Timezone
  time.timeZone = "Europe/Amsterdam";        # Time zone and internationalisation
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {                 # Extra locale settings that need to be overwritten
      LC_TIME = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
    };
  };

  ##################
  ## System settings
  ##################

  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
    };
  };

  fonts.packages = with pkgs; [                # Fonts
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # Icons
    corefonts                               # MS
    (nerdfonts.override {                   # Nerdfont Icons override
      fonts = [
        "FiraCode"
      ];
    })
  ];

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    # Default packages install system-wide
    systemPackages = with pkgs; [
      curl
      git
      htop
      killall
      nano
      pciutils
      rsync
      unrar
      unzip
      usbutils
      vim
      wget
      zip
      nix-prefetch
      nix-prefetch-git
      nix-prefetch-github
      tree
    ];
  };

  services = {
#    pipewire = {                            # Sound
#      enable = true;
#      alsa = {
#        enable = true;
#        support32Bit = true;
#      };
#      pulse.enable = true;
#    };
    openssh = {                             # SSH: secure shell (remote connection to shell of server)
      enable = true;                        # local: $ ssh <user>@<ip>
                                            # public:
                                            #   - port forward 22 TCP to server
                                            #   - in case you want to use the domain name insted of the ip:
                                            #       - for me, via cloudflare, create an A record with name "ssh" to the correct ip without proxy
                                            #   - connect via ssh <user>@<ip or ssh.domain>
                                            # generating a key:
                                            #   - $ ssh-keygen   |  ssh-copy-id <ip/domain>  |  ssh-add
                                            #   - if ssh-add does not work: $ eval `ssh-agent -s`
      allowSFTP = true;                     # SFTP: secure file transfer protocol (send file to server)
                                            # connect: $ sftp <user>@<ip/domain>
                                            # commands:
                                            #   - lpwd & pwd = print (local) parent working directory
                                            #   - put/get <filename> = send or receive file
      extraConfig = ''
        HostKeyAlgorithms +ssh-rsa
      '';                                   # Temporary extra config so ssh will work in guacamole
    };
    fwupd.enable = true;


    printing.enable = true; # Printer drivers
    avahi = {
      enable = true;
      nssmdns4 = true;
      # for a WiFi printer
      openFirewall = true;
    };
  };

  ##################
  ## Secrurity
  ##################

  security = {
    rtkit.enable = true;
    apparmor.enable = true;
  };

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  ##################
  ## Nix settings
  ##################
  nix = {                                   # Nix Package Manager settings
    settings ={
      auto-optimise-store = true;           # Optimise syslinks
    };
    gc = {                                  # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.stable;               # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features       = nix-command flakes
      keep-outputs                = true
      keep-derivations            = true
    '';
  };

  # Allow proprietary software.
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "python-2.7.18.6"
      "electron-21.4.0"
      "nodejs-16.20.0"
      "electron-19.1.9"
      "electron-25.9.0"
    ];
  };

  # NixOS settings
  system = {
   # Allow auto update
    autoUpgrade = {
      enable = false;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "23.11";
  };
}

