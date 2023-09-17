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
     #  k3s
    ];
  };

  programs = {
  };
  services = {
  };
}
