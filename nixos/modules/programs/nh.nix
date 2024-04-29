#
#  NH
#

{ config, lib, pkgs, nur, ... }:

{

  home.packages = with pkgs; [       # Packages installed
    nh
  ];

  # programs = {
  #   nh = {
  #     enable = true;
  #     clean.enable = true;
  #     clean.extraArgs = "--keep-since 4d --keep 3";
  #     # flake = "/home/user/my-nixos-config";
  #   };
  # };
}
