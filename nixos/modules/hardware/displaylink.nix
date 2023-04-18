{ config, lib, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  environment = {
    systemPackages = with pkgs; [                 # Package dependencies
      displaylink
      linuxKernel.packages.linux_6_2.evdi
    ];
  };
}

