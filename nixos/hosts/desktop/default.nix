{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/programs/display-managers/sddm.nix)] ++
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
    boot.initrd.kernelModules = [ "amdgpu" ];

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

    # networking.firewall.allowedTCPPorts = [ 6443 ];
    # services.k3s.enable = true;
    # services.k3s.role = "server";
    # services.k3s.extraFlags = toString [
    #   # "--kubelet-arg=v=4" # Optionally add additional args to k3s
    # ];

    environment = {
      systemPackages = [
      ];
    };

    programs = {
    };

    services = {
      xserver.videoDrivers = [ "amdgpu" ];
      blueman.enable = true;
    };
}
