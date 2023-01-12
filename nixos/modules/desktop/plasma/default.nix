{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    xserver = {
      enable = true;                    # Display Manager
#      defaultSession = "plasmawayland";
      displayManager = {                          # Display Manager
        autoLogin = {
          enable = false;
          user = "nh";
        };
        sddm = {
          enable = true;                          # Wallpaper and gtk theme
#          greeters = {
#            mini = {
#              enable = true;
#              user = "your-username";
#              extraConfig = ''
#                  [greeter]
#                  show-password-label = false
#                  [greeter-theme]
#                  background-image = ""
#              '';
#            };
#          };
        };
      };
      desktopManager= {
        plasma5 = {                                 # Window Manager
          enable = true;
        };
      };
    };
  };

  programs.zsh.enable = true;                     # Weirdly needs to be added to have default user on lightdm

  environment.systemPackages = with pkgs; [       # Packages installed
    plasma-theme-switcher
    layan-kde
    materia-theme
    materia-kde-theme
    material-design-icons
    arc-kde-theme
    adapta-kde-theme
    graphite-kde-theme
    nordic
    sierra-breeze-enhanced

    # KDE Fonts
    oxygenfonts
    iosevka

    ark # Archive utility

    plasma-integration
    plasma-applet-caffeine-plus
    plasma-thunderbolt

    libsForQt5.bismuth
    libsForQt5.plasma-workspace
    libsForQt5.plasma-workspace-wallpapers
  ];
}
