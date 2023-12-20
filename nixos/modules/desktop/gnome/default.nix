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
    arc-theme
    fira
    gnome-extension-manager
    gnome-firmware
    gnome-icon-theme
    gnome.adwaita-icon-theme
    gnome.gnome-tweaks
    gnome.gnome-settings-daemon
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.cpufreq
#    gnomeExtensions.espresso
    gnomeExtensions.forge
#    gnomeExtensions.freon
    gnomeExtensions.paperwm
#    gnomeExtensions.timepp
    layan-gtk-theme
#    materia-theme
    pop-gtk-theme
    pop-icon-theme
    roboto-slab
    ulauncher
    vimix-gtk-themes
    yaru-theme
    zuki-themes
    lm_sensors
    gnome-multi-writer
    gnome.pomodoro
    gnome-solanum
    #corectrl
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    # Service to start
    systemd.user.services.ulauncher = {
      enable = true;
      description = "Start Ulauncher";
      script = "${pkgs.ulauncher}/bin/ulauncher --hide-window";

      documentation = [ "https://github.com/Ulauncher/Ulauncher/blob/f0905b9a9cabb342f9c29d0e9efd3ba4d0fa456e/contrib/systemd/ulauncher.service" ];
      wantedBy = [ "graphical.target" "multi-user.target" ];
      after = [ "display-manager.service" ];
    };
}
