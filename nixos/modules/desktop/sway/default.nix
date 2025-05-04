#
#  Sway configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./laptop
#   │       └─ default.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./sway
#               └─ sway.nix *
#

{ config, lib, pkgs, ... }:

let

in
{
  environment.systemPackages = with pkgs; [
    # dbus-sway-environment
    # configure-gtk

    wlogout

    # sway
    #swaylock
    #swaylock-fancy
    #swaylock-effects
    swayidle
    wayland
    # glib                       # gsettings
    dracula-theme              # gtk theme
    kora-icon-theme
    adwaita-icon-theme  # default gnome cursors
    grim                       # screenshot functionality
    slurp                      # screenshot functionality
    wl-clipboard               # wl-copy and wl-paste for copy/paste from stdin / stdout
    bemenu                     # wayland clone of dmenu
    # mako                       # notification system developed by swaywm maintainer
    wdisplays
    waybar
    ranger
    pcmanfm
    swayws
    # eww
    #cliphist

    mako
    #dunst                       # Lightweight and customizable notification daemon
    swww                        # Efficient animated wallpaper daemon
    #hyprpaper                   # A blazing fast wayland wallpaper utility
    imagemagick                 # A software suite to create, edit, compose, or convert bitmap images

    #pgadmin4-desktopmode

    wshowkeys
    swaysettings

    # Launchers
  #wofi
    fuzzel
    rofi
    wofi
    gtk3
    gcc
sfwbar
#ags
 gtksourceview
      webkitgtk
      accountsservice

    blueberry
    # https://grimoire.science/working-with-wayland-and-sway/
    # i3status-rust

    # For desktop/panel controle
    brightnessctl
    ddcutil
    playerctl
    swaynotificationcenter
    gopsuinfo

    #autotiling
    mpd

    pango             # Text renderer
    dejavu_fonts      # Font

    kanshi
    swaybg

    nmon
    glances

    networkmanagerapplet

    #blueman           # Bluetooth manager
    # haskellPackages.network-manager-tui # Network manager
    light                               # Brightness control
    pavucontrol                         # Sound

    selectdefaultapplication

    sway-contrib.grimshot
    sway-contrib.inactive-windows-transparency

    # GTK Themes
    themechanger
    theme-vertex
    pop-gtk-theme
    yaru-theme
    zuki-themes
  ];

  # environment.loginShellInit = ''
  #   if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then

  #     #
  #     # GTK environment
  #     #

  #     export GDK_BACKEND="wayland,x11"
  #     export TDESKTOP_DISABLE_GTK_INTEGRATION=1
  #     export CLUTTER_BACKEND=wayland
  #     export BEMENU_BACKEND=wayland

  #     # Firefox
  #     export MOZ_ENABLE_WAYLAND=1

  #     #
  #     # Qt environment
  #     #
  #     export QT_QPA_PLATFORM=wayland
  #     export QT_WAYLAND_FORCE_DPI=physical
  #     export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

  #     #
  #     # SDL environment
  #     #
  #     export SDL_VIDEODRIVER=wayland

  #     #
  #     # Java environment
  #     #
  #     export _JAVA_AWT_WM_NONREPARENTING=1

  #     # Session
  #     export XDG_SESSION_TYPE=wayland
  #     export XDG_SESSION_DESKTOP=sway
  #     export XDG_CURRENT_DESKTOP=sway
  #     export XDG_CURRENT_SESSION=sway

  #     # Replaces Caps for excape
  #     export XKB_DEFAULT_OPTIONS=caps:escape
  #     exec sway
  #   fi
  # '';                                   # Will automatically open sway when logged into tty1

  #  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configuring Kanshi
# kanshi systemd service
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c  ~/.config/kanshi/config'';
    };
  };



  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    dbus.enable = true;
    upower.enable = true;

  };

  security.polkit.enable = true;


  # enable sway window manager
  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    nm-applet = {
      enable = true;
      indicator = true;
    };
  };
}
