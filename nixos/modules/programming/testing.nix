#
{ pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
    k6
    playwright
  ];
}
