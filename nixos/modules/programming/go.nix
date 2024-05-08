#
# Go
#

{ config, lib, pkgs, ... }:

  home.packages = with pkgs; [       # Packages installed
    go
    air
  ];

{
  programs = {
  };
}
