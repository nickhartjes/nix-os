{ config, lib, pkgs, ... }:

{
  services = {
    displayManager = {                          # Display Manager
      autoLogin = {
        enable = false;
        user = "nh";
      };
    };
    xserver = {
      enable = true;                    # Display Manager
      displayManager = {                          # Display Manager
        lightdm = {
          greeter.enable = true;                          # Wallpaper and gtk theme
        };
      };
    };
  };
}
