{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
    tenv
    # opentofu
  ];

}
