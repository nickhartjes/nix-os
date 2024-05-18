{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/programs/display-managers/greetd.nix)] ++
    [(import ../../modules/desktop/plasma/default.nix)] ++
    [(import ../../modules/desktop/cosmic/default.nix)] ++
    (import ../../modules/desktop/virtualisation) ++
    (import ../../modules/hardware);

    ##################
    ## System boot
    ##################

    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    # Enable swap on luks
    boot.initrd.kernelModules = [ "amdgpu" ];


    ##################
    ## Hardware specific sytem settings
    ##################

    # Enable networking
    networking.networkmanager.enable = true;
    networking.hostName = "desktop";

    environment = {
      systemPackages = [
      ];
    };

    programs = {
    };

    services = {
      xserver.videoDrivers = [ "amdgpu" ];
    };
}
