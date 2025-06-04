{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [
    zsh
    zoxide
  ];
}
