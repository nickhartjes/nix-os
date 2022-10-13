{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    xserver = {
      enable = true;
      libinput.enable = true;
      displayManager.lightdm.enable = true;
      desktopManager = {
        cinnamon.enable = true;
      };
      displayManager.defaultSession = "cinnamon";
    };
  };

  programs.zsh.enable = true;                     # Weirdly needs to be added to have default user on lightdm

  hardware.pulseaudio.enable = false;

  environment.systemPackages = with pkgs; [       # Packages installed
  ];
}
