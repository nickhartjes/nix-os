{ config, lib, pkgs, ... }:

{
  services = {
    displayManager = {
      autoLogin = {
        enable = false;
        user = "nh";
      };                          # Display Manager
      gdm = {
        enable = true;                          # Wallpaper and gtk theme
      };
#        defaultSession = "gnome";            # none+bspwm -> no real display manager
    };
  };
}
