{ config, lib, pkgs, hyprland, ... }:

{

  imports = [
    ../hyprland/default.nix
  ];


  programs = {
    hyprland = {
      enable = true;
      nvidiaPatches = true;
    };
  };
}
