#
#  Screen color temperature changer
#
{ config, lib, pkgs, ...}:

{
  config = lib.mkIf (config.xsession.enable) {      # Only evaluate code if using X11
    services = {
      redshift = {
        enable = true;
        temperature.night = 3000;
        latitude = 52.373882;
        longitude = 4.891711;
      };
    };
  };
}
