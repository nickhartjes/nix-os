{ lib, inputs, nixpkgs, home-manager, split-monitor-workspaces, nur, user, location, nixos-cosmic,... }:

let
  # System architecture
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    # Allow proprietary software
    config.allowUnfree = true;
  };

  hyprlandSettings = {
    animations = {
      bezier = [
        "overshot, 0.05, 0.9, 0.1, 1.05"
        "smoothOut, 0.5, 0, 0.99, 0.99"
        "smoothIn, 0.5, -0.5, 0.68, 1.5"
      ];
      animation = [
        "windows, 1, 5, overshot, slide"
        "windowsOut, 1, 3, smoothOut"
        "windowsIn, 1, 3, smoothOut"
        "windowsMove, 1, 4, smoothIn, slide"
        "border, 1, 5, default"
        "fade, 1, 5, smoothIn"
        "fadeDim, 1, 5, smoothIn"
        "workspaces, 1, 6, default"
      ];
    };
    monitor = [
      "HDMI-A-1,2560x1440,auto,1,bitdepth,10"
      "DP-3,2560x1440,auto,1,bitdepth,10"
    ];
    xwayland = {
      force_zero_scaling = "true";
    };
    input = {
      kb_layout = "us";
      follow_mouse=1;
      touchpad = {
        natural_scroll = "no";
      };
      sensitivity=0; 
    };
    decoration = {
      rounding = 3;
      blur = {
        enabled = true;
        size = 4;
      };
      shadow_offset = "5 5";
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
       # "$mod,P,exec,wofi --style ~/.config/wofi/style.css --conf ~/.config/wofi/config"
        "$mod,P,exec,rofi -show drun -replace -i"
        "$mod,S,exec,grim -t jpeg -q 80 -g \"$(slurp)\" - | swappy -f -"
        "$mod SHIFT,w,exec, ~/.settings/scripts/wallpaper.sh"


        "$mod,h,movefocus,l"
        "$mod,l,movefocus,r"
        "$mod,j,movefocus,u"
        "$mod,k,movefocus,d"

        "$mod SHIFT,h,movewindow,l"
        "$mod SHIFT,l,movewindow,r"
        "$mod SHIFT,j,movewindow,u"
        "$mod SHIFT,k,movewindow,d"

        #"$mod CTRL,h,split-changemonitor,prev"
        #"$mod CTRL,l,split-changemonitor,next"

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
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              # "$mod, ${ws}, split-workspace, ${toString (x + 1)}"
              # "$mod SHIFT, ${ws}, split-movetoworkspace, ${toString (x + 1)}"
            ]
          )
        10)
      );
    binde = 
      [
        ",XF86AudioRaiseVolume, exec, volumectl -u up"
        ",XF86AudioLowerVolume, exec, volumectl -u down"
    ];
    bindm = 
      [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindown"
    ];
    bindl = 
      [
        ",switch:on:Lid Switch,exec,hyprctl keyword monitor 'eDP-1, disable'"
        ",switch:off:Lid Switch,exec,hyprctl keyword monitor 'eDP-1, 1980x1080, 0x0, 1'"
    ];
    exec-once = [
      "avizo-service"
      "swww-daemon"
      "kanshi -c ~/.config/kanshi/config"
      "pypr"
      "~/.settings/scripts/wallpaper.sh"
      "dunst"
      "wl-paste --watch cliphist store"
      "hypridle"
    ];
    windowrulev2 = [
      "opacity 0.9 0.9,title:wofi"
      "opacity 0.9 0.9,class:kitty-dropterm"
      "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
      "noanim,class:^(xwaylandvideobridge)$"
      "noinitialfocus,class:^(xwaylandvideobridge)$"
      "maxsize 1 1,class:^(xwaylandvideobridge)$"
      "noblur,class:^(xwaylandvideobridge)$"
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
    specialArgs = { inherit inputs user location split-monitor-workspaces; };
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
  ## Thinkpad T15 Profile
  ##################
  thinkpad-t15 = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user location split-monitor-workspaces; };
    modules = [
      nur.nixosModules.nur
      ./thinkpad-t15
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
        home-manager.extraSpecialArgs = { inherit user; };
        home-manager.users.${user} = {
          imports = [(import ./home.nix)] ++ [(import ./thinkpad-t15/home.nix)];
          wayland.windowManager.hyprland = {
            enable = true;
            settings =  hyprlandSettings;
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
