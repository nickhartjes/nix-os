#
# Ghostty terminal emulator configuration
#

{ config, pkgs, ghostty, ... }:

{
  environment = {
    systemPackages = [
      ghostty.packages.x86_64-linux.default
    ];
  };
}
