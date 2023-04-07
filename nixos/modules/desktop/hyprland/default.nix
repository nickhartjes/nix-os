{ config, lib, pkgs, hyprland, ... }:

{

  hardware.opengl.enable = true;

#  services = {
#    xserver = {
#      displayManager = {                          # Display Manager
#        lightdm = {
#          enable = true;                          # Wallpaper and gtk theme
#          };
#        };          # none+bspwm -> no real display manager
#      };
#  };
#
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
      wofi
      waybar
      wdisplays
      variety
      slurp
      grim
      mpd
      hyprpaper
    ];
  };

  programs = {
    hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.system}.default;
    } ;
  };
}
