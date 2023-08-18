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
        xterm.enable = false;
        xfce = {                                 # Window Manager
          enable = true;
        };
      };
      displayManager.defaultSession = "xfce";
    };
  };

  programs.zsh.enable = true;                     # Weirdly needs to be added to have default user on lightdm

  environment.systemPackages = with pkgs; [       # Packages installed
      xfce.xfce4-panel-profiles
      xfce.xfce4-appfinder
  ];
}
