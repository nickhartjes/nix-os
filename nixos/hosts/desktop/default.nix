{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/desktop/plasma/default.nix)] ++
    [(import ../../modules/desktop/sway/default.nix)] ++
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
    boot.initrd.luks.devices."luks-cff073f3-f4ca-43d2-b4d4-66d6f96abbbe".device = "/dev/disk/by-uuid/cff073f3-f4ca-43d2-b4d4-66d6f96abbbe";
    boot.initrd.luks.devices."luks-cff073f3-f4ca-43d2-b4d4-66d6f96abbbe".keyFile = "/crypto_keyfile.bin";
    #boot.initrd.kernelModules = [ "amdgpu" ];

    # Setup keyfile
    boot.initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };

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
#      xserver.videoDrivers = [ "amdgpu" ];
    };
}
