{ config, pkgs, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/desktop/plasma/default.nix)] ++
    (import ../../modules/desktop/virtualisation) ++
    [(import ../../modules/hardware/displaylink.nix)] ++
    (import ../../modules/hardware);

    ##################
    ## System boot
    ##################

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

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

    networking.hostName = "thinkpad";

    # Enable OpenGl for Nvidia https://nixos.wiki/wiki/Nvidia
    #hardware.opengl.enable = true;

    environment = {
      systemPackages = with pkgs; [
        displaylink
      ];
    };

    programs = {
      light.enable = true;                    # No xbacklight, this is the alterantive
    };

    services = {
      xserver.videoDrivers = [ "nvidia" "displaylink" "modesetting" ];
      logind.lidSwitch = "ignore";            # Laptop does not go to sleep when lid is closed
      auto-cpufreq.enable = true;             # Enable auto-cpufreq daemon
    };
}
