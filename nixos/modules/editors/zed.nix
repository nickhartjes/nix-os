{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
     zed-editor # IDE
  ];
}


