{ config, lib, pkgs, ... }:

{
  services = {
    displayManager = {                          # Display Manager
      cosmic-greeter = {
         enable = true;                          # Wallpaper and gtk theme
      };
    };
  };
}
