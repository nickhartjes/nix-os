{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
     jetbrains.idea-ultimate # IDE
  ];
}
