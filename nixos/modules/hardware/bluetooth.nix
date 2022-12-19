#
# Bluetooth
#

{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    hsphfpd.enable = false;         # HSP & HFP daemon
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
}
