{ config, pkgs, user, lib, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/programs/display-managers/greetd.nix)] ++
    [(import ../../modules/desktop/plasma/default.nix)] ++
    #[(import ../../modules/desktop/gnome/default.nix)] ++
    [(import ../../modules/desktop/hyprland/default.nix)] ++
    [(import ../../modules/desktop/sway/default.nix)] ++
    # [(import ../../modules/desktop/cosmic/default.nix)] ++
    (import ../../modules/desktop/virtualisation) ++
    (import ../../modules/gaming) ++
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

    xdg.portal.wlr.enable = lib.mkForce false;

    services.rpcbind.enable = true; # needed for NFS
    systemd.mounts = [{
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "server:/10.0.20.100/data";
      where = "/mnt/data";
    }];

    systemd.automounts = [{
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/mnt/data";
    }];
}
