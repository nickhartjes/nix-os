#
#  Hyprland NixOS & Home manager configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./laptop
#   │       └─ home.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./hyprland
#               └─ home.nix *
#

{ config, lib, pkgs, ... }:

{
#  home.file = {
#    ".config/waybar/hyprland.conf".text = ''
#      monitor=DP-2,1920x1080@60,0x0,1
#      monitor=HDMI-A-2,1920x1080@60,1920x0,1
#      monitor=HDMI-A-1,1280x1028@60,3840x0,1
#    '';
#  };
}
