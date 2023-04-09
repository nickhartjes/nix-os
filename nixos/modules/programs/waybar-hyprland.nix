#
# Waybar
#

{ config, lib, pkgs, ... }:

{
  #  Needed for waybar to show wlr/workspaces
  nixpkgs.overlays = [(
    self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    }
  )];

  programs = {
    waybar = {
      enable = true;
#      systemd.enable = true;
#      style = ''
#        ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
#
#        window#waybar {
#          background: transparent;
#          border-bottom: none;
#        }
#      '';
#      settings = [{
#        mainBar = {
#          layer = "top";
#          position = "top";
#          height = 30;
#          output = [
#            "eDP-1"
#            "HDMI-A-1"
#          ];
#          modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
#          modules-center = [ "sway/window" "custom/hello-from-waybar" ];
#          modules-right = [ "mpd" "custom/mymodule#with-css-id" "temperature" ];
#
#          "sway/workspaces" = {
#            disable-scroll = true;
#            all-outputs = true;
#          };
#          "custom/hello-from-waybar" = {
#            format = "hello {}";
#            max-length = 40;
#            interval = "once";
#            exec = pkgs.writeShellScript "hello-from-waybar" ''
#              echo "from within waybar"
#            '';
#          };
#        };
#      }];
    };
  };
}
