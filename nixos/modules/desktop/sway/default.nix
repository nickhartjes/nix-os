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
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
  systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
  systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Dracula'
        # gsettings set $gnome-schema icon-theme 'Your icon theme'
        # gsettings set $gnome-schema cursor-theme 'Your cursor Theme'
        # gsettings set $gnome-schema font-name 'Your font name'
        '';
  };


in
{






  environment.systemPackages = with pkgs; [
    dbus-sway-environment
    configure-gtk

    sway
    swaylock
    swayidle
    wayland
    glib                       # gsettings
    dracula-theme              # gtk theme
    gnome3.adwaita-icon-theme  # default gnome cursors
    grim                       # screenshot functionality
    slurp                      # screenshot functionality
    wl-clipboard               # wl-copy and wl-paste for copy/paste from stdin / stdout
    bemenu                     # wayland clone of dmenu
    #mako                       # notification system developed by swaywm maintainer
    wdisplays
    wofi
    waybar
    ranger
    pcmanfm

    nwg-bar                   # Bar logout, reboot shutdown
    nwg-menu                  # Windows like start menu
    nwg-panel                 # Bars
    nwg-drawer                # Application start grid
    nwg-launchers

    # For desktop/panel controle
    brightnessctl
    ddcutil
    playerctl
    swaynotificationcenter
    gopsuinfo

    mpd

    pango             # Text renderer
    dejavu_fonts      # Font

    kanshi

    blueman           # Bluetooth manager
    haskellPackages.network-manager-tui # Network manager
    light                               # Brightness control
    pavucontrol                         # Sound
  ];

  environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec sway
    fi
  '';                                   # Will automatically open sway when logged into tty1

  # Configuring Kanshi
  systemd.user.services.kanshi = {
    description = "Kanshi output autoconfig ";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    environment = { XDG_CONFIG_HOME="~/home/nh/.config"; };
    serviceConfig = {
      # kanshi doesn't have an option to specifiy config file yet, so it looks
      # at .config/kanshi/config
      ExecStart = ''
      ${pkgs.kanshi}/bin/kanshi
      '';
      RestartSec = 5;
      Restart = "always";
    };
  };

#  systemd.user.services.mako = {
#    Unit = {
#      Description = "Mako notification daemon";
#      PartOf = [ "graphical-session.target" ];
#    };
#    Install = {
#      WantedBy = [ "graphical-session.target" ];
#    };
#    Service = {
#      Type = "dbus";
#      BusName = "org.freedesktop.Notifications";
#      ExecStart = "${pkgs.mako}/bin/mako";
#      RestartSec = 5;
#      Restart = "always";
#    };
#  };



  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    dbus.enable = true;
    upower.enable = true;
  };

  security.polkit.enable = true;


  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
#    gtkUsePortal = true;
  };

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
