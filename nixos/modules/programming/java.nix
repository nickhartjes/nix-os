{pkgs, lib, config, ...}:
{
  home.packages = with pkgs; [       # Packages installed
    gradle
  ];

    programs = {
      java = {
        enable = true;
        package = pkgs.jdk21;
      };
    };

    home.file.".jdk/jdk21" = {
      source = pkgs.jdk21;
    };

    home.file.".jdk/jdk23" = {
      source = pkgs.jdk23;
    };
}
