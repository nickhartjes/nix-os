#  __   __   __    __
# |  \ |  | |  |  |  |
# |   \|  | |  |__|  |  Nick Hartjes
# |    `  | |   __   |  https://nickhartjes.nl
# |  |\   | |  |  |  |  https://github.com/nickhartjes/
# |__| \__| |__|  |__|
#
{
  description = "NH System Flake Configuration";

  inputs =                                                                  # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";                  # Nix Packages
#      nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";                  # Nix Packages

      home-manager = {                                                      # User Package Management
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {
        url = "github:nix-community/NUR";                                   # NUR packages
      };

      hyprland = {
          url = "github:hyprwm/Hyprland";
          inputs.nixpkgs.follows = "nixpkgs";
        };

      # nixgl = {                                                             # OpenGL
      #   url = "github:guibou/nixGL";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };
    };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, hyprland, ... }:      # Function that tells my flake which to use and what do what to do with the dependencies.
    let                                                                     # Variables that can be used in the config files.
      user = "nh";
      location = "$HOME/.setup";
    in                                                                      # Use above variables in ...
    {
      nixosConfigurations = (                                               # NixOS configurations
        import ./nixos/hosts {                                                    # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user location hyprland;            # Also inherit home-manager so it does not need to be defined here.
        }
      );

      homeConfigurations = (                                                # Non-NixOS configurations
        import ./nixos/nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user hyprland;
        }
      );
    };
}
