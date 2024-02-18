{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      displayManager = {                          # Display Manager
        gdm = {
          enable = true;                          # Wallpaper and gtk theme
        };
#        defaultSession = "gnome";            # none+bspwm -> no real display manager
      };
      desktopManager= {
        gnome = {                                 # Window Manager
          enable = true;
        };
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };
  };

  programs.zsh.enable = true;                     # Weirdly needs to be added to have default user on lightdm

  hardware.pulseaudio.enable = false;

  environment.systemPackages = with pkgs; [       # Packages installed
    cosmic-panel
    cosmic-applets 
    cosmic-applibrary 
    cosmic-bg 
    cosmic-comp 
    cosmic-icons 
    cosmic-launcher
    cosmic-notifications 
    cosmic-osd 
    cosmic-panel
    cosmic-session 
    cosmic-settings 
    cosmic-settings-daemon 
    cosmic-workspaces-epoch 
    xdg-desktop-portal-cosmic 
    cosmic-greeter
    cosmic-protocols 
    cosmic-edit
    cosmic-screenshot 
    cosmic-design-demo 
    cosmic-term 
    cosmic-randr
    cosmic-files 
  ];
}
