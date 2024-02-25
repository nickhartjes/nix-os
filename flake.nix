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

      home-manager = {                                                      # User Package Management
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {
        url = "github:nix-community/NUR";                                   # NUR packages
      };

      #hyprland.url = "github:hyprwm/Hyprland";
      hyprland.url = "github:hyprwm/Hyprland/a42b984f51a00e88a13a45e1b5e9e3d4ec470254";
      split-monitor-workspaces = {
        url = "github:Duckonaut/split-monitor-workspaces/2b1abdbf9e9de9ee660540167c8f51903fa3d959";
        #url = "github:zjeffer/split-monitor-workspaces";
        inputs.hyprland.follows = "hyprland";
      };
    };

  outputs = inputs @ { 
    self, 
    nixpkgs, 
    home-manager, 
    nur,
    split-monitor-workspaces,
    ... 
  }:      # Function that tells my flake which to use and what do what to do with the dependencies.
    let                                                                     # Variables that can be used in the config files.
      user = "nh";
      location = "$HOME/.setup";
    in                                                                      # Use above variables in ...
    {
      nixosConfigurations = (                                               # NixOS configurations
        import ./nixos/hosts {                                                    # Imports ./hosts/default.nix
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager split-monitor-workspaces nur user location;            # Also inherit home-manager so it does not need to be defined here.
        }
      );

      homeConfigurations = (                                                # Non-NixOS configurations
        import ./nixos/nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager user;
        }
      );
    };
}
