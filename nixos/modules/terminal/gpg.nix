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
        pinentryFlavor = "curses";
    };
  };
}
