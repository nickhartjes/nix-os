#
# Proton
#

{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [       # Packages installed
#    protonvpn-gui
    protonvpn-cli
    protonmail-bridge
#    dbus
  ];
}
