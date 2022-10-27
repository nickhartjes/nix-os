{ config, lib, pkgs, ... }:

{

  hardware.opengl.enable = true;

  services.xserver = {
    enable = true;

    displayManager = {
        sddm.enable = true;
        defaultSession = "none+awesome";
    };

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];

    };
  };

  environment = {
#    loginShellInit = ''
#      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
#        exec Hyprland
#      fi
#    '';                                   # Will automatically open sway when logged into tty1
#    variables = {
#      #LIBCL_ALWAYS_SOFTWARE = "1";       # For applications in VM like alacritty to work
#      #WLR_NO_HARDWARE_CURSORS = "1";     # For cursor in VM
#    };
    systemPackages = with pkgs; [       # Packages installed
      wofi
      waybar
      arandr
    ];
  };

  programs = {
#    hyprland.enable = true;
  };
}
