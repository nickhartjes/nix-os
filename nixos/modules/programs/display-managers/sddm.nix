{ config, home, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;                              # Display Manager
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

  #packages = with pkgs; [       # Packages installed
  #  sddm-chili-theme
  #];
}
