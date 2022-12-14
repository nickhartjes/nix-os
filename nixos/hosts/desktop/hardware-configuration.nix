# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
#  boot.extraModulePackages = [ ];
#  boot.extraModulePackages = with config.boot.kernelPackages; [ rtl88x2bu ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d1aed799-469d-4d80-876c-6cda665842f5";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-56d45ced-bf53-4ce7-bcd2-f57375a2b702".device = "/dev/disk/by-uuid/56d45ced-bf53-4ce7-bcd2-f57375a2b702";

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/18F1-7DD9";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/48ef386d-31c8-4ffd-88ae-7f258f17db1a"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp42s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
