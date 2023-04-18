{ config, lib, pkgs, hyprland, ... }:

{

  imports = [
    ../../programs/waybar-hyprland.nix
  ];
  programs.zsh.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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

        export XDG_CURRENT_DESKTOP=Hyprland
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP=Hyprland

        exec Hyprland
      fi
    '';                                   # Will automatically open sway when logged into tty1
    variables = {
    };

    systemPackages = with pkgs; [       # Packages installed
      xwayland    # Run xorg applications
      wofi        # Launcher
      eww-wayland # Statusbar
      wdisplays

      slurp
      grim

      mpd

      pcmanfm

      kanshi

      swaylock
      swayidle
      swaybg

      networkmanagerapplet

      blueberry                             # Bluetooth manager
    # haskellPackages.network-manager-tui # Network manager
      light                               # Brightness control
      pavucontrol                         # Sound
    ];
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

  # Hardware Support for Hyprland
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };


  programs = {
    hyprland = {
      enable = true;
      #package = hyprland.packages.${pkgs.system}.default;
    };
    nm-applet = {
      enable = true;
      indicator = true;
    };
  };
}
