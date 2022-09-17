{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    xserver = {
      enable = true;                    # Display Manager
#      displayManager = {                          # Display Manager
#        autoLogin = {
#          enable = true;
#          user = "nh";
#        };
#        lightdm = {
#          enable = true;                          # Wallpaper and gtk theme
#          greeters = {
#          };
#        };
#      };
      desktopManager= {
        xfce = {                                 # Window Manager
          enable = true;
        };
      };
    };
  };

  programs.zsh.enable = true;                     # Weirdly needs to be added to have default user on lightdm

  environment.systemPackages = with pkgs; [       # Packages installed
  ];
}
