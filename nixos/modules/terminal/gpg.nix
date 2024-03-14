#
# GPG
#

{
  programs = {
    gpg = {
      enable = true;
    };
  };
  services = {
    gpg-agent = {
        enable = true;
        #pinentryPackage = with pkgs; [ 
        #  "curses"
        #];
    };
  };
}
