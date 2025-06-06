{ inputs, pkgs, ... }:
{
  # imports = [
  #   ../../programs/waybar-hyprland.nix
  # ];

  environment = {
    systemPackages = with pkgs; [       # Packages installed
      # inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      # inputs.hyprland-contrib.packages.${pkgs.system}.scratchpad
      #inputs.hyprland-contrib.packages.${pkgs.system}.hdrop

      hyprpanel

      # avizo
      # ironbar
      # pyprland
      wofi        # Launcher
      # eww         # Statusbar
      # wdisplays
      # swww        # Efficient animated wallpaper daemon for wayland, controlled at runtime
      # # pcmanfm
      # # dolphin
      kanshi
      # #swaylock-effects
      # swaybg
      # rofi-wayland
      # rofi-calc
      # libnotify                 # For sending notifications with notify-send
      # playerctl
      # pop-gtk-theme
      lxappearance
      # pamixer                   # Pulseaudio command-line mixer like amixer
      # pavucontrol               # PulseAudio Volume Control
      # brightnessctl             # Lightweight brightness control tool
      # bluez                     # Daemons for the bluetooth protocol stack
      # bluez-tools
      # #blueman                   # GTK+ Bluetooth Manager
      # #blueberry
      networkmanagerapplet      # NetworkManager control applet for GNOME
      # swappy                    # A Wayland native snapshot editing tool
      # grim                      # Screenshot utility for Wayland
      # slurp                     # Select a region in a Wayland compositor
      # # glib
      # wlogout                   # Logout menu for wayland
      # wl-clipboard

      hyprlandPlugins.hyprexpo
      hyprlandPlugins.hy3

      # Needed for hyprpanel
      libgtop
      bluez
      bluez-tools
      networkmanager
      dart-sass
      wl-clipboard
      upower
      gvfs
    ];
  };

  programs.zsh.enable = true;

  programs = {
    hyprland = {
      enable = true;
      # withUWSM = true;
      # xwayland.enable = true;
    };
    nm-applet = {
      enable = true;
      indicator = true;
    };
    # waybar.enable = true;
    hyprlock = {
      enable = true;
    };
  };

  services = {
    hypridle.enable = true;
  };
}
