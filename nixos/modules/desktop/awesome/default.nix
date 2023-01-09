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

programs.nm-applet.enable = true;
programs.nm-applet.indicator = true;
  environment = {
    systemPackages = with pkgs; [       # Packages installed
      arandr
      lxappearance
      dex
      picom

      ulauncher

      libgnome-keyring
      rofi
      polybar
      pywal
      calc
      networkmanager_dmenu
      feh

    ];
  };

  programs = {
#    hyprland.enable = true;
  };
}
