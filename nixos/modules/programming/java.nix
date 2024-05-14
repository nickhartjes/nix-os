{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
    #jdk11_headless
  ];

    programs = {
      java = {
        enable = true;
        package = pkgs.jdk21;
      };
    };
}
