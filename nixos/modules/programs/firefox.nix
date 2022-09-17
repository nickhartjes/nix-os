#
# Chromium
#

{ config, lib, pkgs, nur, ... }:

{

#   modules = [
#          nur.nixosModules.nur
#  ];
#environment = {
#      systemPackages = [
#       config.nur.repos.rycee.firefox-addons.bitwarden];
#    };
  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox.override {
        # See nixpkgs' firefox/wrapper.nix to check which options you can use
        cfg = {
          # Gnome shell native connector
          enableGnomeExtensions = true;
          # Tridactyl native connector
          enableTridactylNative = true;
        };
      };
#      extensions =  [
#        config.nur.repos.rycee.firefox-addons.bitwarden
#     ];
    };
  };
#  home.packages = with pkgs; [
#    config.nur.repos.rycee.firefox-addons.ublock-origin
#    config.nur.repos.rycee.firefox-addons.surfingkeys
#    config.nur.repos.rycee.firefox-addons.tomato-clock
#  ];

}
