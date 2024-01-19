{ config, pkgs, user, hyprland, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/desktop/gnome/default.nix)] ++
#    [(import ../../modules/desktop/plasma/default.nix)] ++
#    [(import ../../modules/desktop/sway/default.nix)] ++
#    [(import ../../modules/desktop/hyprland-nvidia/default.nix)] ++
    (import ../../modules/desktop/virtualisation) ++
#    [(import ../../modules/hardware/displaylink.nix)] ++
    (import ../../modules/hardware);

    ##################
    ## System boot
    ##################

    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot";
    
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

    networking.hostName = "thinkpad-t15";

    services.xserver.videoDrivers = [ "modesetting" ];

    # Enable automatic login for the user.
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "nh";

    programs = {
      light.enable = true;                    # No xbacklight, this is the alterantive
    };

    services = {
     logind.lidSwitch = "ignore";            # Laptop does not go to sleep when lid is closed
      auto-cpufreq.enable = true;             # Enable auto-cpufreq daemon
      hardware.bolt.enable = true;
    };
}
