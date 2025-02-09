{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
    bun
    cypress
    nodejs_22
    nodePackages.npm
    npm-check-updates
    pnpm
    yarn
  ];

  home.file.".npmrc".source = ./source/.npmrc;
}
