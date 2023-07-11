{ config, lib, pkgs, hyprland, ... }:

{

  imports = [
    ../wayland/default.nix
    ../../programs/waybar-hyprland.nix
  ];

  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then

        #
        # GTK environment
        #

        export GDK_BACKEND="wayland,x11"
        export TDESKTOP_DISABLE_GTK_INTEGRATION=1
        export CLUTTER_BACKEND=wayland
        export BEMENU_BACKEND=wayland

        # Firefox
        export MOZ_ENABLE_WAYLAND=1

        #
        # Qt environment
        #
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_FORCE_DPI=physical
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

        #
        # SDL environment
        #
        export SDL_VIDEODRIVER=wayland

        #
        # Java environment
        #
        export _JAVA_AWT_WM_NONREPARENTING=1

        #
        # Session
        #

        export XDG_CURRENT_DESKTOP=sway
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP=sway

        exec Hyprland
      fi
    '';                                   # Will automatically open sway when logged into tty1
    variables = {
    };

    systemPackages = with pkgs; [       # Packages installed
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
        hidpi = false;
      };

    };
    nm-applet = {
      enable = true;
      indicator = true;
    };
  };
}
