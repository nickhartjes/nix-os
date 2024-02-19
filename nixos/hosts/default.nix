{ lib, inputs, nixpkgs, home-manager, split-monitor-workspaces, nur, user, location, ... }:

let
  # System architecture
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    # Allow proprietary software
    config.allowUnfree = true;
  };

    hyprlandSettings = {
    monitor = [
      "HDMI-A-1,2560x1440,auto,1"
      "DP-3,2560x1440,auto,1"
    ];
    decoration = {
      rounding = 3;
      shadow_offset = "1 5";
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
        "$mod,B,exec,chromium"
        "$mod SHIFT,RETURN,exec,alacritty"
        "$mod,RETURN,exec,pypr toggle term"
        "$mod,F,fullscreen"
        "$mod,Q,killactive"
        "$mod SHIFT,Q,exec,wlogout --protocol layer-shell"
        "$mod,E,exec,dolphin"
        "$mod,V,togglefloating"
        "$mod,P,exec,wofi --style ~/.config/wofi/style.css --conf ~/.config/wofi/config"
        "$mod,S,exec,grim -t jpeg -q 10 -g \"$(slurp)\" - | swappy -f -"

        "$mod,h,movefocus,l"
        "$mod,l,movefocus,r"
        "$mod,j,movefocus,u"
        "$mod,k,movefocus,d"

        "$mod SHIFT,h,movewindow,l"
        "$mod SHIFT,l,movewindow,r"
        "$mod SHIFT,j,movewindow,u"
        "$mod SHIFT,k,movewindow,d"

        "$mod CTRL,h,split-changemonitor,prev"
        "$mod CTRL,l,split-changemonitor,next"

        ",XF86AudioMute, exec, volumectl toggle-mute"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86MonBrightnessUp, exec,  lightctl up"
        ",XF86MonBrightnessDown, exec, lightctl down"

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
              "$mod, ${ws}, split-workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, split-movetoworkspace, ${toString (x + 1)}"
            ]
          )
        10)
      );
    binde = 
      [
        ",XF86AudioRaiseVolume, exec, volumectl -u up"
        ",XF86AudioLowerVolume, exec, volumectl -u down"
    ];
    exec-once = [
      "avizo-service"
      "kanshi -c ~/.config/kanshi/config"
      "pypr"
      "blueman-applet"
      "~/.config/sway/random-background.sh"
      "waybar"
    ];
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
          wayland.windowManager.hyprland = {
            enable = true;
            settings = hyprlandSettings;
            plugins = [
              split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
            ];
          };
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
            settings =  hyprlandSettings;
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
