{ lib, inputs, nixpkgs, home-manager, nur, user, location, nixos-cosmic, ... }:

let
  # System architecture
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    # Allow proprietary software
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in
{

  ##################
  ## Desktop Profile
  ##################

  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      nur.modules.nixos.default      ./desktop
      ./configuration.nix

      {
        nix.settings = {
          substituters = [ "https://cosmic.cachix.org/" ];
          trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
        };
      }
      nixos-cosmic.nixosModules.default

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./desktop/home.nix)];
        };
      }
   ];
   };


  ##################
  ## XPS Profile
  ##################
  xps-laptop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      nur.modules.nixos.default      ./xps-laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./xps-laptop/home.nix)];
        };
      }
    ];
  };

  ##################
  ## Thinkpad Profile
  ##################
  thinkpad = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      nur.modules.nixos.default      ./thinkpad
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./thinkpad/home.nix)];
        };
      }
    ];
  };

  ##################
  ## Thinkpad T15 Profile
  ##################
  thinkpad-t15 = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      nur.modules.nixos.default      ./thinkpad-t15
      ./configuration.nix

      {
        nix.settings = {
          substituters = [ "https://cosmic.cachix.org/" ];
          trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
        };
      }
      nixos-cosmic.nixosModules.default

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./thinkpad-t15/home.nix)];
        };
      }
    ];
  };

  ##################
  ## Minisforum 773-lite Profile
  ##################
  "773-lite" = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      nur.modules.nixos.default      ./773-lite
      ./configuration.nix

      {
        nix.settings = {
          substituters = [ "https://cosmic.cachix.org/" ];
          trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
        };
      }
      nixos-cosmic.nixosModules.default

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./773-lite/home.nix)];
        };
      }
    ];
  };


  ##################
  ## VM Profile
  ##################
  vm = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location; };
    modules = [
      nur.modules.nixos.default      ./vm
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./vm/home.nix)];
        };
      }
    ];
  };
}

