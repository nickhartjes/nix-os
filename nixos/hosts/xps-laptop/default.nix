{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/desktop/hyprland-nvidia/default.nix)] ++
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
    boot.initrd.luks.devices."luks-0aec15c8-9f38-482a-9a6c-0446cb999ca9".device = "/dev/disk/by-uuid/0aec15c8-9f38-482a-9a6c-0446cb999ca9";
    boot.initrd.luks.devices."luks-0aec15c8-9f38-482a-9a6c-0446cb999ca9".keyFile = "/crypto_keyfile.bin";

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
    # hardware.opengl.enable = true;
    hardware.nvidia.modesetting.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];

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
