{ config, pkgs, user, hyprland, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/desktop/sway/default.nix)] ++
    (import ../../modules/desktop/virtualisation) ++
#    [(import ../../modules/hardware/displaylink.nix)] ++
    (import ../../modules/hardware);

    ##################
    ## System boot
    ##################

    #boot.kernelPackages = pkgs.linuxPackages_latest;
    #boot.kernelPackages = pkgs.linuxPackages_hardkernel_latest;

     boot.kernelPackages = pkgs.linuxPackages_latest.extend (self: super: {
        evdi = super.evdi.overrideAttrs (o: rec {
          src = pkgs.fetchFromGitHub {
            owner = "DisplayLink";
            repo = "evdi";
            rev = "bdc258b25df4d00f222fde0e3c5003bf88ef17b5";
            sha256 = "mt+vEp9FFf7smmE2PzuH/3EYl7h89RBN1zTVvv2qJ/o=";
          };
        });
    });

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    # Setup keyfile
    boot.initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };

    # Enable swap on luks
    boot.initrd.luks.devices."luks-b4067d27-b4d7-423a-a223-c5f447a202dc".device = "/dev/disk/by-uuid/b4067d27-b4d7-423a-a223-c5f447a202dc";
    boot.initrd.luks.devices."luks-b4067d27-b4d7-423a-a223-c5f447a202dc".keyFile = "/crypto_keyfile.bin";

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


    programs = {
      light.enable = true;                    # No xbacklight, this is the alterantive
    };

    services = {
      xserver.videoDrivers = [ "displaylink" "modesetting" ];
      logind.lidSwitch = "ignore";            # Laptop does not go to sleep when lid is closed
      auto-cpufreq.enable = true;             # Enable auto-cpufreq daemon
      hardware.bolt.enable = true;
    };
}
