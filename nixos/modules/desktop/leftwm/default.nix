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
       windowManager.leftwm = {
         enable = true;
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
