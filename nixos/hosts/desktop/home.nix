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
        linuxPackages.rtl88x2bu
    ];
  };

  programs = {
  };

  services = {
  };
}
