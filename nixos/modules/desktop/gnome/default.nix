{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      displayManager = {                          # Display Manager
        gdm = {
          enable = true;                          # Wallpaper and gtk theme
        };
#        defaultSession = "gnome";            # none+bspwm -> no real display manager
      };
      desktopManager= {
        gnome = {                                 # Window Manager
          enable = true;
        };
      };
    };
  };

  programs.zsh.enable = true;                     # Weirdly needs to be added to have default user on lightdm

  hardware.pulseaudio.enable = false;

  environment.systemPackages = with pkgs; [       # Packages installed
  ];
}
