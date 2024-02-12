{ lib, inputs, nixpkgs, home-manager, split-monitor-workspaces, nur, user, location, ... }:

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
      nur.nixosModules.nur
      ./desktop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
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
      nur.nixosModules.nur
      ./xps-laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
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
      nur.nixosModules.nur
      ./thinkpad
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
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
    specialArgs = { inherit inputs user location split-monitor-workspaces; };
    modules = [
      nur.nixosModules.nur
      ./thinkpad-t15
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./thinkpad-t15/home.nix)];
          wayland.windowManager.hyprland = {
            enable = true;
            settings = {
              decoration = {
                shadow_offset = "0 5";
                "col.shadow" = "rgba(00000099)";
              };
              plugin = {
                  split-monitor-workspaces = {
                      count = 10;
                      keep_focused = true;
                  };
              };
              "$mod" = "SUPER";
              bind =
                [ 
                  "$mod, F, exec, firefox"
                  ", Print, exec, grimblast copy area"
                ]
                ++ (
                  # workspaces
                  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
                  builtins.concatLists (builtins.genList (
                      x: let
                        ws = let
                          c = (x + 1) / 10;
                        in
                          builtins.toString (x + 1 - (c * 10));
                      in [
                        "$mod, ${ws}, workspace, ${toString (x + 1)}"
                        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                      ]
                    )
                  10)
                );
            };
            plugins = [
              split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
            ];
          };
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
      nur.nixosModules.nur
      ./vm
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./vm/home.nix)];
        };
      }
    ];
  };
}
