{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    desktopManager= {
      plasma6 = {                                 # Window Manager
        enable = true;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
  };

  programs.zsh.enable = true;                     # Weirdly needs to be added to have default user on lightdm

  environment.systemPackages = with pkgs; [       # Packages installed

    #layan-kde
    #materia-theme
    #materia-kde-theme
    #material-design-icons
    #arc-kde-theme
    #adapta-kde-theme
    #graphite-kde-theme
    #nordic
    #sierra-breeze-enhanced

    ## KDE Fonts
    #oxygenfonts
    #iosevka



    ## Plasma applications
    #plasma-theme-switcher
    #plasma-integration
    #plasma-applet-caffeine-plus
    #plasma-thunderbolt
    #plasma-systemmonitor
    #ark                           # Archive utility
    #okular

    #libsForQt5.plasma-workspace
    #libsForQt5.plasma-workspace-wallpapers
    kdePackages.yakuake
    kdePackages.kpmcore
    kdePackages.partitionmanager
  ];
}
