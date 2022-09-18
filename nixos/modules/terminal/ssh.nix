#
# SSH
#

{pkgs, lib, config, ...}:
{
  programs = {
    ssh = {
      enable = true;

    };
  };

  home.file.".ssh/id_ed25519".source = ./source/id_ed25519;
  home.file.".ssh/id_ed25519.pub".source = ./source/id_ed25519.pub;

  home.file.".ssh/id_rsa_ubuntu".source = ./source/id_rsa_ubuntu;
  home.file.".ssh/id_rsa_ubuntu.pub".source = ./source/id_rsa_ubuntu.pub;
}
