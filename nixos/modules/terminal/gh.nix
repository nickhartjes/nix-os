#
# GH
#

{pkgs, lib, config, ...}:
{
  programs = {
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        editor = "vim";
        prompt = "enabled";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
          rle = "repo list EnergyExchangeEnablersBV";
          rln = "repo list nickhartjes";
        };
      };

    };
  };

  home.file.".config/gh/hosts.yml".source = ./source/hosts.yml;
  home.file.".ssh/id_ed25519_github_cli".source = ./source/id_ed25519;
  home.file.".ssh/id_ed25519_github_cli.pub".source = ./source/id_ed25519.pub;
}
