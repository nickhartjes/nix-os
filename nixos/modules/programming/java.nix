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

    home.file.".jdks/jdk11" = {
      source = pkgs.jdk11;
    };

    home.file.".jdks/jdk17" = {
      source = pkgs.jdk17;
    };

    home.file.".jdks/jdk21" = {
      source = pkgs.jdk21;
    };

    home.file.".jdks/jdk23" = {
      source = pkgs.jdk23;
    };

    home.file.".jdks/jetbrains-jdk" = {
      source = pkgs.jetbrains.jdk;
    };

}


