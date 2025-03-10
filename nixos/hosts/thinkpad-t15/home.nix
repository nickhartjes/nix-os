##################
## Hardware specific applications
##################

{ pkgs, inputs, ... }:

{
  imports =
    [
      # ../../modules/desktop/hyprland/home.nix
    ];

  home = {
    packages = with pkgs; [
      # Display
      light                              # xorg.xbacklight not supported. Other option is just use xrandr.
      # Power Management
      #auto-cpufreq                       # Power management
      tlp                                # Power management

      #kanshi
    ];
  };

  programs = {
  };

  services = {
    # blueman-applet.enable = true;
  };
}
