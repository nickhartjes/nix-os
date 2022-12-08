{ config, lib, pkgs, ... }:

{

  hardware.opengl.enable = true;

  services = {
     xserver = {
       enable = true;
       desktopManager = {
          xterm.enable = false;
          xfce = {
            enable = true;
            noDesktop = true;
            enableXfwm = false;
          };
       };
       displayManager.defaultSession = "none+awesome";
       windowManager.awesome = {
         enable = true;
         luaModules = with pkgs.luaPackages; [
           luarocks # is the package manager for Lua modules
           luadbi-mysql # Database abstraction layer
         ];

       };
     };
  };



  environment = {
    systemPackages = with pkgs; [       # Packages installed
      lxappearance
      dex
      #xss-lock
      picom

      ulauncher


      rofi
      polybar
      pywal
      calc
      networkmanager_dmenu

    ];
  };

  programs = {
#    hyprland.enable = true;
  };
}
