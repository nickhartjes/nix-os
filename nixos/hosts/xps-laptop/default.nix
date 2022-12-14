{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/desktop/plasma/default.nix)] ++
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
    boot.initrd.luks.devices."luks-7c638060-9787-4d14-8478-5a7c22c4eb0b".device = "/dev/disk/by-uuid/7c638060-9787-4d14-8478-5a7c22c4eb0b";
    boot.initrd.luks.devices."luks-7c638060-9787-4d14-8478-5a7c22c4eb0b".keyFile = "/crypto_keyfile.bin";

    # Setup keyfile
    boot.initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };

    ##################
    ## Hardware specific sytem settings
    ##################

    # Enable networking
    networking.networkmanager.enable = true;
    networking.wireless.iwd.enable = true;
    networking.networkmanager.wifi.backend = "iwd";

    networking.hostName = "xps-laptop";

    # Enable OpenGl for Nvidia https://nixos.wiki/wiki/Nvidia
    #hardware.opengl.enable = true;

    environment = {
      systemPackages = with pkgs; [
      ];
    };

    programs = {
      light.enable = true;                    # No xbacklight, this is the alterantive
    };

    services = {
      logind.lidSwitch = "ignore";            # Laptop does not go to sleep when lid is closed
      auto-cpufreq.enable = true;             # Enable auto-cpufreq daemon
    };
}
