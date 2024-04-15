{ config, home, lib, pkgs, ... }:

{
  services = {
    displayManager = {                          # Display Manager
      autoLogin = {
        enable = false;
        user = "nh";
      };
      sddm = {
        wayland = {
          enable = true;                          # Wallpaper and gtk theme
        };
      };
    };
  };

  #packages = with pkgs; [       # Packages installed
  #  sddm-chili-theme
  #];
}
