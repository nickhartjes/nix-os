{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
    nodejs_22
    nodePackages.npm
    npm-check-updates
    yarn
    bun
    cypress

  ];

  home.file.".npmrc".source = ./source/.npmrc;
}
