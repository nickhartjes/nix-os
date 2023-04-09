{ config, lib, pkgs, hyprland, ... }:

{

  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland
      fi
    '';                                   # Will automatically open sway when logged into tty1
#    variables = {
#      #LIBCL_ALWAYS_SOFTWARE = "1";       # For applications in VM like alacritty to work
#      #WLR_NO_HARDWARE_CURSORS = "1";     # For cursor in VM
#    };

    systemPackages = with pkgs; [       # Packages installed
      
      wofi        # Launcher
      waybar      # Statusbar
      wdisplays
      
      slurp
      grim
      
      mpd
      swaybg
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

  security.polkit.enable = true;


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
      package = hyprland.packages.${pkgs.system}.default;
    };
    nm-applet = {
      enable = true;
      indicator = true;
    };
  };
}
