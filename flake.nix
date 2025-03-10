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
    # marble = {
    #   url = "git+ssh://git@github.com/marble-shell/shell.git";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
     hy3 = {
      url = "github:outfoxxed/hy3"; # where {version} is the hyprland release version
      # or "github:outfoxxed/hy3" to follow the development branch.
      # (you may encounter issues if you dont do the same for hyprland)
      inputs.hyprland.follows = "hyprland";
    };
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, nixos-cosmic, zen-browser, hyprland, hy3, hyprpanel, ... }:
    let
      user = "nh";
      location = "$HOME/.setup";
      system = "x86_64-linux";
      
      # Function to create system-specific pkgs with overlays
      mkPkgs = system: overlays: import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "adobe-reader-9.5.5"
          ];
        };
        inherit overlays;
      };

      # Common overlays
      commonOverlays = [
        (final: prev: {
          lldb = prev.lldb.overrideAttrs (old: {
            dontCheckForBrokenSymlinks = true;
          });
        })
      ];

    in {
      nixosConfigurations = (
        import ./nixos/hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user location nixos-cosmic zen-browser hyprland hy3 hyprpanel;
          commonPkgs = mkPkgs system commonOverlays;
          hyprPkgs = mkPkgs system (commonOverlays ++ [ inputs.hyprpanel.overlay ]);
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
