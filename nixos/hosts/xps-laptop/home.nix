##################
## Hardware specific applications
##################

{ pkgs, ... }:

{
  imports =
    [
    ];

  home = {
    packages = with pkgs; [
      # Display
      light                              # xorg.xbacklight not supported. Other option is just use xrandr.

      # Power Management
      auto-cpufreq                       # Power management
      tlp                                # Power management
    ];
  };

  programs = {
  };

  services = {
  };
}
