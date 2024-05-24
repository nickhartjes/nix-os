{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
    nodejs
    nodePackages.npm
    yarn
    bun
    cypress

  ];

  home.file.".npmrc".source = ./source/.npmrc;
}
