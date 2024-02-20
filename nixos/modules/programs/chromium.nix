#
# Chromium
#

{ config, lib, pkgs, ... }:

{
  programs = {
    chromium = {
      enable = true;
      # package = pkgs.google-chrome; #If enabled the commandLineArgs don't work
      # package = pkgs.brave; #If enabled the commandLineArgs don't work
      extensions = [
        "blipmdconlkpinefehnmjammfjpmpbjk" # Lighthouse
        "bcjindcccaagfpapjjmafapmmgkkhgoa" # JSON Formatter
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "mlomiejdfkolichcflejclcbmpeaniij" # Ghostery
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "dbfoemgnkgieejfkaddieamagdfepnff" # 2fas two-factor authenticator
      ];
      commandLineArgs = [
        "--homepage='tweakers.net'"
        "--force-dark-mode"
        "--ozone-platform-hint=auto"
      ];
    };
  };
}
