{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;                    # Display Manager
#      defaultSession = "plasmawayland";
      displayManager = {                          # Display Manager
        autoLogin = {
          enable = false;
          user = "nh";
        };
        sddm = {
          enable = true;                          # Wallpaper and gtk theme
        };
      };
    };
  };
}
