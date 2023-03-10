#
# Chromium
#

{ config, lib, pkgs, ... }:

{
  programs = {
    chromium = {
      enable = true;
      # package = pkgs.chromium; #If enabled the commandLineArgs don't work
      # package = pkgs.brave; #If enabled the commandLineArgs don't work
      extensions = [
        "blipmdconlkpinefehnmjammfjpmpbjk" # Lighthouse
        "bcjindcccaagfpapjjmafapmmgkkhgoa" # JSON Formatter
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "mlomiejdfkolichcflejclcbmpeaniij" # Ghostery
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "mapjgeachilmcbbokkgcbgpbakaaeehi" # Omni
        "cimiefiiaegbelhefglklhhakcgmhkai" # Plasma Integration
      ];
      commandLineArgs = [
        "--homepage='tweakers.net'"
        "--force-dark-mode"
      ];
    };
  };
}
