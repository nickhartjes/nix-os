#
# Terminal Emulator
#

{ pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = rec {                          # Font - Laptop has size manually changed at home.nix
          normal.family = "Source Code Pro";
          bold = { style = "Bold"; };
          size = 10;
        };
        offset = {                            # Positioning
          x = 0;
          y = 0;
        };
      };
    };
  };
}
