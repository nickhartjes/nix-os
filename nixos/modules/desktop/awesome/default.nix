{ config, lib, pkgs, ... }:

{


  hardware.opengl.enable = true;
  hardware.pulseaudio.enable = true;

  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      displayManager.defaultSession = "xfce+awesome";
      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks # is the package manager for Lua modules
          luadbi-mysql # Database abstraction layer
        ];
      };
    };
    blueman.enable = true;
    mpd.extraConfig = ''
      audio_output {
        type "pulse"
        name "My PulseAudio" # this can be whatever you want
      }
    '';
  };


  programs.zsh.enable = true;

  programs.nm-applet.enable = true;
  programs.nm-applet.indicator = true;
  environment = {
    systemPackages = with pkgs; [       # Packages installed
      arandr
      lxappearance
      dex
      picom

      ulauncher
      caffeine-ng
      mpd

      libgnome-keyring
      rofi
      feh
      variety

      rxvt-unicode-emoji

      python310Packages.semver
      python310Packages.pytz
      python310Packages.github3_py

      xfce.thunar-archive-plugin
      xfce.thunar-volman
      xfce.xfce4-pulseaudio-plugin
      xfce.xfce4-power-manager
      xfce.ristretto
      xarchiver

      volumeicon
    ];
  };

  programs = {
#    hyprland.enable = true;
  };
}
