{ config, lib, pkgs, ... }:

{
  services = {
    displayManager = {                          # Display Manager
      # cosmic-greeter = {
      #   enable = true;                          # Wallpaper and gtk theme
      # };
#        defaultSession = "gnome";            # none+bspwm -> no real display manager
    };
    desktopManager= {
      cosmic = {                                 # Window Manager
        enable = true;
        xwayland.enable = true;               # Xwayland support
      };
    };
  };

  programs.zsh.enable = true;                     # Weirdly needs to be added to have default user on lightdm

  # hardware.pulseaudio.enable = false;

  # environment.systemPackages = with pkgs; [       # Packages installed
  #   cosmic-panel
  #   cosmic-applets 
  #   cosmic-applibrary 
  #   cosmic-bg 
  #   cosmic-comp 
  #   cosmic-icons 
  #   cosmic-launcher
  #   cosmic-notifications 
  #   cosmic-osd 
  #   cosmic-panel
  #   cosmic-session 
  #   cosmic-settings 
  #   cosmic-settings-daemon 
  #   cosmic-workspaces-epoch 
  #   xdg-desktop-portal-cosmic 
  #   cosmic-greeter
  #   cosmic-protocols 
  #   cosmic-edit
  #   cosmic-screenshot 
  #   cosmic-design-demo 
  #   cosmic-term 
  #   cosmic-randr
  #   cosmic-files 
  # ];
}
