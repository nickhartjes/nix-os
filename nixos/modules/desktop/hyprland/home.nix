#
#  Hyprland NixOS & Home manager configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./laptop
#   │       └─ home.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./hyprland
#               └─ home.nix *
#

{ config, lib, pkgs, inputs, hy3, ... }: {
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      hy3.packages.x86_64-linux.hy3
    ];
  };

  programs.hyprpanel = {
    # Enable the module.
    # Default: false
    enable = true;

    # Automatically restart HyprPanel with systemd.
    # Useful when updating your config so that you
    # don't need to manually restart it.
    # Default: false
    systemd.enable = true;

    # Add '/nix/store/.../hyprpanel' to your
    # Hyprland config 'exec-once'.
    # Default: false
    hyprland.enable = true;

    # Fix the overwrite issue with HyprPanel.
    # See below for more information.
    # Default: false
    overwrite.enable = true;

    # Import a theme from './themes/*.json'.
    # Default: ""
    theme = "gruvbox_split";

    # Override the final config with an arbitrary set.
    # Useful for overriding colors in your selected theme.
    # Default: {}
    override = {
      theme.bar.menus.text = "#123ABC";
    };

    # Configure bar layouts for monitors.
    # See 'https://hyprpanel.com/configuration/panel.html'.
    # Default: null
    layout = {
      "bar.layouts" = {
        "0" = {
          left = [ "dashboard" "workspaces" ];
          middle = [ "media" ];
          right = [ "volume" "systray" "notifications" ];
        };
      };
    };

    # Configure and theme almost all options from the GUI.
    # Options that require '{}' or '[]' are not yet implemented,
    # except for the layout above.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };
}
