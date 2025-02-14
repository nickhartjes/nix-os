#  __   __   __    __
# |  \ |  | |  |  |  |
# |   \|  | |  |__|  |  Nick Hartjes
# |    `  | |   __   |  https://nickhartjes.nl
# |  |\   | |  |  |  |  https://github.com/nickhartjes/
# |__| \__| |__|  |__|
#
{
  description = "NH System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    templ.url = "github:a-h/templ";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = { url = "github:nix-community/NUR"; };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = { url = "github:0xc000022070/zen-browser-flake"; };
    ags = { url = "github:Aylur/ags"; };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, nixos-cosmic, zen-browser, ags, ... }:
    let
      user = "nh";
      location = "$HOME/.setup";
    in {
      nixpkgs.overlays = [
        (final: prev: {
          lldb = prev.lldb.overrideAttrs (old: {
            dontCheckForBrokenSymlinks = true;
          });
        })
      ];

      nixosConfigurations = (
        import ./nixos/hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user location nixos-cosmic zen-browser;
        }
      );

      homeConfigurations = (
        import ./nixos/nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user;
        }
      );
    };
}
