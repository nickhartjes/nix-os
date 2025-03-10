{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
  ];

  programs = {
    git = {
      enable = true;
      userName = "Nick Hartjes";
      userEmail = "nick@hartj.es";
      signing = {
        key = "0x867E914AE4D917A6";
        signByDefault = true;
      };
      extraConfig = {
        init.defaultBranch = "main";
        url."https://github.com/".insteadOf = [ "gh:" "github:" ];
        push.autoSetupRemote = true;
      };
    };
    git-worktree-switcher = {
      enable = true;
    };
  };
}
