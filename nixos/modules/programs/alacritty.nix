#
# Terminal Emulator
#

{ pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
#      settings = {
#        window.opacity: "0.9";
#        font = rec {                          # Font - Laptop has size manually changed at home.nix
#          normal.family = "Source Code Pro";
#          bold = { style = "Bold"; };
#          size = 10;
#        };
#        offset = {                            # Positioning
#          x = 0;
#          y = 0;
#        };
#      };
    };
  };
}
