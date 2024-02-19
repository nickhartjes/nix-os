#
# Waybar
#

{ config, lib, pkgs, ... }:

{
  #  Needed for waybar to show wlr/workspaces
  nixpkgs.overlays = [(
    self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    }

  )];  
  
  programs = {
    waybar = {
      enable = true;
      # systemd = {
      #   enable = true;
      # };
    };
  };
}
