{ config, lib, pkgs, ... }:

{

#  imports = [
#    ../wayland/default.nix
#    ../../programs/waybar-hyprland.nix
#  ];

  environment = {


    systemPackages = with pkgs; [       # Packages installed
      xdg-desktop-portal-hyprland
      hyprland-protocols





      wofi        # Launcher
      eww-wayland # Statusbar
      wdisplays

      swww        # Efficient animated wallpaper daemon for wayland, controlled at runtime

      pcmanfm
      dolphin

      kanshi

      swaylock-effects
      swayidle
      swaybg

      mako                      # Lightweight notification daemon for Wayland
      libnotify                 # For sending notifications with notify-send


      playerctl
      pop-gtk-theme
      lxappearance

      pamixer                   # Pulseaudio command-line mixer like amixer
      pavucontrol               # PulseAudio Volume Control
      brightnessctl             # Lightweight brightness control tool
      bluez                     # Daemons for the bluetooth protocol stack
      bluez-tools
      blueman                   # GTK+ Bluetooth Manager
      blueberry
      networkmanagerapplet      # NetworkManager control applet for GNOME

      swappy                    # A Wayland native snapshot editing tool
      grim                      # Screenshot utility for Wayland
      slurp                     # Select a region in a Wayland compositor

      glib
      wlogout                   # Logout menu for wayland
      wl-clipboard
    ];
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
    nm-applet = {
      enable = true;
      indicator = true;
    };
  };

  #home = {
  #  wayland.windowManager.hyprland.plugins = [
  #    inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
  #  ];
  #};
}
