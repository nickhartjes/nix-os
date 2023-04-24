{ config, lib, pkgs, hyprland, ... }:

{
  programs.zsh.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  xdg.portal.wlr.enable;
}
